extends Control

@onready var inv: Inv = preload("res://Inventory/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
func _input(event):
	if Input.is_action_just_pressed("pause"):
		if !get_tree().paused:
			get_tree().paused = !get_tree().paused
		get_tree().change_scene_to_file("res://Pause Menu.tscn")
	if Input.is_action_just_pressed("inventory"):
		get_tree().change_scene_to_file("res://World/world.tscn")

func _on_inventory_button_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_almanac_button_pressed():
	pass

func _on_to_do_list_button_pressed():
	pass
