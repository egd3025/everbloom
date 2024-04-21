extends Node2D
@onready var plant = $Sprite2D
@onready var timer = $Timer
@onready var world = $".."

var stage = 0
var player_in_area = false
# allows for the collectable version of the wheat to spawn in on command 
var wheat = preload("res://Inventory/items/wheat_collectable.tscn")
var tomato = preload("res://Inventory/items/tomato_collectable.tscn")
# allows us to change the growth texture of the planted seed and collect correctly
var textureGrowthRef = "res://cup_noodle/wheat_Growth.png"
var itemCollect = "res://Inventory/items/Wheat.tres"



@export var item: InvItem
var player = null

func setTimerLeft(time):
	#set the timer left on the plant
	#used in loading and saving 
	var timer = $Timer
	timer.wait_time = time
	timer.start()
	
func getTimerLeft():
	#get the timer left
	return timer.get_time_left()
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	plant.frame = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#checks the stage and sets the respective stage
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
	#stage incrementer on the timer end
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
	timer.start(1)
		
func _input(event):
	#if the player is in the range of the plant and the stage if final
	#then collect
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
	wheat_instance.queue_free()
	player.collect(item)

func set_stage(newStage):
	#sets stage (used in saving and loading)
	stage = newStage

func _on_hotbar_tomato_select():
	textureGrowthRef = "res://cup_noodle/tomato_Growth.png"
	itemCollect = "res://Inventory/items/Tomato.tres"
	#$Sprite2D.texture = ResourceLoader.load(textureGrowthRef)
	item = ResourceLoader.load(itemCollect)
	$Sprite2D.texture.region = Rect2(0,16,96,16) 

func _on_hotbar_wheat_select():
	textureGrowthRef = "res://cup_noodle/wheat_Growth.png"
	itemCollect = "res://Inventory/items/Wheat.tres"
	$Sprite2D.texture.region = Rect2(0,0,96,16) 
	item = ResourceLoader.load(itemCollect)
