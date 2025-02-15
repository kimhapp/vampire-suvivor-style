extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage : float = 1
var source

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		if "dmg_multiplier" in source:
			body.take_damage(damage * source.dmg_multiplier)
		else:
			body.take_damage(damage)
		
		body.knockback += direction * 120

func _on_screen_exited() -> void:
	queue_free()
