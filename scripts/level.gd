extends Node2D


func _ready() -> void:
	if has_node("MeeplesPiggy/Piggy"):
		$MeeplesPiggy/Piggy.level_won.connect(_on_level_won)
	else:
		$Piggy.level_won.connect(_on_level_won)
	
	var mouse_pos = get_global_mouse_position()
	$Slingshot.points[0] = mouse_pos
	$Slingshot.points[1] = mouse_pos
	$Slingshot.start_pos = mouse_pos
	$Slingshot.end_pos = mouse_pos


func _process(_delta: float) -> void:
	pass


func _on_void_body_entered(_body: Node2D) -> void:
	GLOBAL.lives -= 1
	call_deferred("_reload_scene")


func _reload_scene() -> void:
	get_tree().reload_current_scene()


func _on_level_won() -> void:
	GLOBAL.level += 1
	$Coin.visible = false
	get_tree().paused = true
