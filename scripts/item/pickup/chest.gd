extends NinePatchRect

@onready var chest: AnimatedSprite2D = $AnimatedSprite2D
@onready var options: VBoxContainer = %options
@onready var rewards: Control = $rewards

const base_drop_chance = [0.7, 0.2, 0.1] # Rare, Epic, Legendary

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
	var chance = randf()
	
	if chance < get_modified_chance(0):
		upgrade_items(2, 3)
	elif chance < get_modified_chance(1):
		upgrade_items(1, 4)
	else:
		upgrade_items(0, 5)

func upgrade_items(start, end):
	for index in range(start, end):
		var upgrades = options.get_available_upgrades()
		
		if upgrades.size() == 0:
			add_gold(index)
		else:
			var selected_upgrade : Item
			selected_upgrade = upgrades.pick_random()
			
			if selected_upgrade is Weapon and selected_upgrade.max_level_reached():
				rewards.get_child(index).texture = selected_upgrade.evolution.icon
			else:
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

func get_modified_chance(index):
	var modified_chance = base_drop_chance.duplicate()
	var sum = 0

	if owner.current_boosted_tier != owner.BOOSTED_TIER.NONE:
		modified_chance[owner.current_boosted_tier] += owner.current_boosted_value
	
	for i in range(modified_chance.size()):
		if i != 0:
			modified_chance[i] *= (1 + owner.luck)
		sum += modified_chance[i]
	
	var cumulative = 0.0
	
	for i in range(index + 1):
		cumulative += modified_chance[i]

	return float(cumulative)/sum