extends VBoxContainer

@export var weapons : HBoxContainer
@export var passive_items : HBoxContainer
var option_slot_preload = preload("res://scenes/UI/option_slot.tscn")

@export var panel : NinePatchRect
@export var particle : GPUParticles2D

const weapon_path : String = "res://resources/weapon/"
const passive_item_path : String = "res://resources/item/passive_item/"

var every_weapons
var every_passive_items
var every_items

func _ready():
	hide()
	panel.hide()
	particle.hide()
	get_all_items()

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
	
	var available = get_equipped_item()
	if slot_available(weapons):
		available.append_array(get_upgradable(every_weapons, get_equipped_item()))
	if slot_available(passive_items):
		available.append_array(get_upgradable(every_passive_items, get_equipped_item()))
	available.shuffle()

	var option_size = 0
	
	var chance = randf()
	var modifier : int = 1 if (chance < owner.luck) else 0
	
	for i in range(3 + modifier):
		if available.size() > 0:
			option_size += add_option(available.pop_front())
	
	if option_size == 0:
		return
	
	show()
	panel.show()
	particle.show()
	get_tree().paused = true

func slot_available(items):
	for item in items.get_children():
		if item.item == null:
			return true
	return false

func get_upgradable(items, flag = []):
	var array = []
	
	for item in items:
		if item.is_upgradable() and item not in flag:
			array.append(item)
	return array

func get_equipped_item():
	var equipped_item = get_available_resource_in(weapons)
	equipped_item.append_array(get_available_resource_in(passive_items))
	
	return get_upgradable(equipped_item)

func get_all_items():
	every_weapons = dir_contents(weapon_path)
	every_passive_items = dir_contents(passive_item_path)
	
	every_items = every_weapons.duplicate()
	every_items.append_array(every_passive_items)

func add_weapon(item):
	for slot in weapons.get_children():
		if slot.item == null:
			slot.item = item
			return

func add_passive_item(item):
	for slot in passive_items.get_children():
		if slot.item == null:
			slot.item = item
			return

func check_item(item): 
	if item in get_available_resource_in(weapons) or item in get_available_resource_in(passive_items):
		return
	else:
		if item is Weapon:
			add_weapon(item)
		elif item is PassiveItem:
			add_passive_item(item)

func get_available_upgrades() -> Array[Item]:
	var upgrades : Array[Item] = []
	
	for weapon : Weapon in get_available_resource_in(weapons):
		if weapon.is_upgradable() or (weapon.max_level_reached() and weapon.item_needed in get_available_resource_in(passive_items)):
			upgrades.append(weapon)
	
	for passive_item : PassiveItem in get_available_resource_in(passive_items):
		if passive_item.is_upgradable():
			upgrades.append(passive_item)
	
	return upgrades

func dir_contents(path):
	var dir = DirAccess.open(path)
	var item_resources = []
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			var item_resource : Item = load(path + file_name)
			item_resources.append(item_resource)
			file_name = dir.get_next()
	else:
		return null
	return item_resources
