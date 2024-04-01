extends Control
@onready var saving_time = $"../../Saving_Time"
@export var game_manager : GameManager


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	game_manager.connect("toggle_game_paused" , _on_game_manager_toggle_game_paused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_game_manager_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()


func _on_resume_button_pressed():
	game_manager.game_paused = false


func _on_save_button_pressed():
	saving_time.savePlayer()
	saving_time.saveTileMap()
	saving_time.savePlants()
	saving_time.saveInv()
	print("GAME SAVED")


func _on_load_button_pressed():
	saving_time.load_game()
	saving_time.load_Map()
	saving_time.loadPlants()
	saving_time.loadInv()
	print("GAME LOADED")


func _on_exit_button_pressed():
	get_tree().quit()
