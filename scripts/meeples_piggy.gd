extends Node2D

const SPEED = 100
var direction = 1


func _process(delta: float) -> void:
	if $RayCastBottomRight.is_colliding() == false:
		$Piggy/Sprite2D.flip_h = true
		direction = -1
		
	elif $RayCastBottomLeft.is_colliding() == false:
		$Piggy/Sprite2D.flip_h = false
		direction = 1
		
	elif $RayCastRight.is_colliding() == true:
		$Piggy/Sprite2D.flip_h = true
		direction = -1
		
	elif $RayCastLeft.is_colliding() == true:
		$Piggy/Sprite2D.flip_h = false
		direction = 1
	
	position.x += SPEED * delta * direction
