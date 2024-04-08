extends Camera2D


var time_index = 0
# creating a list of all time elements to cycle through
var times = ["10:00 AM", "11:00 AM", "12:00 PM", " 1:00 PM", " 2:00 PM", " 3:00 PM", " 4:00 PM", " 5:00 PM", " 6:00 PM"]
var time_accumulator = 0
# after every 60 seconds, the label will update to account for 60 minutes in game
var update_interval = 60
var DayCycle_Label2: Label


## _ready() is called when the node enters the scene tree for the first time
## it conncets to the child node DayCyle_Label2 and initially sets the label text
## for the first element in the string of times
func _ready():
	DayCycle_Label2 = $DayCycleLabelImage/DayCycle_Label2
	DayCycle_Label2.text = times[time_index]


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
