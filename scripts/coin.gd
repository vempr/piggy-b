extends RigidBody2D

var dir = Vector2.ZERO
var colliding_bodies = 0


func _ready() -> void:
	freeze_mode = FREEZE_MODE_KINEMATIC
	rotation = randf() * 360


func _physics_process(_delta: float) -> void:
	if GameState.coin_trapped == true:
		linear_velocity = Vector2.ZERO
		freeze_mode = FREEZE_MODE_STATIC
		return
	
	if dir != Vector2.ZERO && colliding_bodies != 0:
		linear_velocity = dir
		dir = Vector2.ZERO
	else:
		dir = Vector2.ZERO


func _on_ground_area_body_entered(_body: Node2D) -> void:
	colliding_bodies += 1


func _on_ground_area_body_exited(_body: Node2D) -> void:
	colliding_bodies -= 1
