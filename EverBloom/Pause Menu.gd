extends Control

# controls for the pause menu
func _on_resume_button_pressed():
	# unpauses the game and returns to the world
	get_tree().paused = not get_tree().paused
	get_tree().change_scene_to_file("res://World/world.tscn")
	
func _on_inventory_button_pressed():
	# opens the inventory
	get_tree().paused = not get_tree().paused
	get_tree().change_scene_to_file("res://Inventory/inventory_ui.tscn")
	
func _on_options_button_pressed():
	# opens the options menu
	get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_quit_button_pressed():
	# closes the game
	get_tree().quit()

func _input(event):
	# checks if "pause button" was pressed and unpauses the game
	# also returns to the world
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		get_tree().change_scene_to_file("res://World/world.tscn")
