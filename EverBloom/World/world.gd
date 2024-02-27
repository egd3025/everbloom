extends Node2D


const plant = preload("res://Plants/Plant.tscn")
@onready var world = $"."
@onready var player = $player
@onready var floor = $Floor
var  x = 50
var  y = 50
var coordArray = []
func _ready():
	pass

# Called when the node enters the scene tree for the first time.
func _input(event):
		
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
		if floor.get_cell_source_id(2, tilePositon) != 5:
			if floor.get_cell_atlas_coords(1, tilePositon) != Vector2i(0,0) and floor.get_cell_atlas_coords(1, tilePositon) != Vector2i(1,0):
				floor.set_cell(1, tilePositon, 4, Vector2i(1,1))
				coordArray.append(tilePositon)
				floor.set_cells_terrain_connect(1, coordArray, 0, 0)

	
	if event.is_action("Plant"):
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

		if floor.get_cell_atlas_coords(1, tilePositon) == Vector2i(1,1) and floor.get_cell_source_id(1, tilePositon) == 4:

			var plant1 = plant.instantiate()
			plant1.position = floor.map_to_local(tilePositon)
			world.add_child(plant1)
			
			
		
