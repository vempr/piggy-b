extends Node

@onready var first_level = preload("res://scenes/levels/level_1.tscn")
@onready var first_tutorial_level = preload("res://scenes/tutorial_levels/tutorial_level_1.tscn")

const LAST_TUTORIAL_LEVEL = 5
const BEGINNING_TUTORIAL_LIVES = 100

const LAST_LEVEL = 20
const BEGINNING_LIVES = 20

var is_in_tutorial_mode = false
var lives = BEGINNING_LIVES
var coin_trapped = false
var level = 1


func retry() -> void:
	lives -= 1

	if lives > 0:
		get_tree().reload_current_scene()
	else:
		level = 1
		if is_in_tutorial_mode:
			lives = BEGINNING_TUTORIAL_LIVES
			get_tree().change_scene_to_packed(first_tutorial_level)
		else:
			lives = BEGINNING_LIVES
			get_tree().change_scene_to_packed(first_level)
	
	Fade.fade_in(0.2)
