extends Node2D

const plant = preload("res://Plants/Plant.tscn")
@onready var world = $"."
@onready var floor = $Floor
@onready var player = $player
var coordList = []
# makes a variable to recieve the signal from hotbar
var hotbar;
var hotbarSelected = 1; # a variable we can play with

func _ready():
	# recieve the signals from hotbar and send them to the
	# update function with correct parameter
	hotbar.selectedNum_1.connect(hotbarUpdate(1));
	hotbar.selectedNum_2.connect(hotbarUpdate(2));
	hotbar.selectedNum_3.connect(hotbarUpdate(3));
	hotbar.selectedNum_4.connect(hotbarUpdate(4));
	
func hotbarUpdate(num):
	# makes the hotbar variable match the actual selected slot
	hotbarSelected = num;
	
func _input(event):
	if event.is_action("Plant"):
		var flag = true
		var coord = to_local(Vector2(player.position.x,player.position.y))
		coord = floor.local_to_map(coord)
		
		for plantCoord in coordList:
			if plantCoord[0] == coord:
				flag = false
	
		if floor.get_cell_atlas_coords(2, coord) == Vector2i(1,1) and flag:
			coord = floor.map_to_local(coord)
			var plant1 = plant.instantiate()
			plant1.position = coord
			world.add_child(plant1)
			plant1.add_to_group("Plants")
			coordList.append([floor.local_to_map(coord), plant1])
			print(coordList)

	if event.is_action_pressed("collect"):
		var coord = to_local(Vector2(player.position.x,player.position.y))
		coord = floor.local_to_map(coord)
		for x in range(len(coordList)):
			if coordList[x][0] == coord:
				if coordList[x][1].stage > 4:
					coordList[x][1].queue_free()
					coordList.remove_at(x)
					break
		
			
		
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		get_tree().change_scene_to_file("res://Pause Menu.tscn")
		
	if Input.is_action_just_pressed("inventory"):
		get_tree().change_scene_to_file("res://Inventory/inventory_ui.tscn")
		
	if event.is_action("till"):
		# check that hotbar is correct for tilling
		if hotbarSelected == 2:
			# if so, continue. If not do nothing
			var coord = to_local(Vector2(player.position.x,player.position.y))
			coord = floor.local_to_map(coord)
			var coordList = []
			if floor.get_cell_source_id(1, coord) != 0:
				floor.set_cell(2, coord, 6, Vector2(1,1))
				floor.set_cells_terrain_connect(2, [coord], 0, 0)

