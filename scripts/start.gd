extends Node2D

@onready var level_1 = load("res://scenes/levels/level_1.tscn")
@onready var practice_level_1 = load("res://scenes/tutorial_levels/tutorial_level_1.tscn")


func _ready() -> void:
	GLOBAL.level = 5
	var music_stream = load("res://music/Virtual Riot - Idols [Lofi Geometry Dash Remix].mp3")
	Music.stream = music_stream
	Music.play()


func _on_button_pressed() -> void:
	GLOBAL.is_in_tutorial_mode = false
	GLOBAL.lives = GLOBAL.BEGINNING_LIVES
	get_tree().change_scene_to_packed(level_1)


func _on_tutorial_button_pressed() -> void:
	GLOBAL.is_in_tutorial_mode = true
	GLOBAL.lives = GLOBAL.BEGINNING_TUTORIAL_LIVES
	get_tree().change_scene_to_packed(practice_level_1)
