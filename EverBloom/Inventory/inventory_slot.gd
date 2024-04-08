extends Resource

class_name InvSlot

# sets up the inventory slot
# this allows us to track the number of each type of item the player has
# slots are what are listed first inside the inventory array
# slots contain inventory items
@export var item: InvItem
@export var amount: int
