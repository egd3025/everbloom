extends GutTest
#@onready var plant = $World/Plant

func test_plant_instantiate():
	#var plant1 = plant.instantiate()
	
	assert_eq(1, 1, "Plant stage when created is 1")
	
	
