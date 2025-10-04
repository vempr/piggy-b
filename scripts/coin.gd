extends RigidBody2D

var dir = Vector2.ZERO
var colliding_bodies = 0


func _ready() -> void:
	gravity_scale = 1.0
	rotation = randf() * 360


func _physics_process(_delta: float) -> void:
	if GLOBAL.coin_trapped == true:
		linear_velocity = Vector2.ZERO
		return
	
	if dir != Vector2.ZERO && colliding_bodies != 0:
		$JumpSFX.play()
		linear_velocity = dir
		dir = Vector2.ZERO
	else:
		dir = Vector2.ZERO


func _on_ground_area_body_entered(_body: Node2D) -> void:
	colliding_bodies += 1


func _on_ground_area_body_exited(_body: Node2D) -> void:
	colliding_bodies -= 1
