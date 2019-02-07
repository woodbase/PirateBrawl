extends "res://ships/Ship.gd"

onready var parent = get_parent()

func _ready():
	if(Speed == 0):
		Speed = 100

func control(delta) -> void:
	if(parent is PathFollow2D):
		parent.set_offset(parent.get_offset() + Speed * delta)
		position = Vector2()
	else:
		print("Parent is not pathfollow2d")
		#do something else
		pass