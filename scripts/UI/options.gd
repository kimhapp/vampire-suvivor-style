extends VBoxContainer

@export var weapons : HBoxContainer
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

func get_available_weapon():
	var weapon_resource = []
	for weapon in weapons.get_children():
		if weapon.weapon != null:
			weapon_resource.append(weapon.weapon)
	return weapon_resource

func show_option():
	var weapons_available = get_available_weapon()
	if weapons_available.size() == 0:
		return
	
	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	for weapon in weapons_available:
		if weapon.is_upgradable():
			var option_slot = option_slot_preload.instantiate()
			option_slot.weapon = weapon
			add_child(option_slot)
			option_size += 1
	
	if option_size == 0:
		return
	
	show()
	panel.show()
	particle.show()
	get_tree().paused = true
