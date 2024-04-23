extends TextureRect

@onready var tomButton = $Tomato_Button;
@onready var hotbar = $"../Hotbar"

func _on_wheat_button_pressed():
	# Switches the hotbar slot 4 with the wheat and allows the player
	# to plant wheat seeds
	# Also tracks how many wheat has been collected and allows for 
	# tomatoes to be unlocked once the quota has been reached
	hotbar._on_seed_select_wheat()


func _on_tomato_button_pressed():
	# switches the hotbar slot 4 with the tomato and allows the player
	# to plant tomato seeds once they are unlocked
	if tomButton.visible:
		hotbar._on_seed_select_tomato()
