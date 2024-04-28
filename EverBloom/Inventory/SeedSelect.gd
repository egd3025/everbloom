extends TextureRect

@onready var tomButton = $Tomato_Button;
@onready var hotbar = $"../Hotbar"
@onready var wheatButton = $Wheat_Button;
@onready var wheatLabel = $wheat_Label;
@onready var tomLabel = $Tomato_Label;
@onready var seedLabel = $Label;

func _on_wheat_button_pressed():
	# Switches the hotbar slot 4 with the wheat and allows the player
	# to plant wheat seeds
	# Also tracks how many wheat has been collected and allows for 
	# tomatoes to be unlocked once the quota has been reached
	hotbar._on_seed_select_wheat()


func _on_tomato_button_pressed():
	# switches the hotbar slot 4 with the tomato and allows the player
	# to plant tomato seeds once they are unlocked
	# currently world planting textures are fighting me so this is just going to show
	# as locked and have a prompt appear on how to unlock it
	seedLabel.visible = false;
	wheatButton.visible = false;
	wheatLabel.visible = false;
	tomButton.visible = false;
	tomLabel.visible = false;
	var tomUnlock = $Tomato_Unlock;
	tomUnlock.visible = true;
