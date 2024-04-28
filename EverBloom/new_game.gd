extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#this will over write the current save file by just writing to the file
#it just makes empty files
func _on_new_world_button_pressed():
	var save_pathPlayer = "user://variable.save"
	var save_tileMap = "user://map.json"
	var save_Plants = "user://plants.json"
	var save_Inv = "user://inventory.json"
	var save_hotbar = "user://hotbar.json"
	
	var file = FileAccess.open(save_pathPlayer, FileAccess.WRITE)
	var file1 = FileAccess.open(save_Inv, FileAccess.WRITE)
	var file2 = FileAccess.open(save_tileMap, FileAccess.WRITE)
	var file3 = FileAccess.open(save_Plants, FileAccess.WRITE)
	var file4 = FileAccess.open(save_hotbar, FileAccess.WRITE)
	file.close()
	file1.close()
	file2.close()
	file3.close()
	file4.close()
	print("NEW GAME STARTED")
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://select_world.tscn")
