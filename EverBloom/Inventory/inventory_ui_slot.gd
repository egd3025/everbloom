extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

# Updates the visuals of a given slot in the inventory
func update(slot: InvSlot):
	if !slot.item:
		# the slot is empty
		item_visual.visible = false
		amount_text.visible = false
	else:
		# the slot has at least 1 item in it
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true #only shows the number if there is more than 1 in the inventory
		amount_text.text = str(slot.amount)
	
