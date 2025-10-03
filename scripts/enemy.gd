extends RigidBody2D

var mouse_is_in_area = false
var health = 5
var tween: Tween

@onready var coin = get_parent().get_parent().get_node("Coin")


func _ready() -> void:
	$HitSprite.modulate.a = 0.0


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click") && mouse_is_in_area == true:
		health -= 1
		if health == 0:
			queue_free()
		
		$HitSprite.modulate.a = 1.0
		if tween and tween.is_running():
			tween.kill()
		
		tween = create_tween()
		tween.tween_property($HitSprite, "modulate:a", 0.0, 0.3)


func _on_area_2d_body_entered(body: Node2D) -> void:
	GLOBAL.deaths += 1
	linear_velocity = Vector2.ZERO
	
	GLOBAL.coin_trapped = true
	coin.gravity_scale = 0.0
	await get_tree().create_timer(0.4).timeout
	coin.gravity_scale = 1.0
	GLOBAL.coin_trapped = false
	
	get_tree().reload_current_scene()


func _on_area_2d_mouse_entered() -> void:
	mouse_is_in_area = true


func _on_area_2d_mouse_exited() -> void:
	mouse_is_in_area = false
