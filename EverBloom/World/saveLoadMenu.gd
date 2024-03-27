extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#show()
	pass



func _on_resume_pressed():
	hide()


func _on_exit_pressed():
	get_tree().quit()
