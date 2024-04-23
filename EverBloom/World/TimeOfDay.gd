extends Camera2D


var time_index = 0
# creating a list of all time elements to cycle through
var times = ["10:00 AM", "11:00 AM", "12:00 PM", " 1:00 PM", " 2:00 PM", " 3:00 PM", " 4:00 PM", " 5:00 PM", " 6:00 PM"]
var time_accumulator = 0
# after every 60 seconds, the label will update to account for 60 minutes in game
var update_interval = 1
var DayCycle_Label2: Label
var HintLabel: Label

@onready var saving_time = $"../../Saving_Time"
@export var game_manager : GameManager
@onready var player = $"../../player"

var save_pathPlayer = "user://variable.save"
var save_tileMap = "user://map.json"
var save_Plants = "user://plants.json"
var save_Inv = "user://inventory.json"

## _ready() is called when the node enters the scene tree for the first time
## it conncets to the child node DayCyle_Label2 and initially sets the label text
## for the first element in the string of times
func _ready():
	DayCycle_Label2 = $DayCycleLabelImage/DayCycle_Label2
	DayCycle_Label2.text = times[time_index]
	
	HintLabel = $NextDayHintImage/NextDayHint
	HintLabel.text = "Press 'Enter' to skip to the next day!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
## the _process function is called every frame with 
## 'delta' being the elapsed time
## time_accumulator counting the seconds until it reaches 60
## time_accumulator is reset and the index and text label is updated
## to continue cycling through the time list
func _process(delta):
	time_accumulator += delta
	if time_accumulator >= update_interval:
		time_accumulator = 0
		time_index = (time_index + 1) % times.size()
		DayCycle_Label2.text = times[time_index]
		# Check if the time has cycled through all elements
		if time_index == 0:
			# save everything
			# Save the player's position at a specific location each "new day"
			player.position = Vector2(9,23)
			saving_time.savePlayer()
			saving_time.saveTileMap()
			saving_time.savePlants()
			player.saveInv()
			# Load the Day Transition scene
			# get_tree().change_scene_to_file("res://day_transition.tscn")
			# this works now
			get_tree().change_scene_to_file("res://day_transition.tscn")
