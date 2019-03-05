extends Area2D

enum Items {health, ammo, shield}
export (Items) var type = Items.health
export var amount : Vector2 = Vector2(10,25)
var iconTextures = [preload("res://assets/pickups/isometric/heart_NE.png"), preload("res://assets/pickups/isometric/jewel_NW.png"), preload("res://assets/pickups/isometric/heartShield_NW.png")]

func _ready() -> void:
	$Sprite/Icon.texture = iconTextures[type]

func _on_Area2D_body_entered(body) -> void:
	match type:
		Items.health:
			if body.has_method('heal'):
				body.heal(int(rand_range(amount.x, amount.y)))
		Items.ammo:
			body.AmmoAmount += (int(rand_range(amount.x, amount.y)))
		Items.shield:
			pass
	queue_free()
