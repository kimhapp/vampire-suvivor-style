extends Resource
class_name Stats

enum BOOSTED_TIER {NONE, EPIC, LEGENDARY} # For drop chance boosting

@export_multiline var description : String

@export var max_health : float
@export var recovery : float
@export var armor : float
@export var shield : float
@export var movement_speed : float 
@export var attack_range : float
@export var magnet : float
@export var revival : int
@export var growth : float
@export var dmg_multiplier : float
@export var boosted_tier : BOOSTED_TIER
@export var boosted_value : float
