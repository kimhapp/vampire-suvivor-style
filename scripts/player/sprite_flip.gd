extends Marker2D

func  _process(_delta: float) -> void:
	owner.direction = get_global_mouse_position() - owner.position
	
	if owner.direction.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
