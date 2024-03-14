extends Control
#start menu

func _on_start_pressed():
	get_tree().change_scene_to_file("res://menus/select_world.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
