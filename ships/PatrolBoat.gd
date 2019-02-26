extends "res://ships/Ship.gd"

onready var parent = get_parent()
export var canonRotationSpeed : float = 100.0
export var detectRadius : int = 200
var speed = 0

var target = null

func _ready():
	if(MaxSpeed == 0):
		MaxSpeed = 100
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle 
	$DetectRadius/CollisionShape2D.shape.radius = detectRadius

func control(delta) -> void:
	if(parent is PathFollow2D && MaxSpeed > 0):
		if($LookAhead1.is_colliding() || $LookAhead2.is_colliding()):
			speed = lerp(speed, 0, 0.01)
		else:
			speed = lerp(speed, MaxSpeed, 0.07)
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	else:
		pass

func _on_Area2D_body_entered(body):
	target = body

func _on_Area2D_body_exited(body):
	if(body == target):
		target = null

func _process(delta):
	if(target):
		var targetDirection = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1,0).rotated($Canon.global_rotation)
		$Canon.global_rotation = current_dir.linear_interpolate(targetDirection, canonRotationSpeed*delta).angle()+1.5
		$Canon.rotation = clamp($Canon.rotation, 0, 3.14)
		if(targetDirection.dot(current_dir)>0.1):
			shoot()