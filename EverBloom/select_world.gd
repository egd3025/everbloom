extends Control

##select menu: menu for the select world, which just starts the world that is saved or a
## new world if no save is available.  There is also a back function to go to the 
## start menu.


func _on_start_world_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_new_world_pressed():
	var save_pathPlayer = "user://variable.save"
	var save_tileMap = "user://map.json"
	var save_Plants = "user://plants.json"
	var save_Inv = "user://inventory.json"
	


func _on_back_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")
