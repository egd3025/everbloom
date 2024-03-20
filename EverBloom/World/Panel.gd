extends Panel

var time_index = 0
var times = ["10:00 AM", "12:00 PM", "02:00 PM", "04:00 PM", "06:00 PM"]
var time_accumulator = 0
# Every int is = to a second
# *** After demonstration, change to 120 to simulate 2 minutes in seconds *** #
var update_interval = 20  # 2 minutes in seconds
var DayCycle_Label: Label

func _ready():
	# Initialize DayCycle_Label
	DayCycle_Label = $DayCycle_Label
	# Set initial time to 10:00 AM
	DayCycle_Label.text = times[time_index]

func _process(delta):
	# Accumulate time
	time_accumulator += delta

	# Check if it's time to update the label
	if time_accumulator >= update_interval:
		# Reset time accumulator
		time_accumulator = 0

		# Update time index
		time_index = (time_index + 1) % times.size()

		# Update the label text
		DayCycle_Label.text = times[time_index]





func _on_save_pressed():
	SaveLoad 
	#_save()
	print("GAME SAVED")


func _on_load_pressed():
	#_load()
	print("GAME LOADED")
