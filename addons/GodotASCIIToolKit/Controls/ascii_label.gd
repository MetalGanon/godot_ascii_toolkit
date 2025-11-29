class_name ASCIILabel
extends Label
## Just a label with the good properties for ASCII tools.

func _ready():
	const pref = "res://addons/GodotASCIIToolKit/"
	theme = load(
		pref+"Resources/Godot/Themes/ascii_label_theme.tres"
	)
	label_settings = load(
		pref+"Resources/Godot/LabelSettings/label_settings.tres"
	)
