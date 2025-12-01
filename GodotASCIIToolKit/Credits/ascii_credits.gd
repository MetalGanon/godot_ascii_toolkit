extends ASCIIControl


func _ready():
	super()
	$FadePlayer.play("fade_in")
	await $FadePlayer.animation_finished


func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		$FadePlayer.play("fade_out")
		await $FadePlayer.animation_finished
		get_tree().quit()
