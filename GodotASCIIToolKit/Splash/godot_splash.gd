extends ASCIIControl


func _ready():
	$FadePlayer.play("fade_in_out")
	var next_scene = load(
		GodotASCIIToolKit.after_splash_scene_name
	)
	await $FadePlayer.animation_finished
	get_tree().change_scene_to_packed(next_scene)
