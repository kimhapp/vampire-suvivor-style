extends Resource
class_name SkillPassive

@export var title : String
@export_multiline var description : String

var player_reference : CharacterBody2D
var is_active : bool = false

func activate(player):
	player_reference = player
	is_active = true

func disable():
	player_reference = null
	is_active = false
