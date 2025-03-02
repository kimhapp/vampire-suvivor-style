extends Button

func _ready() -> void:
	visible = false

func _on_pressed() -> void:
	get_tree().paused = false
	SaveData.gold += owner.gold
	SaveData.set_and_save()
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
