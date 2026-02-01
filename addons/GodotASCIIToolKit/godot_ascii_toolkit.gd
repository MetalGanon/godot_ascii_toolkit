@tool
extends EditorPlugin
## Godot ASCII ToolKit #########################################################
## Description -----------------------------------------------------------------
## This is the activation and deactivation script of the Godot ASCII ToolKit.
##
## When it is enabled, it modifies the following ProjectSettings:
## - "application/boot_splash/show_image" set to false
##     In order to replace the original Godot Splash screen by the ASCII Godot
##     splash screen.
## - "application/boot_splash/bg_color" set to Color.BLACK
##     Because the ASCII Godot splash background is black.
## - "rendering/textures/canvas_textures/default_texture_filter" set to nearest
##     So that the ASCII font looks nice and sharp even when zooming in. 
## - "application/run/main_scene" to ascii_godot_splash_screen.tscn
##     To replace the original godot splash screen with the ASCII one.
## - "display/window/size/viewport_width" to 1280 (Godot ASCII ToolKit default)
## - "display/window/size/viewport_height" to 720 (Godot ASCII ToolKit default)
## and creates news ones:
## - "GodotASCIIToolKit/scene_after_ascii_splash_scene": String
##     Path of the scene that goes after the ASCII Godot splash screen.
##     When enabling the plugin:
##     - if no main_scene is defined:
##         the scene after splash is set to ascii_credits_screen.tscn, 
##         containing the credits for the Godot ASCII ToolKit!
##     - if a main_scene is defined:
##         the scene after splash is set to the main_scene.
## - "GodotASCIIToolKit/tile_size_px_x": int = 8
##     The size of an individual ASCII character along the x axis. By default,
##     a lot of ASCII monospace font are using a character width of 8 pixels.
## - "GodotASCIIToolKit/tile_size_px_x": int = 16
##     The size of an individual ASCII character along the y axis. By default,
##     a lot of ASCII monospace font are using a character width of 16 pixels.
##
## Comments --------------------------------------------------------------------
## The tools are intended to be used in an editor with specific editor settings. 
##
## Notably:
## - Grid size for 2D editor must be equal to the size of a tile in pixel (i.e.
##   GodotASCIIToolKit/tile_size_px_x x GodotASCIIToolKit/tile_size_px_y)
## - Grid snap activated
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
	if not FileAccess.file_exists(
		"res://addons/GodotASCIIToolKit/Resources/ASCIIResources/ascii_themes.tres"
	):
		var ascii_themes = ASCIIThemes.new()
		ResourceSaver.save(
			ascii_themes, 
			"res://addons/GodotASCIIToolKit/Resources/ASCIIResources/ascii_themes.tres"
		)
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
