extends Node2D
@onready var plant = $Sprite2D
@onready var timer = $Timer

var stage = 0
var player_in_area = false
# allows for the collectable version of the wheat to spawn in on command 
var wheat = preload("res://Inventory/items/wheat_collectable.tscn")


@export var item: InvItem
var player = null

func setTimerLeft(time):
	var timer = $Timer
	timer.wait_time = time
	timer.start()
	
func getTimerLeft():
	return timer.get_time_left()
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	plant.frame = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stage == 1:
		plant.frame = 1
	if stage == 2:
		plant.frame = 2
	if stage == 3:
		plant.frame = 3
	if stage == 4:
		plant.frame = 4
	if stage == 5:
		plant.frame = 5
		

	
func _on_timer_timeout():
	if stage <= 4:
		stage += 1
	if stage == 1:
		plant.frame = 1
	if stage == 2:
		plant.frame = 2
	if stage == 3:
		plant.frame = 3
	if stage == 4:
		plant.frame = 4
	if stage == 5:
		plant.frame = 5
	timer.start(5)
		
func _input(event):
	if event.is_action_pressed("collect"):
		if player_in_area and stage > 4:
			drop_wheat()

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false

func drop_wheat():
	var wheat_instance = wheat.instantiate()
	wheat_instance.global_position = $Marker2D.global_position
	# ^ takes the wheat collectable and puts it at the marker2d position
	get_parent().add_child(wheat_instance)
	player.collect(item)

func set_stage(newStage):
	stage = newStage


