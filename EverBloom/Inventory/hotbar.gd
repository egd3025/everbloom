extends Control

# @onready var player : Player = get_tree().get_first_node_in_group("player") 
# ^this is to connect player to hotbar so we can separate equippable items
# items and not. 
#^^^ figure this mess out girl :((

@onready var grid_container : GridContainer = $GridContainer

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
