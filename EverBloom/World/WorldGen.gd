extends TileMap

@onready var floor = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	place_tiles()


func place_tiles():
	var  x = 150
	var  y = 150
	
	for row in range(x):
		for col in range(y):
			var random_number : int = randi() % 50
			if 0 <= random_number and random_number < 25:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(1,1))
			if random_number >= 25 and random_number < 30:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(1,6))
			if 30 <= random_number and random_number < 37:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(0,6))
			if random_number >= 37 and random_number <= 50:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(0,5))
	for row in range(x):
		for col in range(y):
			var random_number : int = randi() % 50
			if random_number == 49:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(1,0))
			if random_number == 48:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(0,0))

