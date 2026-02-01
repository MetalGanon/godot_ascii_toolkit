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
## Bonus: list of convenient resolutions with tiles of 8 x 16
## First X x Y, J x I with I the number of line and J of columns
## Be carefully I correspond to Y and J correspond to X
## In 4:3 # there are many more but I got tired
## 320 x 240	40 x 15
## 640 x 480	80 x 30
## 1024 x 768	128 x 48 
## 1280 x 960	160 x 60 
## 1408 x 1056	176 x 66
## In 16:9
## 512 x 288	64 x 18
## 768 x 432	96 x 27
## 1280 x 720	160 x 45
## 1536 x 864	192 x 54
## 1792 x 1008	224 x 63
## In 16:10 # there are many more but I got tired
## 512 x 320	64 x 20
## 768 x 480	96 x 30
## 1024 x 160	128 x 40
## 1280 x 800	160 x 50
## 1664 x 1040	208 x 65
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	if not FileAccess.file_exists("res://godot_ascii_toolkit.cfg"):
		## The plugin is enabled for the first time
		_first_time_enabling_plugin()
	ProjectSettings.settings_changed.connect(_on_project_settings_changed)
	if not FileAccess.file_exists("res://godot_ascii_toolkit.cfg"):
		## The plugin is enabled for the first time
		_first_time_enabling_plugin()
	## Project settings change
	_do_project_settings_changes()
	## Adding custom types
	_add_custom_nodes()


func _on_project_settings_changed():
	var change_needed = false
	for setting in ProjectSettings.get_changed_settings():
		if "display/window/size" in setting or "GodotASCIIToolKit" in setting:
			change_needed = true
			break
	if change_needed:
		var config = ConfigFile.new()
		var err = config.load("res://godot_ascii_toolkit.cfg")
		if err != OK:
			push_error("Configuration file not read.")
		var screen_px = ProjectSettings.get_setting(
			"display/window/size/viewport_width"
		)
		var tile_px = ProjectSettings.get_setting(
			"GodotASCIIToolKit/tile_size_px_x"
		)
		var screen_tile = int(screen_px/tile_px)
		if screen_px % tile_px != 0:
			push_warning("The window width is not a multiple of tile width.")
		config.set_value("screen", "width_px", screen_px)
		config.set_value("screen", "width_tile", screen_tile)
		config.set_value("tile", "width_px", tile_px)
		screen_px = ProjectSettings.get_setting(
			"display/window/size/viewport_height"
		)
		tile_px = ProjectSettings.get_setting(
			"GodotASCIIToolKit/tile_size_px_y"
		)
		screen_tile = int(screen_px/tile_px)
		if screen_px % tile_px != 0:
			push_warning("The window height is not a multiple of tile width.")
		config.set_value("screen", "height_px", screen_px) 
		config.set_value("screen", "height_tile", screen_tile)
		config.set_value("tile", "height_px", tile_px)
		config.save("res://godot_ascii_toolkit.cfg")


func _first_time_enabling_plugin():
	## The first time the plugin is enabled:
	## 1) Config file is created
	var godot_ascii_toolkit_config = ConfigFile.new()
	# Setting default values
	godot_ascii_toolkit_config.set_value("screen", "width_px", 1280) 
	godot_ascii_toolkit_config.set_value("screen", "height_px", 720) 
	godot_ascii_toolkit_config.set_value("screen", "width_tile", 160) 
	godot_ascii_toolkit_config.set_value("screen", "height_tile", 45)
	godot_ascii_toolkit_config.set_value("tile", "width_px", 8)
	godot_ascii_toolkit_config.set_value("tile", "height_px", 16)
	godot_ascii_toolkit_config.save("res://godot_ascii_toolkit.cfg")
	## 2) the custom ascii theme is created
	var ascii_themes = ASCIIThemes.new()
	ResourceSaver.save(
		ascii_themes, 
		"res://addons/GodotASCIIToolKit/Resources/ASCIIResources/ascii_themes.tres"
	)
	


func _add_custom_nodes() -> void:
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
	##
	ProjectSettings.settings_changed.disconnect(_on_project_settings_changed)
	## Undo Project settings
	_undo_project_settings_changes()
	## Removing custom types
	_remove_custom_nodes()


func _remove_custom_nodes():
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
	_update_ascii_screen()


func _update_ascii_screen():
	## Reading config file
	var config = ConfigFile.new()
	var err = config.load("res://godot_ascii_toolkit.cfg")
	if err != OK:
		push_error("Configuration file not read.")
	var screen_width_px = config.get_value("screen", "width_px")
	var screen_height_px = config.get_value("screen", "height_px")
	var screen_width_tile = config.get_value("screen", "width_tile")
	var screen_height_tile = config.get_value("screen", "height_tile")
	var tile_width_px = config.get_value("tile", "width_px")
	var tile_height_px = config.get_value("tile", "height_px")
	# Fetch the data for each section.
	## Game resolution
	ProjectSettings.set_setting(
		"display/window/size/viewport_width", screen_width_px
	)
	ProjectSettings.set_setting(
		"display/window/size/viewport_height", screen_height_px
	)
	## Screen size in tiles
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/screen_width_tile", screen_width_tile
	)
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/screen_height_tile", screen_height_tile
	)
	## Tile Size in pixels
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/tile_size_px_x", tile_width_px
	)
	ProjectSettings.set_setting(
		"GodotASCIIToolKit/tile_size_px_y", tile_height_px
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
