extends Control

#select menu


func _on_start_world_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_new_world_pressed():
	pass # Replace with function body.


func _on_back_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")
