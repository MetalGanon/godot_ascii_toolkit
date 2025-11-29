@tool
extends EditorPlugin
## Godot ASCII ToolKit #########################################################
##
## Activation and deactivations script.
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


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("ASCIIControl")
	remove_custom_type("ASCIICustomBox")
