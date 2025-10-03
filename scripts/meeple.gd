extends Node2D


func _ready() -> void:
	$Sprite1.visible = false
	var number = randi_range(1, 3)
	get_node("Sprite" + str(number)).visible = true
