extends KinematicBody2D

signal hp_update
signal died

export var Speed : int
export var Health : int
export var Bullet : PackedScene
export var CanonReload : float
export var RotationSpeed: float

var velocity : Vector2 = Vector2()
var canShoot = true
var alive = true

func _ready() -> void:
	$CanonTimer.wait_time = CanonReload
	
func control(delta) -> void:
	pass

func _physics_process(delta) -> void:
	if(!alive):
		return
	control(delta)
	move_and_slide(velocity)
