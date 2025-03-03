extends Control

func _ready() -> void:
	menu()

func menu():
	$menu.show()
	$beastiary.hide()
	$skill_tree.hide()
	$back.hide()

func skill_tree():
	$menu.hide()
	$beastiary.hide()
	$skill_tree.show()
	$back.show()
	tween_pop($skill_tree)

func beastiary():
	$menu.hide()
	$beastiary.show()
	$skill_tree.hide()
	$back.show()
	tween_pop($beastiary)

func _on_upgrades_pressed() -> void:
	skill_tree()

func _on_beastiary_pressed() -> void:
	beastiary()

func _on_back_pressed() -> void:
	menu()
	tween_pop($menu, true)

func tween_pop(panel, back: bool = false):
	if back == false:
		SoundManager.play_sfx(load("res://assets/sfx/ui/ui-pop-up-243471.mp3"))
	else:
		SoundManager.play_sfx(load("res://assets/sfx/ui/ui-exit-menu-243462.mp3"))

	panel.scale = Vector2(0.85, 0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	tween.tween_property(panel, "scale", Vector2(1, 1), 0.5)
