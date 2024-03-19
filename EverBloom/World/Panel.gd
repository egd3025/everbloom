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
func _on_save_pressed() -> void:
	_save()
	
	print("GAME SAVED")

func _on_load_pressed() -> void:
	_load()
	print("GAME LOADED")

func _save() -> void:
	var save_file = FileAccess.open("saveFile", FileAccess.WRITE) # Open File
	
	# Go through every object in the SaveLoad group
	var save_nodes = get_tree().get_nodes_in_group("SaveLoad")
	for node in save_nodes:
		# Check if the node has a save function.
		if !node.has_method("saveObject"):
			print("Node '%s' is missing a save function, skipped" % node.name)
			continue
			
		# Call the node's save function.
		var node_data = node.call("saveObject")
		
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(JSON.stringify(node_data))
	
	save_file.close() # Close File

func _load() -> void:
	# Check if the SaveFile exists
	if !FileAccess.file_exists("saveFile"):
		print("Error, no Save File to load.")
		return
		
	var save_file = FileAccess.open("saveFile", FileAccess.READ) # Open File
	
	while save_file.get_position() < save_file.get_length():
		# Get the saved dictionary from the next line in the save file
		var json = JSON.new()
		json.parse(save_file.get_line())
		
		# Get the Data
		var node_data = json.get_data()
		if has_node(node_data["filepath"]):
			get_node(node_data["filepath"]).loadObject(node_data)
			
	save_file.close() # Close File
