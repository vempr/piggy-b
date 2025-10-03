extends Node2D


func _ready() -> void:
	var mouse_pos = get_global_mouse_position()
	$Slingshot.points[0] = mouse_pos
	$Slingshot.points[1] = mouse_pos
	$Slingshot.start_pos = mouse_pos
	$Slingshot.end_pos = mouse_pos


func _process(_delta: float) -> void:
	pass


func _on_void_body_entered(_body: Node2D) -> void:
	call_deferred("_reload_scene")


func _reload_scene() -> void:
	get_tree().reload_current_scene()
