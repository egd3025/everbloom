extends TileMap

@onready var floor = $"."
var  x = 50
var  y = 50
var coordArray = []
# Called when the node enters the scene tree for the first time.
func _ready():
	place_tiles()



func place_tiles():
	
	
	for row in range(x):
		for col in range(y):
			coordArray.append(Vector2i(x,y))
			var random_number : int = randi() % 50
			if 0 <= random_number and random_number < 25:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(1,1))
			if random_number >= 25 and random_number < 30:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(1,6))
			if 30 <= random_number and random_number < 37:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(0,6))
			if random_number >= 37 and random_number <= 50:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(0,5))
		#floor.set_cells_terrain_connect(0, [Vector2i(x,y)], 0, 0)

	for row in range(x):
		for col in range(y):
			var random_number : int = randi() % 50
			if random_number == 25:
				floor.set_cell(2, Vector2i(row,col), 5, Vector2i(0,0))
			
			if random_number == 0:
				floor.set_cell(2, Vector2i(row,col), 5, Vector2i(1,0))


func getCoordArray():
	print(coordArray)
	return coordArray
