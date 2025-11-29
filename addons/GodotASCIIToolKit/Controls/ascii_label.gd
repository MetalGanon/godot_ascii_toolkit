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


func _init() -> void:
	const pref = "res://addons/GodotASCIIToolKit/"
	theme = load(
		pref+"Resources/Godot/Themes/ascii_label_theme.tres"
	)
	label_settings = load(
		pref+"Resources/Godot/LabelSettings/label_settings.tres"
	)
