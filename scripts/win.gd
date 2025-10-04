extends CanvasLayer

@onready var start_menu = preload("res://scenes/levels/level_0.tscn")


func _ready() -> void:
	$YaySFX.play()
	if has_node("LivesLabel"):
		$LivesLabel.text = "beaten with " + str(GLOBAL.BEGINNING_LIVES - GLOBAL.lives) + " lives lost"


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_menu)
