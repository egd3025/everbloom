extends Panel



@onready var player = $"../player"
@onready var floor = $"../Floor"
@onready var world = $".."

const plant = preload("res://Plants/Plant.tscn")

var save_pathPlayer = "user://variable.save"
var save_tileMap = "user://map.json"
var save_Plants = "user://plants.json"


func _ready():
	pass

func _process(delta):
	pass





func _on_save_pressed():
	savePlayer()
	saveTileMap()
	savePlants()
	print("GAME SAVED")


func _on_load_pressed():
	load_game()
	load_Map()
	loadPlants()
	print("GAME LOADED")


func saveTileMap():
	var file = FileAccess.open(save_tileMap, FileAccess.WRITE)
	var data = {}
	
	data["tiles"] = []
	for layer in range(floor.get_layers_count()):
		for cell in floor.get_used_cells(layer):
			var tileAtlas = floor.get_cell_atlas_coords(layer, Vector2i(cell.x,cell.y))
			var tileSource = floor.get_cell_source_id(layer, Vector2i(cell.x,cell.y))
			data["tiles"].append({"x": cell.x, "y": cell.y, "tileAtlas.x": tileAtlas.x, "tileAtlas.y": tileAtlas.y, "tileSource": tileSource, "layer": layer})

	file.store_line(JSON.stringify(data))
	
func savePlayer():
	var file = FileAccess.open(save_pathPlayer, FileAccess.WRITE)
	file.store_var(player.position.x)
	file.store_var(player.position.y)
	
	
func savePlants():
	var file = FileAccess.open(save_Plants, FileAccess.WRITE)
	var data = {}
	data["plants"] = []
	for plant in get_tree().get_nodes_in_group("Plants"):
		var stage = plant.stage
		data["plants"].append({"x": plant.position.x, "y": plant.position.y, "stage": stage, "time": plant.getTimerLeft()})
	file.store_line(JSON.stringify(data))
	

func loadPlants():
	world.coordList = []
	for plant in get_tree().get_nodes_in_group("Plants"):
		plant.queue_free()
		
	
	var file = FileAccess.open(save_Plants, FileAccess.READ)
	var data = JSON.parse_string(file.get_line())
	var coordList = []
	
	for tile_data in data["plants"]:
		var x = tile_data["x"]
		var y = tile_data["y"]
		var stage = tile_data["stage"]
		var timeLeft = tile_data["time"]
		var plant1 = plant.instantiate()
		plant1.position.x = x
		plant1.position.y = y
		
		var coord = floor.to_local(Vector2(x,y))
		coord = floor.local_to_map(coord)
		world.coordList.append([coord, plant1])
		
		plant1.set_stage(stage)
		plant1.add_to_group("Plants")
		plant1.setTimerLeft(timeLeft)
		world.add_child(plant1)
		

		
		
	
	
	
func load_game():
	if FileAccess.file_exists(save_pathPlayer):
		var file = FileAccess.open(save_pathPlayer, FileAccess.READ)
		player.position.x = file.get_var(player.position.x)
		player.position.y = file.get_var(player.position.y)
		
		while file.get_position() != file.get_length():
			floor.set_cell()
	else:
		print("No save Data")
		
func load_Map():
	floor.clear()
	var file = FileAccess.open(save_tileMap, FileAccess.READ)
	var data = JSON.parse_string(file.get_line())

	for tile_data in data["tiles"]:
		var x = tile_data["x"]
		var y = tile_data["y"]
		var tileAtlasX = tile_data["tileAtlas.x"]
		var tileAtlasY = tile_data["tileAtlas.y"]
		var tileSource = tile_data["tileSource"]
		var layer = tile_data["layer"]
		floor.set_cell(layer, Vector2i(x,y), tileSource, Vector2i(tileAtlasX,tileAtlasY))
		
	
		
	
		
		
