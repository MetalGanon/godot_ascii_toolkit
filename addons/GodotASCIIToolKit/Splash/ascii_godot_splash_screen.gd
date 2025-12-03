extends ASCIIControl


func _ready():
	super()
	$FadePlayer.play("fade_in_out")
	var next_scene = load(
		ProjectSettings.get_setting(
			"GodotASCIIToolKit/scene_after_ascii_splash_scene"
		)
	)
	await $FadePlayer.animation_finished
	get_tree().change_scene_to_packed(next_scene)
