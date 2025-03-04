extends Node2D

var sfx_type : String
@onready var sfx_player : AudioStreamPlayer

func play_sfx(sfx : AudioStream, ui_sfx : bool = false):
	if sfx:
		sfx_player = AudioStreamPlayer.new()
		add_child(sfx_player)
		
		sfx_player.stream = sfx
		if ui_sfx:
			sfx_type = "UI_SFX"
		else:
			sfx_type = "SFX"
		sfx_player.bus = sfx_type
		sfx_player.play()
		
		sfx_player.finished.connect(sfx_player.queue_free)
