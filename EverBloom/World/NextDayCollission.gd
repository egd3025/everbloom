extends Area2D

var entered = false

@onready var saving_time = $"../Saving_Time"
@export var game_manager : GameManager
@onready var player = $"../player"
@onready var NextDayHint_label = $"../player/Camera2D/NextDayHintImage/NextDayHint"
@onready var NextDayHint_image = $"../player/Camera2D/NextDayHintImage"


var save_pathPlayer = "user://variable.save"
var save_tileMap = "user://map.json"
var save_Plants = "user://plants.json"
var save_Inv = "user://inventory.json"

#func _ready():
	#NextDayHint = $World/player/Camera2D/NextDayHintImage/NextDayHint

func _on_body_entered(body: PhysicsBody2D):
	# NextDayHint = $/World/player/Camera2D/NextDayHintImage/NextDayHint
	#NextDayHint_label.visible = true
	NextDayHint_image.visible = true
	entered = true

func _on_body_exited(body):
	#NextDayHint_label.visible = false
	NextDayHint_image.visible = false
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			saving_time.savePlayer()
			saving_time.saveTileMap()
			saving_time.savePlants()
			player.saveInv()
			get_tree().change_scene_to_file("res://day_transition.tscn")
