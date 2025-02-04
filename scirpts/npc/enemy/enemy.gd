extends CharacterBody2D

@export var player_reference : CharacterBody2D
var speed : float = 75
var direction : Vector2
var damage : float

var type : enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage

func _physics_process(delta: float) -> void:
	velocity = (player_reference.position - position).normalized() * speed
	move_and_collide(velocity * delta)
