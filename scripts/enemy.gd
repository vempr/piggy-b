extends RigidBody2D

var mouse_is_in_area = false
var health = 5
var tween: Tween

@onready var coin = get_parent().get_parent().get_node("Coin")


func _ready() -> void:
	$HitSprite.modulate.a = 0.0


func _process(_delta: float) -> void:
	if health > 0 && GLOBAL.coin_trapped == false && Input.is_action_just_pressed("click") && mouse_is_in_area == true:
		$HitSprite.modulate.a = 1.0
		if tween and tween.is_running():
			tween.stop()
			tween.kill()
		
		health -= 1
		
		if health == 0:
			$Area2D.visible = false
			$DieSFX.play(0.5)
			
			tween = create_tween()
			tween.tween_property(self, "modulate:a", 0.0, 0.3)
			tween.tween_callback(queue_free)
		else:
			tween = create_tween()
			tween.tween_property($HitSprite, "modulate:a", 0.0, 0.3)
			$HurtSFX.play()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Coin":
		return
		
	$LoseSFX.play(2.5)
	
	linear_velocity = Vector2.ZERO
	
	GLOBAL.coin_trapped = true
	coin.gravity_scale = 0.0
	Fade.fade_out(0.5)


func _on_area_2d_mouse_entered() -> void:
	mouse_is_in_area = true


func _on_area_2d_mouse_exited() -> void:
	mouse_is_in_area = false


func _on_lose_sfx_finished() -> void:
	coin.gravity_scale = 1.0
	GLOBAL.coin_trapped = false
	
	GLOBAL.retry()
