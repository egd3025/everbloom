@tool
extends Button

class_name ItemButton

@export var item: InvItem:
	set(item_to_slot):
		item = item_to_slot
		icon = item.texture
