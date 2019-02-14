extends "res://ships/Ship.gd"

onready var parent = get_parent()
export var canonRotationSpeed : float = 100.0
export var detectRadius : int = 200

var target = null

func _ready():
	if(Speed == 0):
		Speed = 100
	$Area2D/CollisionShape2D.shape.radius = detectRadius

func control(delta) -> void:
	if(parent is PathFollow2D && Speed > 0):
	#	parent.set_offset(parent.get_offset() + Speed * delta)
		position = Vector2()
	else:
		print("Parent is not pathfollow2d")
		#do something else
		pass

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
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