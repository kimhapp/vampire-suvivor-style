extends CharacterBody2D

enum BOOSTED_TIER {NONE, EPIC, LEGENDARY} # For drop chance boosting

var movement_speed : float = 150
var health : float = 10:
	set(value):
		health = value
		%health.value = value
		
		if health <= 0:
			get_tree().paused = true
			%back.visible = true
var max_health : float = 100:
	set(value):
		max_health = value
		%health.max_value = value
var recovery : float = 0:
	set(value):
		recovery = value
		%recovery.text = "R : " + str(value)
var armor : float = 0:
	set(value):
		armor = value
		%armor.text = "A : " + str(value)
var shield : float = 0
var dmg_multiplier : float = 1.0:
	set(value):
		dmg_multiplier = value
		%dmg_multiplier.text = "D : " + str(value)
var attack_range : float = 150
var magnet : float = 0:
	set(value):
		magnet = value
		%magnet.shape.radius = 50 + value
var growth : float = 1.0
var luck : float = 0.5
var current_boosted_tier : BOOSTED_TIER
var current_boosted_value : float = 0.0

var gold : int = 0:
	set(value):
		gold = value
		%gold.text = "Gold " + str(value)

var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
var total_XP : int = 0
var level : int = 1:
	set(value):
		level = value
		%level.text = "Lvl " + str(value)
		%options.show_option()

		if level >= 3:
			%XP.max_value = 20
		elif level >= 7:
			%XP.max_value = 40

var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float = attack_range

@onready var pivot: Marker2D = $cursor/Cursor/pivot

var direction : Vector2 # For flipping sprite

func _ready() -> void:
	health = max_health
	Persistence.gain_bonus_stats(self)

func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
	else:
		nearest_enemy_distance = attack_range
		nearest_enemy = null

	velocity = Input.get_vector("left", "right", "up", "down") * movement_speed
	move_and_collide(velocity * delta)
	check_XP()
	health += recovery * delta

func take_damage(amount):
	# Armor will only reduce 90% of incoming dmg max
	health -= max(amount * (amount / (amount + armor)), amount * 0.1)

func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

func _on_timer_timeout() -> void:
	%collision.set_deferred("disabled", true)
	%collision.set_deferred("disabled", false)

func gain_XP(amount):
	XP += amount * growth
	total_XP += amount * growth

func check_XP():
	if XP >= %XP.max_value:
		XP -= %XP.max_value
		level += 1

func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)

func gain_gold(amount):
	gold += amount

func open_chest():
	$UI/chest.open()
