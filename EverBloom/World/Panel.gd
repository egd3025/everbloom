# gdlint: disable=format checks
# gdlint: disable=class checks

extends Panel



@onready var player = $"../player"
@onready var floor = $"../Floor"
@onready var world = $".."

const plant = preload("res://Plants/Plant.tscn")

var save_pathPlayer = "user://variable.save"
var save_tileMap = "user://map.json"
var save_Plants = "user://plants.json"
var save_Inv = "user://inventory.json"


func _ready():
	pass

func _process(delta):
	pass

func _on_save_pressed():
	savePlayer()
	saveTileMap()
	savePlants()
	#saveInv()
	print("GAME SAVED")


func _on_load_pressed():
	load_game()
	load_Map()
	loadPlants()
	print("GAME LOADED")


func saveTileMap():
	#opens the save file
	var file = FileAccess.open(save_tileMap, FileAccess.WRITE)
	#creates a dict
	var data = {}
	data["tiles"] = []
	#for each tile in each layer, save the data that makes it that specific tile 
	for layer in range(floor.get_layers_count()):
		for cell in floor.get_used_cells(layer):
			var tileAtlas = floor.get_cell_atlas_coords(layer, Vector2i(cell.x,cell.y))
			var tileSource = floor.get_cell_source_id(layer, Vector2i(cell.x,cell.y))
			data["tiles"].append({"x": cell.x, "y": cell.y, "tileAtlas.x": tileAtlas.x, "tileAtlas.y": tileAtlas.y, "tileSource": tileSource, "layer": layer})
	
	#store it as a json file
	file.store_line(JSON.stringify(data))
	
func savePlayer():
	#saves the position of the player 
	var file = FileAccess.open(save_pathPlayer, FileAccess.WRITE)
	file.store_var(player.position.x)
	file.store_var(player.position.y)
	
	
func savePlants():
	#opens the file
	var file = FileAccess.open(save_Plants, FileAccess.WRITE)
	#create the dictionary to save data
	var data = {}
	data["plants"] = []
	#for each plant in the group "plant" save the stage and coordinates and the time left on the timer
	for plant in get_tree().get_nodes_in_group("Plants"):
		var stage = plant.stage
		data["plants"].append({"x": plant.position.x, "y": plant.position.y, "stage": stage, "time": plant.getTimerLeft()})
	#save the data as a json
	file.store_line(JSON.stringify(data))
	

func loadPlants():

	#opens the file
	var file = FileAccess.open(save_Plants, FileAccess.READ)
	if file.get_length() != 0:
		world.coordList = []
	#removes all the plants from the world
		for plant in get_tree().get_nodes_in_group("Plants"):
			plant.queue_free()
		var data = JSON.parse_string(file.get_line())
		#creates a new plant coordinate list
		var coordList = []
		#loads in the all the data for each plant
		#it then creates a plant for each one saved and gives it
		#that respective data
		for tile_data in data["plants"]:
			var x = tile_data["x"]
			var y = tile_data["y"]
			var stage = tile_data["stage"]
			var timeLeft = tile_data["time"]
			var plant1 = plant.instantiate()
			plant1.position.x = x
			plant1.position.y = y
			
			#add it to the coordinate list
			var coord = floor.to_local(Vector2(x,y))
			coord = floor.local_to_map(coord)
			world.coordList.append([coord, plant1])
			#set the stages and time and adds it to the group and as a child of the world
			plant1.set_stage(stage)
			plant1.add_to_group("Plants")
			plant1.setTimerLeft(timeLeft)
			world.add_child(plant1)
		

func load_game():
	#loads the player
	if FileAccess.file_exists(save_pathPlayer):
		var file = FileAccess.open(save_pathPlayer, FileAccess.READ)
		if file.get_length() != 0:
			player.position.x = file.get_var(player.position.x)
			player.position.y = file.get_var(player.position.y)
			
			while file.get_position() != file.get_length():
				floor.set_cell()
		else:
			print("No save Data")
		
func load_Map():
	#loads the saved tile map
	#it clears the floor

	var file = FileAccess.open(save_tileMap, FileAccess.READ)
	if file.get_length() != 0:
		floor.clear()
		var data = JSON.parse_string(file.get_line())
		#loops for each tile, creates a tile in that coordinate with its respective data
		for tile_data in data["tiles"]:
			var x = tile_data["x"]
			var y = tile_data["y"]
			var tileAtlasX = tile_data["tileAtlas.x"]
			var tileAtlasY = tile_data["tileAtlas.y"]
			var tileSource = tile_data["tileSource"]
			var layer = tile_data["layer"]
			floor.set_cell(layer, Vector2i(x,y), tileSource, Vector2i(tileAtlasX,tileAtlasY))
		
	
		
	
		
		
