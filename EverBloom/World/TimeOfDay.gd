extends Camera2D

var time_index = 0
var times = ["10:00 AM"]
var time_accumulator = 0
var update_interval = 1
var DayCycle_Label2: Label


# Called when the node enters the scene tree for the first time.
func _ready():
	DayCycle_Label2 = $DayCycleLabelImage/DayCycle_Label2
	DayCycle_Label2.text = times[time_index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_accumulator += delta
	if time_accumulator >= update_interval:
		time_accumulator = 0
		time_index = (time_index + 1) % times.size()
		DayCycle_Label2.text = times[time_index]
