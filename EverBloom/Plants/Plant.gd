extends Node2D
@onready var plant = $Sprite2D
@onready var timer = $Timer
var stage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	plant.frame = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match stage:
		1:
			plant.frame = 1
		2:
			plant.frame = 2
		3:
			plant.frame = 3
		4:
			plant.frame = 4
		5:
			plant.frame = 5
		


func _on_timer_timeout():
	if stage <= 5:
		stage += 1
