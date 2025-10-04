extends CanvasLayer

@onready var main_menu = preload("res://scenes/levels/level_0.tscn")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("main_menu"):
		get_tree().paused = false
		get_tree().change_scene_to_packed(main_menu)
	elif Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		GLOBAL.retry()


func _on_button_play_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_button_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)


func _on_button_restart_pressed() -> void:
	get_tree().paused = false
	GLOBAL.retry()
