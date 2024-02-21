extends Control


func _on_resume_button_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene_to_file("res://World/world.tscn")
	
func _on_inventory_button_pressed():
	pass
	
func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _input(event):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		get_tree().change_scene_to_file("res://World/world.tscn")
