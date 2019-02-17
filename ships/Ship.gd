extends KinematicBody2D

signal hp_update
signal died
signal shoot

export var MaxSpeed : int
export var Health : int
export var Bullet : PackedScene
export var CanonReload : float
export var RotationSpeed: float

var velocity : Vector2 = Vector2()
var canShoot : bool = true
var alive : bool = true

func _ready() -> void:
	$CanonTimer.wait_time = CanonReload

func shoot() -> void:
	if(canShoot):
		canShoot = false
		$CanonTimer.start()
		var dir = Vector2(1,0).rotated($Canon.global_rotation-1.5)
		emit_signal("shoot", Bullet, $Canon/Muzzle.global_position, dir)

func control(delta) -> void:
	pass

func _physics_process(delta) -> void:
	if(!alive):
		return
	control(delta)
	move_and_slide(velocity)


func _on_CanonTimer_timeout():
	canShoot = true
