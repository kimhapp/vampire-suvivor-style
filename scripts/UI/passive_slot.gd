extends PanelContainer

@export var item : PassiveItem:
	set(value):
		item = value
		$TextureRect.texture = value.icon
		value.player_reference = owner

func _ready() -> void:
	if item != null:
		item.player_reference = owner
