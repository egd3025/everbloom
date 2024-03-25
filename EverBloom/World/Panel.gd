extends Panel
@onready var player = $"../player"
@onready var floor = $"../Floor"
@onready var world = $".."
const plant = preload("res://Plants/Plant.tscn")
var time_index = 0
var times = ["10:00 AM", "12:00 PM", "02:00 PM", "04:00 PM", "06:00 PM"]
var time_accumulator = 0
# Every int is = to a second
# *** After demonstration, change to 120 to simulate 2 minutes in seconds *** #
var update_interval = 20  # 2 minutes in seconds
var DayCycle_Label: Label
var save_pathPlayer = "user://variable.save"
var save_tileMap = "user://map.json"
var save_Plants = "user://plants.json"


func _ready():
	# Initialize DayCycle_Label
	DayCycle_Label = $DayCycle_Label
	# Set initial time to 10:00 AM
	DayCycle_Label.text = times[time_index]

func _process(delta):
	# Accumulate time
	time_accumulator += delta

	# Check if it's time to update the label
	if time_accumulator >= update_interval:
		# Reset time accumulator
		time_accumulator = 0

		# Update time index
		time_index = (time_index + 1) % times.size()

		# Update the label text
		DayCycle_Label.text = times[time_index]





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
		data["plants"].append({"x": plant.position.x, "y": plant.position.y, "stage": stage})
	
	file.store_line(JSON.stringify(data))

func loadPlants():
	for plant in get_tree().get_nodes_in_group("Plants"):
		plant.queue_free()
		
	
	var file = FileAccess.open(save_Plants, FileAccess.READ)
	var data = JSON.parse_string(file.get_line())
	print(data)
	for tile_data in data["plants"]:
		var x = tile_data["x"]
		var y = tile_data["y"]
		var stage = tile_data["stage"]
		print(stage)
		var plant1 = plant.instantiate()
		plant1.position.x = x
		plant1.position.y = y
		plant1.set_stage(stage)
		plant1.add_to_group("Plants")
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
		
func load_Plants():
	
	var file = FileAccess.open(save_tileMap, FileAccess.READ)
	var data = JSON.parse_string(file.get_line())
	
		
	
		
		
