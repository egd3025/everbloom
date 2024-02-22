extends Node2D

const plant = preload("res://Plants/Plant.tscn")
@onready var world = $"."
@onready var player = $player
@onready var floor = $Floor

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action("Spawn"):
		var plant1 = plant.instantiate()
		plant1.position = get_global_mouse_position()
		world.add_child(plant1)
		
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		get_tree().change_scene_to_file("res://Pause Menu.tscn")
	
	if event.is_action("Till"):
		var playerLocal = player.position
		var tilePositon = floor.local_to_map(playerLocal)
		var direction = player.getLastInput()
		match direction:
			"ui_right":
				tilePositon.x += 1
			"ui_left":
				tilePositon.x -= 1
			"ui_down":
				tilePositon.y += 1
			"ui_up":
				tilePositon.y -= 1
		print(tilePositon)
		floor.set_cell(0, tilePositon, 4, Vector2i(1,1))
