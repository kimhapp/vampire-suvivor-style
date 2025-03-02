extends Weapon
class_name SingleShot

func shoot(source, target, scene_tree):
	
	if target == null or scene_tree.paused == true:
		return
	
	SoundManager.play_sfx(sound)
	var projectile = projectile_node.instantiate()
	
	var source_pos = source.global_position
	var target_pos = target.global_position
	
	projectile.find_child("Sprite2D").texture = projectile_texture
	projectile.position = source_pos
	projectile.damage = damage
	projectile.speed = speed
	projectile.source = source
	projectile.direction = (target_pos - source_pos).normalized()
	
	scene_tree.current_scene.add_child(projectile)

func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)

func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		return
	
	if not is_upgradable():
		return
	
	var upgrade = upgrades[level - 1]
	
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	speed += upgrade.speed
	
	level += 1
