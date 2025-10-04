extends Node2D

@onready var coin = get_parent().get_node("Coin")


func _ready() -> void:
	$Sprite1.visible = false
	var number = randi_range(1, 3)
	get_node("Sprite" + str(number)).visible = true


func _on_killzone_body_entered(_body: Node2D) -> void:
	$LoseSFX.play(2.5)
	
	GLOBAL.coin_trapped = true
	coin.gravity_scale = 0.0
	Fade.fade_out(0.5)


func _on_lose_sfx_finished() -> void:
	coin.gravity_scale = 1.0
	GLOBAL.coin_trapped = false
	
	GLOBAL.retry()
