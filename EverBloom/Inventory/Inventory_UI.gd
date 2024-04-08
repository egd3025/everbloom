extends Control

# loads in the player's inventory to manipulate and iterate through
@onready var inv: Inv = preload("res://Inventory/player_inv.tres")
# creates an array for our slot items so that we CAN iterate
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	# whenever inventory sends the update signal after a collection,
	# the UI gets updated to display the change
	inv.update.connect(update_slots)
	update_slots()
	
func update_slots():
	# iterates through the current slots array and makes sure it matches
	# the actual player inventory
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
	
func _input(event):
	# scene changes depending on different inputs
	# allows player to open inventory and pause menu
	if event.is_action_pressed("pause"):
		if !get_tree().paused:
			get_tree().paused = !get_tree().paused
		get_tree().change_scene_to_file("res://Pause Menu.tscn")
	if event.is_action_pressed("inventory"):
		get_tree().change_scene_to_file("res://World/world.tscn")

func _on_inventory_button_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_almanac_button_pressed():
	pass

func _on_to_do_list_button_pressed():
	pass
