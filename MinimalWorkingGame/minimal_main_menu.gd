extends Control
## This is a minimal main menu screen for testing ASCII features.


func _ready():
	%ASCIIPlayButton.button_up.connect(_on_button_play_released)
	%ASCIIQuitButton.button_up.connect(_on_button_quit_released)
	%FadePlayer.play("fade_in")
	await %FadePlayer.animation_finished


func _on_button_play_released():
	%FadePlayer.play("fade_out")
	var credits_scene = load(
		GodotASCIIToolKit.credits_scene_name
	)
	await %FadePlayer.animation_finished
	get_tree().change_scene_to_packed(credits_scene)


func _on_button_quit_released():
	get_tree().quit()
