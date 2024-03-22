extends Node2D

const plant = preload("res://Plants/Plant.tscn")
@onready var world = $"."
@onready var floor = $Floor
@onready var player = $player

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action("Spawn"):
		var plant1 = plant.instantiate()
		plant1.position = get_global_mouse_position()
		world.add_child(plant1)
		
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

