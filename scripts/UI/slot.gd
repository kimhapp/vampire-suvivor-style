extends PanelContainer

@export var item : Weapon:
	set(value):
		if item != null and item.has_method("reset"):
			item.reset()
		
		item = value
		$TextureRect.texture = value.icon
		$cooldown.wait_time = value.cooldown
		item.slot = self

func _physics_process(delta: float) -> void:
	if item != null and item.has_method("update"):
		item.update(delta)

func _on_cooldown_timeout() -> void:
	if item:
		$cooldown.wait_time = item.cooldown
		item.activate(owner, owner.pivot, get_tree())
