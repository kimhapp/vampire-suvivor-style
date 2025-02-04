extends CharacterBody2D

@export var player_reference : CharacterBody2D
var speed : float = 75
var direction : Vector2
var damage : float
var knockback : Vector2

var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://shaders/rainbow.tres")
			damage = damage * 1.25
			scale = Vector2(1.5, 1.5)

var type : enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage

func _physics_process(delta: float) -> void:
	var seperation = (player_reference.position - position).length()
	if seperation >= 500 and not elite:
		queue_free()
	
	velocity = (player_reference.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback
	
	var collider = move_and_collide(velocity * delta)
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position -
		global_position).normalized() * 50
