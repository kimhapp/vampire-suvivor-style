extends Pickups
class_name Death

func activate():
	super.activate()
	player_reference.get_tree().call_group("enemy", "drop_item")
