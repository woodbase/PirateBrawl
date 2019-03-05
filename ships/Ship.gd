extends KinematicBody2D

signal hp_update
signal died
signal shoot
signal ammo_updated

export var MaxSpeed : int
export var MaxHealth : int
export var Bullet : PackedScene
export var CanonReload : float
export var RotationSpeed: float
export var AmmoAmount: int = -1 setget setAmmo

var velocity : Vector2 = Vector2()
var canShoot : bool = true
var alive : bool = true
var health : float

func _ready() -> void:
	health = MaxHealth
	emit_signal("hp_update", health * 100/MaxHealth)
	$CanonTimer.wait_time = CanonReload

func shoot() -> void:
	if(canShoot and AmmoAmount != 0):
		if(AmmoAmount != -1):
			self.AmmoAmount -= 1
		canShoot = false
		$CanonTimer.start()
		var dir = Vector2(1,0).rotated($Canon.global_rotation-1.5)
		emit_signal("shoot", Bullet, $Canon/Muzzle.global_position, dir)
		$AnimationPlayer.play("muzzle_flash")

func control(delta) -> void:
	pass

func _physics_process(delta) -> void:
	if(!alive):
		return
	control(delta)
	move_and_slide(velocity)

func takeDamage(amount : int) -> void:
	health-= amount
	emit_signal("hp_update", health * 100/MaxHealth)
	if(health <= 0):
		emit_signal("died")
		sink()

func heal(amount : int) -> void:
	health = clamp(health+amount, 0.0, 100.0)
	emit_signal("hp_update", health * 100/MaxHealth)
	
func sink():
	$CollisionShape2D.disabled = true
	alive = false
	$Canon.hide()
	$Hull.hide()
	$Explosion.show()
	$Explosion.play()

func _on_CanonTimer_timeout():
	canShoot = true

func setAmmo(amount : int) -> void:
	AmmoAmount = amount
	emit_signal("ammo_updated", AmmoAmount)

func _on_Explosion_animation_finished():
	queue_free()
