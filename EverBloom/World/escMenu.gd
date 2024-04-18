extends Control

##saving_time and game_gamanger are needed here.  
##saving_time is being pulled into this script to use its methods.
##game_manager is being exported to, so as to pause the game.
@onready var saving_time = $"../../Saving_Time"
@export var game_manager : GameManager
@onready var player = $"../../player"

var save_pathPlayer = "user://variable.save"
var save_tileMap = "user://map.json"
var save_Plants = "user://plants.json"
var save_Inv = "user://inventory.json"

# Add reference to the World scene
var WorldScene = preload("World.tscn")

## Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	game_manager.connect("toggle_game_paused" , _on_game_manager_toggle_game_paused)


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
##shows or hides game if the world is paused
func _on_game_manager_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()

##unpauses the game and hides the esc menu otherwise
func _on_resume_button_pressed():
	game_manager.game_paused = false

## saves the different vars for each save methods
func _on_save_button_pressed():
	saving_time.savePlayer()
	saving_time.saveTileMap()
	saving_time.savePlants()
	player.saveInv()
	print("GAME SAVED")

## loads the different vars for each method in load
func _on_load_button_pressed():
	saving_time.load_game()
	saving_time.load_Map()
	saving_time.loadPlants()
	player.loadInv()
	print("GAME LOADED")

## quits the game directly 
func _on_exit_button_pressed():
	get_tree().quit()


func _on_new_world_pressed():
	var file = FileAccess.open(save_pathPlayer, FileAccess.WRITE)
	var file1 = FileAccess.open(save_Inv, FileAccess.WRITE)
	var file2 = FileAccess.open(save_tileMap, FileAccess.WRITE)
	var file3 = FileAccess.open(save_Plants, FileAccess.WRITE)
	file.close()
	file1.close()
	file2.close()
	file3.close()
	print("NEW GAME STARTED")
	get_tree().reload_current_scene()
