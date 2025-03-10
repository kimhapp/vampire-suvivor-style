extends Label

func _process(_delta: float) -> void:
	text = "Gold: " + str(SaveData.gold)
