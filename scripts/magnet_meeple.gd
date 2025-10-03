extends Node2D

@onready var coin = get_parent().get_node("Coin")


func _ready() -> void:
	$Sprite1.visible = false
	var number = randi_range(1, 3)
	get_node("Sprite" + str(number)).visible = true


func _on_killzone_body_entered(_body: Node2D) -> void:
	GameState.coin_trapped = true
	Engine.time_scale = 0.1
	await get_tree().create_timer(0.05).timeout
	GameState.coin_trapped = false
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
