extends GutTest
var plant = preload("res://Plants/Plant.gd")

func test_plant_instantiate():
	var plant1 = plant.new()
	#add_child_autofree(plant1)
	assert_eq(0, plant1.stage, "Plant stage when created is 1")
	
	

func test_plant_simulate():
	var plant1 = plant.new()
	simulate(plant1, 20, 400)
	assert_called(plant1, 'on_timer_timeout')
	
	
func test_doubler():
	var doubled = double("res://Plants/Plant.gd").new()
	var timeleft = doubled.getTimerLeft()
	assert_eq(timeleft, 0, "Done")
	
