@tool
extends Node
## Configuration script ########################################################
## This script is autoloaded when the plugin is activated.
## Description -----------------------------------------------------------------
## Configuration script for the Godot ASCII ToolKit.
##
## For now, it only manages ASCII grid resolution aspects.
##
## This global tool overrides the viewport size.
##
## Enums -----------------------------------------------------------------------
## - TILE_SIZE_PX: {X, Y}
##     Size of a tile in pixels.
## - VIEWPORT_SIZE_PX: {X, Y}
##     Size of viewport in pixels.
## - VIEWPORT_SIZE_IJ: {I, J}
##     Size of viewport in tiles.
##
## Comments --------------------------------------------------------------------
## Bonus: list of convenient resolutions with tiles of 8 x 16
##
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
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

enum TILE_SIZE_PX {
	X = 8,
	Y = 16,
}
enum VIEWPORT_SIZE_PX {
	X = 1280, # viewport width in pixels
	Y = 720, # viewport height in pixels
}
enum VIEWPORT_SIZE_IJ {
	J = VIEWPORT_SIZE_PX.X/TILE_SIZE_PX.X, # number of columns (X)
	I = VIEWPORT_SIZE_PX.Y/TILE_SIZE_PX.Y, # number of lines (Y)
}

## Main scene after splash
const SCENE_AFTER_SPLASH = "res://main_menu.tscn"
const CREDITS_SCENE = "res://addons/GodotASCIIToolKit/Credits/ascii_credits_screen.tscn"

## Put ASCII GODOT Splash screen
const SPLASH = false


func _enter_tree() -> void:
	## Adding splash screen
	if Engine.is_editor_hint():
		var main_scene = ProjectSettings.get_setting(
			"application/run/main_scene"
		)
		if SPLASH:
			ProjectSettings.set_setting(
				"application/run/main_scene",
				"res://addons/GodotASCIIToolKit/Splash/ascii_godot_splash_screen.tscn"
			)
		else:
			if main_scene.is_empty():
				ProjectSettings.set_setting(
					"application/run/main_scene",
					SCENE_AFTER_SPLASH
				)
		ProjectSettings.set_setting(
			"display/window/size/viewport_width", VIEWPORT_SIZE_PX.X
		)
		ProjectSettings.set_setting(
			"display/window/size/viewport_height", VIEWPORT_SIZE_PX.Y
		)
		ProjectSettings.set_setting("application/boot_splash/image", false)
		ProjectSettings.set_setting(
			"rendering/textures/canvas_textures/default_texture_filter",
			0
		)


func _exit_tree() -> void:
	if Engine.is_editor_hint():
		if SPLASH:
			var main_scene = ProjectSettings.get_setting(
				"godot_ascii_toolkit/scene_after_splash"
			)
			if main_scene != CREDITS_SCENE:
				main_scene = ""
			ProjectSettings.set_setting(
				"application/run/main_scene",
				main_scene
			)
