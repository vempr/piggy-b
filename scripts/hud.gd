extends CanvasLayer


func _ready() -> void:
	$LivesLabel.text = str(GLOBAL.lives)
	$LevelLabel.text = "Level " + str(GLOBAL.level)
