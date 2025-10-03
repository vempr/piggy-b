extends Node

@onready var first_level = preload("res://scenes/levels/level_1.tscn")

const LAST_LEVEL = 20
const BEGINNING_LIVES = 2

var lives = BEGINNING_LIVES
var coin_trapped = false
var level = 1


func retry() -> void:
	lives -= 1

	if lives > 0:
		get_tree().call_deferred("reload_current_scene")
	else:
		lives = BEGINNING_LIVES
		level = 1
		get_tree().call_deferred("change_scene_to_packed", first_level)
