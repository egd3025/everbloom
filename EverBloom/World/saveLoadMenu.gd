extends VBoxContainer

@export var game_manager : GameManager

func _on_game_manager_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	game_manager.connect("toggel_game_pause", _on_game_manager_toggle_game_paused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		show()



func _on_resume_pressed():
	hide()


func _on_exit_pressed():
	get_tree().quit()
