extends Line2D

@onready var coin = get_parent().get_node("Coin")
var start_pos = Vector2.ZERO
var end_pos = Vector2.ZERO


func _input(_event: InputEvent) -> void:
	if coin.colliding_bodies == 0:
		var mouse_pos = get_global_mouse_position()
		points[0] = mouse_pos
		points[1] = mouse_pos
		start_pos = mouse_pos
		end_pos = mouse_pos
		return
	
	if Input.is_action_just_pressed("click"):
		start_pos = get_global_mouse_position()
		end_pos = start_pos
		points[0] = start_pos
		
	if Input.is_action_pressed("click"):
		points[1] = get_global_mouse_position()
		
	if Input.is_action_just_released("click"):
		points[0] = Vector2.ZERO
		points[1] = Vector2.ZERO
		end_pos = get_global_mouse_position()
		
		var drag_vector = start_pos - end_pos
		var speed = min(drag_vector.length() * 5, 800)
		coin.dir = drag_vector.normalized() * speed
