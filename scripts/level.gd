extends Node2D

var next_level
var all_levels_completed = GLOBAL.level + 1 > GLOBAL.LAST_LEVEL


func _ready() -> void:
	if !all_levels_completed:
		next_level = load("res://scenes/levels/level_" + str(GLOBAL.level + 1) + ".tscn")
	
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
	$LoseSFX.play()
	call_deferred("_reload_scene")


func _reload_scene() -> void:
	GLOBAL.retry()


func _on_level_won() -> void:
	$WinSFX.play()
	GLOBAL.level += 1
	$Coin.visible = false
	
	var tree = get_tree()
	await tree.create_timer(0.3).timeout
	
	tree.change_scene_to_packed(next_level)
