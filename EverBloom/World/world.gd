extends Node2D

const plant = preload("res://Plants/Plant.tscn")
@onready var world = $"."
@onready var floor = $Floor
@onready var player = $player
var coordList = []
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action("Plant"):
		var flag = true
		var coord = to_local(Vector2(player.position.x,player.position.y))
		coord = floor.local_to_map(coord)
		
		for plantCoord in coordList:
			print(plantCoord, Vector2(coord.x, coord.y))
			if plantCoord == coord:
				flag = false
	
		if floor.get_cell_atlas_coords(2, coord) == Vector2i(1,1) and flag:
			coord = floor.map_to_local(coord)
			var plant1 = plant.instantiate()
			plant1.position = coord
			world.add_child(plant1)
			coordList.append(floor.local_to_map(coord))
		
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		get_tree().change_scene_to_file("res://Pause Menu.tscn")
		
	if Input.is_action_just_pressed("inventory"):
		get_tree().change_scene_to_file("res://Inventory/inventory_ui.tscn")
		
	if event.is_action("till"):
		var coord = to_local(Vector2(player.position.x,player.position.y))
		coord = floor.local_to_map(coord)
		var coordList = []
		if floor.get_cell_source_id(1, coord) != 0:
			floor.set_cell(2, coord, 6, Vector2(1,1))
			floor.set_cells_terrain_connect(2, [coord], 0, 0)

