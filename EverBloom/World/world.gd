extends Node2D

const plant = preload("res://Plants/Plant.tscn")
@onready var world = $"."

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action("Spawn"):
		var plant1 = plant.instantiate()
		plant1.position = get_global_mouse_position()
		world.add_child(plant1)
		
		


