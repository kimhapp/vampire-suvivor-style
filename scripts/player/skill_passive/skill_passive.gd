extends Node2D

@export var all_passive_skills : Array[SkillPassive]
var active_passive_skills : Array[SkillPassive]

func set_passive_status(player):
	for skill in all_passive_skills:
		if skill in active_passive_skills:
			skill.activate(player)
		else:
			skill.disable()
