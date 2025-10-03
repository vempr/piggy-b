extends Line2D

@onready var coin = get_parent().get_node("Coin")
var start_pos = Vector2.ZERO
var end_pos = Vector2.ZERO

@onready var arrowhead = Polygon2D.new()
var arrowhead_size: float = 40.0
var arrowhead_width: float = 25.0


func _ready():
	add_child(arrowhead)
	arrowhead.color = Color(1, 0, 0)
	arrowhead.z_index = 1
	

func _input(_event: InputEvent) -> void:
	if coin.colliding_bodies == 0:
		var mouse_pos = get_global_mouse_position()
		points[0] = mouse_pos
		points[1] = mouse_pos
		start_pos = mouse_pos
		end_pos = mouse_pos
		update_arrowhead()
		return
	
	if Input.is_action_just_pressed("click"):
		start_pos = get_global_mouse_position()
		end_pos = start_pos
		points[0] = start_pos
		update_arrowhead()
		
	if Input.is_action_pressed("click"):
		points[1] = get_global_mouse_position()
		end_pos = get_global_mouse_position()
		update_arrowhead()
		
	if Input.is_action_just_released("click"):
		points[0] = Vector2.ZERO
		points[1] = Vector2.ZERO
		end_pos = get_global_mouse_position()
		
		var drag_vector = start_pos - end_pos
		var speed = min(drag_vector.length() * 5, 800)
		coin.dir = drag_vector.normalized() * speed
		
		arrowhead.visible = false


func update_arrowhead():
	if points.size() < 2:
		arrowhead.visible = false
		return
	
	var line_vector = points[1] - points[0]
	var line_length = line_vector.length()


	if line_length > arrowhead_size / 2:
		arrowhead.visible = true
		
		var arrow_offset = Vector2(arrowhead_size * 0.5, 0).rotated(line_vector.angle() + PI)
		var arrow_position = points[0] + arrow_offset
		var arrow_rotation = line_vector.angle() + PI
		
		var arrow_polygon = PackedVector2Array()
		arrow_polygon.append(Vector2(0, 0))
		arrow_polygon.append(Vector2(-arrowhead_size, -arrowhead_width))
		arrow_polygon.append(Vector2(-arrowhead_size, arrowhead_width))
		
		arrowhead.polygon = arrow_polygon
		arrowhead.position = arrow_position
		arrowhead.rotation = arrow_rotation
	else:
		arrowhead.visible = false
