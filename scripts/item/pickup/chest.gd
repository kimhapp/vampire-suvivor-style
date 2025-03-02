extends NinePatchRect

@onready var chest: AnimatedSprite2D = $AnimatedSprite2D
@onready var options: VBoxContainer = %options
@onready var rewards: Control = $rewards

func _ready() -> void:
	randomize()
	hide()
	$open.show()
	$close.hide()

func open():
	clear_reward()
	chest.play("idle_boss_chest")
	get_tree().paused = true
	show()
	$open.show()
	$close.hide()

func _on_open_pressed() -> void:
	chest.play("open_boss_chest")
	await chest.animation_finished
	set_reward()
	$open.hide()
	$close.show()

func _on_close_pressed() -> void:
	get_tree().paused = false
	hide()

func set_reward():
	clear_reward()
	var chance = randf_range(0, 1)
	if chance < 0.5:
		upgrade_items(0, 2)
		print("rare")
	elif chance < 0.75:
		upgrade_items(0, 3)
		print("epic")
	else:
		upgrade_items(0, 5)
		print("legendary")

func upgrade_items(start, end):
	for index in range(start, end):
		var upgrades = options.get_available_upgrades()
		
		if upgrades.size() == 0:
			add_gold(index)
		else:
			var selected_upgrade : Item
			selected_upgrade = upgrades.pick_random()
			rewards.get_child(index).texture = selected_upgrade.icon
			selected_upgrade.upgrade_item()

func clear_reward():
	for slot in rewards.get_children():
		slot.texture = null

func add_gold(index):
	var gold : Gold = load("res://resources/pickup/gold_bag.tres")
	gold.player_reference = owner
	rewards.get_child(index).texture = gold.icon
	gold.activate()
