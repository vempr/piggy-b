extends Node2D

@onready var coin = get_parent().get_node("Coin")


func _ready() -> void:
	$Sprite1.visible = false
	var number = randi_range(1, 3)
	get_node("Sprite" + str(number)).visible = true


func _on_killzone_body_entered(_body: Node2D) -> void:
	$LoseSFX.play()
	
	GLOBAL.coin_trapped = true
	coin.gravity_scale = 0.0
	await get_tree().create_timer(0.5).timeout
	coin.gravity_scale = 1.0
	GLOBAL.coin_trapped = false
	
	GLOBAL.retry()
