extends ASCIIControl


func _ready():
	super()
	$FadePlayer.play("fade_in_out")
	var next_scene = load(
		ASCIISettings.SCENE_AFTER_SPLASH
	)
	await $FadePlayer.animation_finished
	get_tree().change_scene_to_packed(next_scene)
