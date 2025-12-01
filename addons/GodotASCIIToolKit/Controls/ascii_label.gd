@tool
class_name ASCIILabel
extends Label
## Plugin custom type ##########################################################
## Description -----------------------------------------------------------------
## Just a label with the good properties for ASCII tools.
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################


func _ready() -> void:
	const pref = "res://addons/GodotASCIIToolKit/"
	theme = load(
		pref+"Resources/Godot/Themes/ascii_label_theme.tres"
	)
	add_theme_constant_override("line_spacing", 0.0)
