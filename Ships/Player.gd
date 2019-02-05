extends "res://Ships/Ship.gd"

func control(delta):
	#$Canon.look_at(get_global_mouse_position())
	var rotationDirection = 0
	if(Input.is_action_pressed("ui_turn_right")):
		rotationDirection += 1
	if(Input.is_action_pressed("ui_turn_left")):
		rotationDirection -= 1
	rotation += RotationSpeed * rotationDirection * delta
		
	if(Input.is_action_pressed("ui_forward")):
		velocity = Vector2(Speed, 0).rotated(rotation)
	if(Input.is_action_pressed("ui_backward")):
		velocity = Vector2(-Speed/2, 0).rotated(rotation)
	if(!Input.is_action_pressed("ui_forward") && velocity.x > 0):
		velocity.x -= 2
		velocity.y -= 2
	if(!Input.is_action_pressed("ui_backward") && velocity.x < 0):
		velocity.x += 2	
		velocity.y += 2