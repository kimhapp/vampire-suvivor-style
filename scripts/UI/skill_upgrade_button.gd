extends TextureButton

var audio_path : String
@export var skill : Skill

var enabled : bool = false :
	set(value):
		enabled = value
		$Panel.show_behind_parent = value
		
		if value:
			$outline.add_point(Vector2(0, -1))
			$outline.add_point(Vector2(40, -1))
			$outline.add_point(Vector2(40, 39))
			$outline.add_point(Vector2(0, 39))
		
		if value == true and get_index() != 0:
			$connection.add_point(Vector2(20, 20) + initial_modifier())
			$connection.add_point(get_parent().get_child(get_index() - 1).position - position + Vector2(20, 20) + final_modifier())

func _ready():
	if skill:
		texture_normal = skill.icon

func is_upgradable() -> bool:
	if get_index() == 0:
		return true
	elif get_index() > 0:
		if get_parent().get_child(get_index() - 1).enabled == true:
			return true
		else:
			return false
	
	return false

func _on_pressed() -> void:
	if skill.cost <= SaveData.gold and is_upgradable() and not enabled:
		if skill.tier == skill.SKILL_TIER.Rare:
			audio_path = "res://assets/sfx/ui/upgrade_basic_tier.mp3"
		elif skill.tier == skill.SKILL_TIER.Epic:
			audio_path = "res://assets/sfx/ui/upgrade_mid_tier.mp3"
		else:
			audio_path = "res://assets/sfx/ui/upgrade_high_tier.mp3"
		
		SoundManager.play_sfx(load(audio_path), true)
		SaveData.gold -= skill.cost
		enabled = true
		get_parent().get_parent().set_skill_tree()
		get_parent().get_parent().get_total_stats()

func initial_modifier() -> Vector2:
	var difference = get_parent().get_child(get_index() - 1).position - position
	var modification : Vector2 = Vector2.ZERO
	
	if difference.x < 0:
		modification += Vector2(-20, 0)
	elif difference.x > 0:
		modification += Vector2(20, 0)
	
	if difference.y < 0:
		modification += Vector2(0, -20)
	elif difference.y > 0:
		modification += Vector2(0, 20)
	
	return modification

func final_modifier() -> Vector2:
	var difference = get_parent().get_child(get_index() - 1).position - position
	var modification : Vector2 = Vector2.ZERO
	
	if difference.x < 0:
		modification += Vector2(20, 0)
	elif difference.x > 0:
		modification += Vector2(-20, 0)
	
	if difference.y < 0:
		modification += Vector2(0, 20)
	elif difference.y > 0:
		modification += Vector2(0, -20)
	
	return modification
