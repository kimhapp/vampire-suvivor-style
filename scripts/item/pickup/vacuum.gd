extends Pickups
class_name Vacuum

func activate():
	super.activate()
	player_reference.get_tree().call_group("pickups", "follow", player_reference, true)
