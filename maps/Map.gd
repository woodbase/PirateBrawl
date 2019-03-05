extends Node2D

var pickup : PackedScene = preload("res://environment/Pickup.tscn")

func _ready():
	setCameraLimits()
	
func setCameraLimits():
	var map_limits = $Water.get_used_rect()
	var map_cellsize = $Water.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

func _on_ship_shoot(bullet, _position, _direction):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)

func _on_Player_died():
	get_tree().reload_current_scene()
	
func _on_PickupSpawn_timeout():
	var map = $Water.get_used_rect()
	var map_cellsize = $Water.cell_size
	var posx = rand_range(map.position.x*map_cellsize.x, map.end.x*map_cellsize.x)
	var posy = rand_range(map.position.y*map_cellsize.y, map.end.y*map_cellsize.y)
	var spawnPos = Vector2(posx, posy)
	var newPickup = pickup.instance()
	newPickup.type = randi()%3
	newPickup.position = spawnPos
	add_child(newPickup)