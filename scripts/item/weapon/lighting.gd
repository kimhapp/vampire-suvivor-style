extends Weapon
class_name Lighting

@export var amount = 1
var projectiles = []

func activate(source, _target, scene_tree):
	if scene_tree.paused == true:
		return
	
	shoot(source, scene_tree)

func shoot(source : CharacterBody2D, scene_tree : SceneTree):
	var enemies = source.get_tree().get_nodes_in_group("enemy")
	
	if enemies.size() == 0:
		return
	
	SoundManager.play_sfx(sound)
	for i in range(amount):
		var enemy = enemies.pick_random()
		var projectile = projectile_node.instantiate()
		
		projectile.find_child("Sprite2D").texture = projectile_texture
		projectile.speed = 0
		projectile.damage = damage
		projectile.position = enemy.position
		projectile.source = source
		projectiles.append(projectile)
		
		scene_tree.current_scene.add_child(projectile)
	
	await scene_tree.create_timer(0.5).timeout
	
	for i in range(projectiles.size()):
		var temp = projectiles.pop_front()
		if is_instance_valid(temp):
			temp.queue_free()

func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		return
	
	if not is_upgradable():
		return
	
	var upgrade = upgrades[level - 1]
	
	amount += upgrade.amount
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	
	level += 1
