extends Node2D

@onready var level_1 = preload("res://scenes/levels/level_1.tscn")


func _ready() -> void:
	var music_stream = load("res://music/Virtual Riot - Idols [Lofi Geometry Dash Remix].mp3")
	Music.stream = music_stream
	Music.play()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(level_1)
