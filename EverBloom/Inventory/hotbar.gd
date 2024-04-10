extends CanvasLayer

# go ahead and preselect the first slot in hotbar
@onready var selectedNum = 1;
@onready var selectedSlot: TextureRect = $Slot1/Slot1_Selected;
# i couldn't find a way for a signal to just send off the selectedNum
# variable directly so I just made some hard coded signals since
# the hotbar is static anyways
signal selectedNum_1
signal selectedNum_2
signal selectedNum_3
signal selectedNum_4

func _ready():
	# make the first slot visibly selected at start up
	selectedSlot.visible = true;
	
func _input(_event):
	# make whatever is currently selected appear not selected
	selectedSlot.visible = false;
	# for some reason just comparing event straight up causes it to break,
	# I had to make new custom inputs for this to work
	# it's not the most effecient way, but since we aren't allowing the player to
	# CHANGE anything on the hotbar this will do for now and this way i can actually
	# connect it to the player and have it follow them
	if Input.is_action_just_pressed("1"):
		selectedNum = 1;
		selectedSlot = $Slot1/Slot1_Selected;
		selectedNum_1.emit();
	if Input.is_action_just_pressed("2"):
		selectedNum = 2;
		selectedSlot = $Slot2/Slot2_Selected;
		selectedNum_2.emit();
	if Input.is_action_just_pressed("3"):
		selectedNum = 3;
		selectedSlot = $Slot3/Slot3_Selected;
		selectedNum_3.emit();
	if Input.is_action_just_pressed("4"):
		selectedNum = 4;
		selectedSlot = $Slot4/Slot4_Selected;
		selectedNum_4.emit();
	# visibly select the correct thing
	selectedSlot.visible = true;
