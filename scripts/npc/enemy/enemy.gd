extends CharacterBody2D

@export var player_reference : CharacterBody2D
var damage_popup_node = preload("res://scenes/npc/enemy/damage_popup.tscn")

var speed : float = 75
var direction : Vector2
var damage : float
var knockback : Vector2
var separation : float

var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://shaders/rainbow.tres")
			damage = damage * 1.25
			scale = Vector2(1.5, 1.5)

var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage

func _physics_process(delta: float) -> void:
	check_separation()
	knockback_update(delta)

func check_separation():
	separation = (player_reference.position - position).length()
	if separation >= 500 and not elite:
		queue_free()
	
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self

func knockback_update(delta):
	velocity = (player_reference.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback
	
	var collider = move_and_collide(velocity * delta)
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position -
		global_position).normalized() * 50

func damage_popup(amount):
	var popup = damage_popup_node.instantiate()
	popup.text = str(amount)
	popup.position = position + Vector2(-50,-25)
	get_tree().current_scene.add_child(popup)

func take_damage(amount):
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1, 0, 0.07), 0.2)
	tween.chain().tween_property($Sprite2D, "modulate", Color(1, 1, 1), 0.2)
	
	damage_popup(amount)
