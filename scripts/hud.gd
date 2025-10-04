extends CanvasLayer

signal pause_button_pressed


func _ready() -> void:
	$LivesLabel.text = str(GLOBAL.lives)
	$LevelLabel.text = "Level " + str(GLOBAL.level)


func _on_button_pressed() -> void:
	pause_button_pressed.emit()
