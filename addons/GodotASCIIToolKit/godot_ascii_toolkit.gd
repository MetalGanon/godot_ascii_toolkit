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
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	## Project settings change
	_do_project_settings_changes()
	## Adding custom types
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
	add_custom_type(
		"ASCIITitledBox",
		"ASCIITitledBox",
		preload("Controls/TextBoxes/ascii_titled_box.gd"),
		preload("godot_ascii_toolkit_icon.png"),
	)
	add_custom_type(
		"ASCIIBoxedTextButton",
		"ASCIIBoxedTextButton",
		preload("Controls/Buttons/ascii_boxed_text_button.gd"),
		preload("godot_ascii_toolkit_icon.png"),
	)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	## Undo Project settings
	_undo_project_settings_changes()
	## Removing custom types
	remove_custom_type("ASCIILabel")
	remove_custom_type("ASCIIControl")
	remove_custom_type("ASCIICustomBox")
	remove_custom_type("ASCIIBackgroundCustomBox")
	remove_custom_type("ASCIIBox")
	remove_custom_type("ASCIICustomTextBox")
	remove_custom_type("ASCIITitledBox")
	remove_custom_type("ASCIIBoxedTextButton")


func _do_project_settings_changes():
	## Disabling boot_splash, replace by Godot ASCII splash
	ProjectSettings.set_setting("application/boot_splash/show_image", false)
	ProjectSettings.set_setting(
		"application/boot_splash/bg_color", Color.BLACK
	)
	## Changing texture filter for canvas_textures so that the text render nice
	## in the editor.
	ProjectSettings.set_setting(
		"rendering/textures/canvas_textures/default_texture_filter", 0
	)
	## Changing main scene
	var main_scene = ProjectSettings.get_setting(
		"application/run/main_scene"
	)
	ProjectSettings.set_setting(
		"application/run/main_scene",
		"res://addons/GodotASCIIToolKit/Splash/ascii_godot_splash_screen.tscn"
	)
	if main_scene.is_empty():
		ProjectSettings.set_setting(
			"GodotASCIIToolKit/scene_after_ascii_splash_scene",
			"res://addons/GodotASCIIToolKit/Credits/ascii_credits_screen.tscn"
		)
	else:
		ProjectSettings.set_setting(
			"GodotASCIIToolKit/scene_after_ascii_splash_scene",
			main_scene
		)
	## Game resolution
	ProjectSettings.set_setting(
		"display/window/size/viewport_width", 1280
	)
	ProjectSettings.set_setting(
		"display/window/size/viewport_height", 720
	)
	## Tile Size in pixels
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/tile_size_px_x", 8
	)
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/tile_size_px_y", 16
	)


func _undo_project_settings_changes():
	var main_scene = ProjectSettings.get_setting(
			"GodotASCIIToolKit/scene_after_ascii_splash_scene"
	)
	if (main_scene == 
		"res://addons/GodotASCIIToolKit/Credits/ascii_credits_screen.tscn"
	):
		main_scene = ""
	ProjectSettings.set_setting(
		"application/run/main_scene",
		main_scene
	)
	## Godot original splash
	ProjectSettings.set_setting(
		"application/boot_splash/show_image", true
	)
	ProjectSettings.set_setting(
		"application/boot_splash/bg_color", Color8(36,36,36,255)
	)
	## Scene after splash
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/scene_after_ascii_splash_scene", null
	)
	## Tile Size in pixels
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/tile_size_px_x", null
	)
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/tile_size_px_y", null
	)
