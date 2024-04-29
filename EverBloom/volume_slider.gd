extends HSlider

#this is a custum slider with art from the game.
#this is a copy able node type to create a linked slider for
# an aduo bus to operate against.

#any time there is a need for a audio slider take this 
#  and copy it to the spot and link in the inspector to the 
#  aduio bus that you wish to slave

@export

var bus_name: String

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
