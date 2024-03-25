extends CharacterBody2D

const speed = 50
var current_dir = "none"

# Connects player to player_inv
@export var inv: Inv
@export var hotbar: HotBar 

# when the player loads -  the first animation shown is the front_idle
func _ready():
	$AnimatedSprite2D.play("front_idle")


func _physics_process(delta):
	player_movement(delta)
	
	
# player movement direction 
# - x and y values keep you moving in only one direction even if there is mult input
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else: # when the player is still - facing any direction
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()


func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
	

func collect(item):
	inv.insert(item)
	
func player():
	pass # allows to detect when player is in range of collecting a plant
