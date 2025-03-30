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
			var chance = randf()
			
			if chance < source.critical_chance:
				body.take_damage(damage * source.dmg_multiplier * source.critical_damage) 
				source.has_crit = true
			else:
				body.take_damage(damage * source.dmg_multiplier)
				source.has_crit = false
		else:
			body.take_damage(damage)
		
		body.knockback += direction * 120

func _on_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(damage)
