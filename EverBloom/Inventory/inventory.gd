extends Resource

class_name Inv

signal update 

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	# is this item already in the inventory? add it to the rest
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		# item is not in the inventory already, goes into a new slot
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func clear():
	slots.clear()
