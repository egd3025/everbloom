extends TextureRect

@onready var tomButton = $Tomato_Button;
signal Wheat
signal Tomato

func _on_wheat_button_pressed():
	# Switches the hotbar slot 4 with the wheat and allows the player
	# to plant wheat seeds
	# Also tracks how many wheat has been collected and allows for 
	# tomatoes to be unlocked once the quota has been reached
	Wheat.emit();


func _on_tomato_button_pressed():
	# switches the hotbar slot 4 with the tomato and allows the player
	# to plant tomato seeds once they are unlocked
	if tomButton.visible:
		Tomato.emit();
