extends VBoxContainer

const path = "res://resources/enemy/"

var enemies = []

func _ready() -> void:
	dir_contents()

func dir_contents():
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var filename = dir.get_next()
		while filename != "":
			var enemy_resources : Enemy = load(path + filename)
			enemies.append(enemy_resources)
			
			var button = Button.new()
			button.pressed.connect(_on_pressed.bind(button))
			button.text = enemy_resources.title
			add_child(button)
			
			filename = dir.get_next()
	else:
		print("An error occured")

func _on_pressed(button : Button):
	var index = button.get_index()
	%name.text = "Name: " + enemies[index].title
	%damage.text = "Damage: " + str(enemies[index].damage)
	%health.text = "Health: " + str(enemies[index].health)
	%Texture.texture = enemies[index].texture
	SoundManager.play_sfx(load("res://assets/sfx/ui/ui-pop-up-243471.mp3"), true)
