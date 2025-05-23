extends Resource
class_name Skill

enum SKILL_TIER  {Rare, Epic, Legendary, Master}

@export var name : String
@export var icon : Texture2D
@export var cost : int
@export var tier : SKILL_TIER
@export var stats : Stats
@export var skill_passive : SkillPassive
