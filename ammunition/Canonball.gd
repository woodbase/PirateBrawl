extends Area2D

export var speed : int = 200
export var damage : int = 10
export var lifetime : float = 3.5

var velocity : Vector2 = Vector2()

func _ready():
	pass
	
func start(_position: Vector2, _direction) -> void:
	position = _position
	rotation = _direction.angle()
	$LifeSpan.wait_time = lifetime
	$LifeSpan.start()
	velocity = speed * _direction
	
func _process(delta: float)->void:
	position += velocity * delta

func explode() -> void:
	queue_free()

func _on_LifeSpan_timeout():
	print('Timeout')
	explode()


func _on_Canonball_body_entered(body):
	print(body.name)
	explode()
	if(body.has_method("takeDamage")):
		body.takeDamage(damage)
