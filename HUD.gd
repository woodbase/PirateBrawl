extends CanvasLayer

var red_bar = preload("res://assets/ui/barHorizontal_red_mid 200.png")
var green_bar = preload("res://assets/ui/barHorizontal_green_mid 200.png")
var yellow_bar = preload("res://assets/ui/barHorizontal_yellow_mid 200.png")
var red_sail = preload("res://assets/sailLarge (24).png")
var green_sail = preload("res://assets/sailLarge (12).png")
var yellow_sail = preload("res://assets/sailLarge (6).png")
var barTexture
var sailTexture 

func updateHealthBar(value : int) -> void:
	barTexture = green_bar
	sailTexture = green_sail
	if(value < 60):
		barTexture = yellow_bar
		sailTexture = yellow_sail
	if(value < 25):
		barTexture = red_bar
		sailTexture = red_sail
	$Margin/Container/TextureRect.texture = sailTexture
	$Margin/Container/HealthBar.texture_progress = barTexture
	$Margin/Container/HealthBar/Tween.interpolate_property($Margin/Container/HealthBar, 'value', $Margin/Container/HealthBar.value, value, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Margin/Container/HealthBar/Tween.start()
	$AnimationPlayer.play("healthbar_flash")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "healthbar_flash"):
		$Margin/Container/HealthBar.texture_progress = barTexture
