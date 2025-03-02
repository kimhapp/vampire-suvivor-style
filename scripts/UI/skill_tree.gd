extends Panel

var skill_tree
var total_stats : Stats

func _ready() -> void:
	load_skill_tree()

func set_skill_tree():
	skill_tree = []
	
	for each_branch in get_children():
		var branch = []
		
		for upgrade in each_branch.get_children():
			branch.append(upgrade.enabled)
		skill_tree.append(branch)
	
	SaveData.skill_tree = skill_tree
	SaveData.set_and_save()

func add_stats(stats):
	total_stats.max_health += stats.max_health
	total_stats.recovery += stats.recovery
	total_stats.armor += stats.armor
	total_stats.shield += stats.shield
	total_stats.movement_speed  += stats.movement_speed
	total_stats.attack_range += stats.attack_range
	total_stats.magnet += stats.magnet
	total_stats.growth += stats.growth
	total_stats.dmg_multiplier += stats.dmg_multiplier

func load_skill_tree():
	if SaveData.skill_tree == []:
		set_skill_tree()
	
	skill_tree = SaveData.skill_tree
	
	for branch in get_children():
		for upgrade in branch.get_children():
			upgrade.enabled = skill_tree[branch.get_index()][upgrade.get_index()]
	get_total_stats()

func get_total_stats():
	total_stats = Stats.new()
	
	for branch in get_children():
		for upgrade in branch.get_children():
			if upgrade.enabled == true:
				add_stats(upgrade.skill.stats)
	Persistence.bonus_stats = total_stats
