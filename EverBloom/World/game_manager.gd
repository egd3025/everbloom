extends Node

##GameManager node: This is a class that manages the game scene.  It listens into the 
##scene to see if it is always paused. It is set to always running to listen to 
##changes in the game scene.
class_name GameManager

signal toggle_game_paused(is_paused : bool)
##game_paused: This method is boolean that checks the pause/live state of the game. 
##This creates a variable that is able to change the scene state to paused.
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)
	
func _input(event : InputEvent):
	if(event.is_action_pressed("ui_cancel")):
		game_paused = !game_paused
