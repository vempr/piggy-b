extends RigidBody2D

var dir = Vector2.ZERO
var is_on_floor = false


func _ready() -> void:
	is_on_floor = false
	rotation = randf() * 360


func _physics_process(_delta: float) -> void:
	if dir != Vector2.ZERO && is_on_floor == true:
		linear_velocity = dir
		dir = Vector2.ZERO
	else:
		dir = Vector2.ZERO


func _on_ground_area_body_entered(body: Node2D) -> void:
	is_on_floor = true


func _on_ground_area_body_exited(body: Node2D) -> void:
	is_on_floor = false
