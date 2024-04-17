extends Node2D

const plant = preload("res://Plants/Plant.tscn")
@onready var world = $"."
@onready var floor = $Floor
@onready var player = $player
@onready var saving_time = $Saving_Time

var save_pathPlayer = "user://variable.save"
var save_tileMap = "user://map.json"
var save_Plants = "user://plants.json"
var save_Inv = "user://inventory.json"
#coordinate list for all the plants 
var coordList = []
# makes a variable to recieve the signal from hotbar
var hotbarSelected = 1;

func _ready():
	var file = FileAccess.open(save_pathPlayer, FileAccess.READ)
	if file.get_length() != 0:
		saving_time.load_game()
		saving_time.load_Map()
		saving_time.loadPlants()
		player.loadInv()
		print("GAME LOADED")
	file.close()

func _input(event):
	if event.is_action("Plant"):
		if hotbarSelected == 4:
			# Check if we are holding seeds to plant first
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
		saving_time.savePlayer()
		saving_time.saveTileMap()
		saving_time.savePlants()
		player.saveInv()
		print("GAME SAVED")
		get_tree().paused = not get_tree().paused
		get_tree().change_scene_to_file("res://Pause Menu.tscn")
		
	if Input.is_action_just_pressed("inventory"):
		saving_time.savePlayer()
		saving_time.saveTileMap()
		saving_time.savePlants()
		player.saveInv()
		print("GAME SAVED")
		get_tree().change_scene_to_file("res://Inventory/inventory_ui.tscn")
		
	if event.is_action("till"):
		# check that hotbar is correct for tilling
		if hotbarSelected == 2:
			# if so, continue. If not do nothing
			var coord = to_local(Vector2(player.position.x,player.position.y))
			coord = floor.local_to_map(coord)
			var coordList = []
			#change the tile in the tile map and call the autotile operation
			
			if floor.get_cell_atlas_coords(1, coord) != Vector2i(1,0):
				if floor.get_cell_atlas_coords(1, coord) != Vector2i(0,0):
					floor.erase_cell(1, coord)
					floor.set_cell(2, coord, 6, Vector2(1,1))
					floor.set_cells_terrain_connect(2, [coord], 0, 0)


# Functions to process signal from hotbar
func _on_hotbar_selected_num_1():
	# selected slot 1, matches hotbar variable
	hotbarSelected = 1;


func _on_hotbar_selected_num_2():
	# selected slot 2, matches hotbar variable
	hotbarSelected = 2;


func _on_hotbar_selected_num_3():
	# selected slot 3, matches hotbar variable
	hotbarSelected = 3;


func _on_hotbar_selected_num_4():
	# selected slot 4, matches hotbar variable
	hotbarSelected = 4;
