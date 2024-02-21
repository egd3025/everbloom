extends Control


func _on_resume_button_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")
	
func _on_inventory_button_pressed():
	pass
	
func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
