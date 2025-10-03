extends Path2D

@onready var orpheus_scene = preload("res://scenes/enemies/orpheus.tscn")
@onready var heidi_scene = preload("res://scenes/enemies/heidi.tscn")
@onready var coin = get_parent().get_node("Coin")


func _ready() -> void:
	$EnemySpawnTimer.start(randf() * 5 + GLOBAL.LAST_LEVEL - GLOBAL.level)  


func _on_enemy_spawn_timer_timeout() -> void:
	var enemy
	var speed
	
	match randi_range(0, 1):
		0:
			enemy = orpheus_scene.instantiate()
			speed = randf_range(150.0, 250.0)
		1:
			enemy = heidi_scene.instantiate()
			speed = randf_range(250.0, 300.0)

	var enemy_spawn_location = $EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	enemy.position = enemy_spawn_location.position
	
	enemy.look_at(coin.global_position)
	
	var direction = (coin.global_position - enemy.global_position).normalized()
	enemy.linear_velocity = direction * speed

	add_child(enemy)
	$EnemySpawnTimer.start(randf() * 5 + GLOBAL.LAST_LEVEL - GLOBAL.level)  
