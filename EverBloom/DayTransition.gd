extends Control

# controls for the Day Transition menu


func _on_resume_button_pressed():
	# Return to the main game scene
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
