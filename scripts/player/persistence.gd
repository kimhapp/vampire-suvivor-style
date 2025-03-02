extends Node2D

@onready var bonus_stats : Stats = Stats.new()

func gain_bonus_stats(player):
	player.max_health += bonus_stats.max_health
	player.recovery += bonus_stats.recovery
	player.armor += bonus_stats.armor
	player.shield += bonus_stats.shield
	player.movement_speed  += bonus_stats.movement_speed
	player.attack_range += bonus_stats.attack_range
	player.magnet += bonus_stats.magnet
	player.growth += bonus_stats.growth
	player.dmg_multiplier += bonus_stats.dmg_multiplier
