extends Area2D

var entered = false

@onready var saving_time = $"../Saving_Time"
@export var game_manager : GameManager
@onready var player = $"../player"

var save_pathPlayer = "user://variable.save"
var save_tileMap = "user://map.json"
var save_Plants = "user://plants.json"
var save_Inv = "user://inventory.json"

func _on_body_entered(body: PhysicsBody2D):
	entered = true


func _on_body_exited(body):
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			saving_time.savePlayer()
			saving_time.saveTileMap()
			saving_time.savePlants()
			player.saveInv()
			get_tree().change_scene_to_file("res://day_transition.tscn")
