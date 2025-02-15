extends VBoxContainer

@export var weapons : HBoxContainer
@export var passive_items : HBoxContainer
var option_slot_preload = preload("res://scenes/UI/option_slot.tscn")

@export var panel : NinePatchRect
@export var particle : GPUParticles2D

func _ready():
	hide()
	panel.hide()
	particle.hide()

func close_option():
	hide()
	panel.hide()
	particle.hide()
	get_tree().paused = false

func get_available_resource_in(items) -> Array[Item]:
	var resources : Array[Item] = []
	for item in items.get_children():
		if item.item != null:
			resources.append(item.item)
	return resources

func add_option(item) -> int:
	if item.is_upgradable():
		var option_slot = option_slot_preload.instantiate()
		option_slot.item = item
		add_child(option_slot)
		return 1
	return 0

func show_option():
	var weapons_available = get_available_resource_in(weapons)
	var passive_items_available = get_available_resource_in(passive_items)
	if weapons_available.size() == 0 and passive_items_available.size() == 0:
		return
	
	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	
	for weapon in weapons_available:
		option_size += add_option(weapon)
		
		if weapon.max_level_reached() and weapon.item_needed in passive_items_available:
			var option_slot = option_slot_preload.instantiate()
			option_slot.item = weapon
			add_child(option_slot)
			option_size += 1
	
	for passive_item in passive_items_available:
		option_size += add_option(passive_item)
	
	if option_size == 0:
		return
	
	show()
	panel.show()
	particle.show()
	get_tree().paused = true
