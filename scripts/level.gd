extends Node2D

var next_level


func _ready() -> void:
	$HUD.pause_button_pressed.connect(_on_pause_button_pressed)
	
	match GLOBAL.is_in_tutorial_mode:
		true:
			if GLOBAL.level != GLOBAL.LAST_TUTORIAL_LEVEL:
				next_level = load("res://scenes/tutorial_levels/tutorial_level_" + str(GLOBAL.level + 1) + ".tscn")
			else:
				next_level = preload("res://scenes/win_screens/tutorial_win.tscn")
		
		false:
			if GLOBAL.level != GLOBAL.LAST_LEVEL:
				next_level = load("res://scenes/levels/level_" + str(GLOBAL.level + 1) + ".tscn")
			else:
				next_level = preload("res://scenes/win_screens/game_win.tscn")
	
	if has_node("MeeplesPiggy/Piggy"):
		$MeeplesPiggy/Piggy.level_won.connect(_on_level_won)
	else:
		$Piggy.level_won.connect(_on_level_won)
	
	var mouse_pos = get_global_mouse_position()
	$Slingshot.points[0] = mouse_pos
	$Slingshot.points[1] = mouse_pos
	$Slingshot.start_pos = mouse_pos
	$Slingshot.end_pos = mouse_pos


func _on_pause_button_pressed() -> void:
	$PauseMenu.visible = !$PauseMenu.visible
	var tree = get_tree()
	tree.paused = !tree.paused


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		$PauseMenu.visible = !$PauseMenu.visible
		var tree = get_tree()
		tree.paused = !tree.paused


func _on_void_body_entered(_body: Node2D) -> void:
	$LoseSFX.play(2.5)
	Fade.fade_out(0.3)


func _on_level_won() -> void:
	$WinSFX.play()
	GLOBAL.level += 1
	$Coin.visible = false
	
	Fade.fade_out(0.2)
	var tree = get_tree()
	
	match GLOBAL.is_in_tutorial_mode:
		false:
			if GLOBAL.level > GLOBAL.LAST_LEVEL:
				await Fade.fade_out().finished
				tree.change_scene_to_packed(next_level)
				await Fade.fade_in(0.1).finished
			else:
				await tree.create_timer(0.3).timeout
				tree.change_scene_to_packed(next_level)
		true:
			if GLOBAL.level > GLOBAL.LAST_TUTORIAL_LEVEL:
				await Fade.fade_out().finished
				tree.change_scene_to_packed(next_level)
				await Fade.fade_in(0.1).finished
			else:
				await tree.create_timer(0.3).timeout
				tree.change_scene_to_packed(next_level)
	
	Fade.fade_in(0.2)


func _on_lose_sfx_finished() -> void:
	GLOBAL.retry()
