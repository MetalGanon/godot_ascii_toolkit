@tool
extends EditorPlugin
## Godot ASCII ToolKit #########################################################
## Description -----------------------------------------------------------------
## This is the activation and deactivation script of the Godot ASCII ToolKit.
##
## Comments --------------------------------------------------------------------
## The tools are intended to be used in a Godot project and editor with specific
## settings. 
##
## Notably:
## - Editor settings (I don't know how to perform this with scripts)
## -- Grid size for 2D editor must be TILE_SIZE_PX
## -- Grid snap activated
## - ProjectSettings
## -- Viewport size must be VIEWPORT_SIZE_PX (cf. ascii_settings.gd).
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################


func _enable_plugin() -> void:
	# Add autoloads here.
	add_autoload_singleton(
		"ASCIISettings", "ascii_settings.gd"
	)


func _disable_plugin() -> void:
	# Remove autoloads here.
	remove_autoload_singleton("ASCIISettings")


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type(
		"ASCIILabel",
		"ASCIILabel",
		preload("Controls/ascii_label.gd"),
		preload("godot_ascii_toolkit_icon.png"),
	)
	add_custom_type(
		"ASCIIControl",
		"ASCIIControl",
		preload("Controls/ascii_control.gd"),
		preload("godot_ascii_toolkit_icon.png"),
	)
	add_custom_type(
		"ASCIICustomBox",
		"ASCIICustomBox",
		preload("Controls/BasicBoxes/ascii_custom_box.gd"),
		preload("godot_ascii_toolkit_icon.png"),
	)
	add_custom_type(
		"ASCIIBackgroundCustomBox",
		"ASCIIBackgroundCustomBox",
		preload("Controls/BasicBoxes/ascii_background_custom_box.gd"),
		preload("godot_ascii_toolkit_icon.png"),
	)
	add_custom_type(
		"ASCIIBox",
		"ASCIIBox",
		preload("Controls/BasicBoxes/ascii_box.gd"),
		preload("godot_ascii_toolkit_icon.png"),
	)
	add_custom_type(
		"ASCIICustomTextBox",
		"ASCIICustomTextBox",
		preload("Controls/TextBoxes/ascii_custom_text_box.gd"),
		preload("godot_ascii_toolkit_icon.png"),
	)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("ASCIILabel")
	remove_custom_type("ASCIIControl")
	remove_custom_type("ASCIICustomBox")
	remove_custom_type("ASCIIBackgroundCustomBox")
	remove_custom_type("ASCIIBox")
	remove_custom_type("ASCIICustomTextBox")
