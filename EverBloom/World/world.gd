extends Node2D

const plant = preload("res://Plants/Plant.tscn")
@onready var world = $"."
@onready var floor = $Floor
@onready var player = $player
#coordinate list for all the plants 
var coordList = []
# makes a variable to recieve the signal from hotbar
var hotbarSelected = 2;

func _input(event):
	if event.is_action("Plant"):
		#flag to see if there is already plant on that tile
		var flag = true
		#gets the players position on the tile map
		var coord = to_local(Vector2(player.position.x,player.position.y))
		coord = floor.local_to_map(coord)
		#checks to see if there is a plant whos coordinates are that tile
		for plantCoord in coordList:
			if plantCoord[0] == coord:
				flag = false
		#if there isnt a plant and the tile is tilled dirt
		if floor.get_cell_atlas_coords(2, coord) == Vector2i(1,1) and flag:
			coord = floor.map_to_local(coord)
			#create a plant instance
			var plant1 = plant.instantiate()
			#set coords
			plant1.position = coord
			#add it as a child of the world and at it to the group "plants" for saving
			world.add_child(plant1)
			plant1.add_to_group("Plants")
			coordList.append([floor.local_to_map(coord), plant1])

	if event.is_action_pressed("collect"):
		#get the players coordinates
		var coord = to_local(Vector2(player.position.x,player.position.y))
		coord = floor.local_to_map(coord)
		#if the player is standing on a plant
		for x in range(len(coordList)):
			if coordList[x][0] == coord:
				#if its harvestable remove it from the game and remove it at the list and break
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
			#change the tile in the tile map and call the autotile operation
			if floor.get_cell_source_id(1, coord) != 0:
				floor.set_cell(2, coord, 6, Vector2(1,1))
				floor.set_cells_terrain_connect(2, [coord], 0, 0)

