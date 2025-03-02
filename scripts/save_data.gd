extends Node2D

var gold = 1000
var skill_tree = []

const PATH = "user://player_data.cfg"
@onready var config = ConfigFile.new()

func _ready() -> void:
	load_data()

func set_data():
	config.set_value("player", "gold", gold)
	config.set_value("player", "skill_tree", skill_tree)

func save_data():
	config.save(PATH)

func set_and_save():
	set_data()
	save_data()

func load_data():
	if config.load(PATH) != OK:
		set_and_save()
	
	gold = config.get_value("player", "gold", 1000)
	skill_tree = config.get_value("player", "skill_tree", [])
