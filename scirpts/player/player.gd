extends CharacterBody2D

var speed : float = 150
var health : float = 100:
	set(value):
		health = value
		%health.value = value

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_collide(velocity * delta)

func take_damage(amount):
	health -= amount
	print(amount)

func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

func _on_timer_timeout() -> void:
	%collision.set_deferred("disabled", true)
	%collision.set_deferred("disabled", false)
