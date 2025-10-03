extends Node2D

@onready var wind_scene: PackedScene = preload("res://scenes/wind.tscn")
@onready var strong_wind_scene: PackedScene = preload("res://scenes/strong_wind.tscn")
@onready var coin = get_parent().get_node("Coin")

var is_strong_fan = false
var coin_is_in_wind = false
var winds = 1


func _physics_process(_delta: float) -> void:
	if coin_is_in_wind == true:
		var wind_direction
		var rot_deg = roundi(rotation * 180.0 / PI) % 360
		
		match rot_deg:
			0:
				wind_direction = Vector2.RIGHT
			90:
				wind_direction = Vector2.DOWN
			180:
				wind_direction = Vector2.LEFT
			270:
				wind_direction = Vector2.UP
		
		if is_strong_fan == true:
			coin.apply_central_force(wind_direction * 500)
		else:
			coin.apply_central_force(wind_direction * 300)


func _on_wind_spawner_timer_timeout() -> void:
	winds += 1
	var new_wind
	
	if is_strong_fan == true:
		new_wind = strong_wind_scene.instantiate()
	else:
		new_wind = wind_scene.instantiate()
	
	add_child(new_wind)
	
	if winds == 7:
		$WindSpawnerTimer.paused = true


func _on_wind_area_body_entered(_body: Node2D) -> void:
	coin_is_in_wind = true


func _on_wind_area_body_exited(_body: Node2D) -> void:
	coin_is_in_wind = false
