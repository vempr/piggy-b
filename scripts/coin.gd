extends RigidBody2D

var dir = Vector2.ZERO
var is_on_floor = false


func _ready() -> void:
	freeze_mode = FREEZE_MODE_KINEMATIC
	is_on_floor = false
	rotation = randf() * 360


func _physics_process(_delta: float) -> void:
	if GameState.coin_trapped == true:
		linear_velocity = Vector2.ZERO
		freeze_mode = FREEZE_MODE_STATIC
		return
	
	if dir != Vector2.ZERO && is_on_floor == true:
		linear_velocity = dir
		dir = Vector2.ZERO
	else:
		dir = Vector2.ZERO


func _on_ground_area_body_entered(_body: Node2D) -> void:
	is_on_floor = true


func _on_ground_area_body_exited(_body: Node2D) -> void:
	is_on_floor = false
