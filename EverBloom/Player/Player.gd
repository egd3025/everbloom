
### Player.gd

extends CharacterBody2D

# Connects player to player_inv
@export var inv: Inv
@export var hotbar: HotBar 

# Node references
@onready var animation_sprite = $AnimatedSprite2D

# Player states
@export var speed = 50
var is_tilling = false

#direction and animation to be updated throughout game state
var new_direction = Vector2(0,1) #only move one spaces
var animation

# --------------------------------- Movement & Animations -----------------------------------
func _physics_process(delta):
	# Get player input (left, right, up/down)
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# Normalize movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	# Sprinting   
	# FOR LATER IMPLEMENTATION       
	if Input.is_action_pressed("ui_sprint"):
		speed = 100
	elif Input.is_action_just_released("ui_sprint"):
		speed = 50  
	# Apply movement if the player is not tilling
	var movement = speed * direction * delta
	if is_tilling == false:
		move_and_collide(movement)
		player_animations(direction)
	# If no input is pressed, idle
	if !Input.is_anything_pressed():
		if is_tilling == false:
			animation  = returned_direction(new_direction)	+ "_idle"
			
func _input(event):
	#input event for our tilling
	if event.is_action_pressed("till"):
		#tilling anim
		is_tilling = true
		var animation  = "till_" + returned_direction(new_direction)
		animation_sprite.play(animation)

# Animation Direction
func returned_direction(direction : Vector2):
	#it normalizes the direction vector to make sure it has length 1 (1, or -1 up, down, left, and right) 
	var normalized_direction  = direction.normalized()
	var default_return = "side"
	
	if normalized_direction.x > 0:
		#(right)
		$AnimatedSprite2D.flip_h = false
		return "side"
	elif normalized_direction.x < 0:
		#flip the animation for reusability (left)
		$AnimatedSprite2D.flip_h = true
		return "side"
	elif normalized_direction.y > 0:
		return "front"
	elif normalized_direction.y < 0:
		return "back"
		
	#default value is empty
	return default_return
	
# Animations
func player_animations(direction : Vector2):
	#Vector2.ZERO is the shorthand for writing Vector2(0, 0).
	if direction != Vector2.ZERO:
		#update our direction with the new_direction
		new_direction = direction
		#play walk animation, because we are moving
		animation = returned_direction(new_direction) + "_walk"
		animation_sprite.play(animation)
	else:
		#play idle animation, because we are still
		animation  = returned_direction(new_direction) + "_idle"
		animation_sprite.play(animation)

# Reset Animation states
func _on_animated_sprite_2d_animation_finished():
	is_tilling = false
	
	

func collect(item):
	inv.insert(item)
	
func player():
	pass # allows to detect when player is in range of collecting a plant
