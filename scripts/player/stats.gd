extends Resource
class_name Stats

enum BOOSTED_TIER {NONE, EPIC, LEGENDARY} # For drop chance boosting

@export_multiline var description : String

# Survivability Path
@export var max_health : float
@export var recovery : float
@export var armor : float
@export var shield : float
@export var damage_reduction: float

# Offensive Path
@export var attack_range : float
@export var critical_chance: float
@export var critical_damage: float
@export var dmg_multiplier : float
@export var cast_speed: float
@export var projectile_speed: float

# Utility Path
@export var movement_speed : float 
@export var magnet : float
@export var growth : float
@export var luck: float
@export var boosted_tier : BOOSTED_TIER
@export var boosted_value : float
