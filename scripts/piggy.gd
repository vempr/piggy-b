extends StaticBody2D

signal level_won


func _on_insert_area_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		level_won.emit()
