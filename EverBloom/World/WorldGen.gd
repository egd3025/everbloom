extends TileMap

@onready var floor = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	#runs on start to place all the tiles
	place_tiles()


func place_tiles():
	# limits the area of generated tiles
	var  x = 20
	var  y = 25
	
	# the smaller ranges for row and col signify where the
	# tiles should begin generating
	for row in range(-20,x+1):
		for col in range(-25,y+1):
			#each set cell is a some sort of grass tile
			var random_number : int = randi() % 50
			if 0 <= random_number and random_number < 25:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(1,1))
			if random_number >= 25 and random_number < 30:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(1,6))
			if 30 <= random_number and random_number < 37:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(0,6))
			if random_number >= 37 and random_number <= 50:
				floor.set_cell(0, Vector2i(row,col), 2, Vector2i(0,5))
	#loops for trees
	for row in range(-2, 20):
		for col in range(1, 11):
			var random_number : int = randi() % 60
			if random_number == 49:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(1,0))
			if random_number == 48:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(0,0))
			if random_number == 47:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(6,3))
			if random_number == 46:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(6,2))
			if random_number == 45:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(6,0))
			if random_number == 44:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(5,0))
			if random_number == 43:
				floor.set_cell(1, Vector2i(row,col), 0, Vector2i(6,1))

