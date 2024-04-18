extends Control
##esc_menu 
##this only changes to other scenes
##currently is set to pause menu or start menu
func _on_back_pressed():
	if get_tree().paused:
		get_tree().change_scene_to_file("res://Pause Menu.tscn")
	else:
		get_tree().change_scene_to_file("res://start_menu.tscn")


func _on_volume_pressed():
	pass # Replace with function body.



