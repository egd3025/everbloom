extends Control

@onready var inv: Inv = preload("res://Inventory/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	update_slots()
	
func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
	
func _input(InputEvent):
	if Input.is_action_just_pressed("pause"):
		if !get_tree().paused:
			get_tree().paused = !get_tree().paused
		get_tree().change_scene_to_file("res://Pause Menu.tscn")
	if Input.is_action_just_pressed("inventory"):
		get_tree().change_scene_to_file("res://World/world.tscn")
