extends "res://ships/Ship.gd"

var MAX_SPEED : float = 200
var currentSpeed : float = 0.0

func control(delta):
	#$Canon.look_at(get_global_mouse_position())
	var rotationDirection = 0
	
	if(Input.is_action_pressed("ui_turn_right")):
		rotationDirection += 1
	if(Input.is_action_pressed("ui_turn_left")):
		rotationDirection -= 1
	rotation += RotationSpeed * rotationDirection * delta
	
	if(Input.is_action_pressed("ui_forward") && currentSpeed < MAX_SPEED):
		currentSpeed += Speed
	if(Input.is_action_pressed("ui_backward") && currentSpeed < MAX_SPEED/2):
		currentSpeed = -Speed/2.0
	if(!Input.is_action_pressed("ui_forward") && currentSpeed > 0):
		currentSpeed -= 2
	if(!Input.is_action_pressed("ui_backward") && currentSpeed < 0):
		currentSpeed += 2
	
	velocity = Vector2(clamp(currentSpeed,-MAX_SPEED,MAX_SPEED), 0).rotated(rotation)
	if(Input.is_action_just_pressed("ui_fire")):
		shoot()