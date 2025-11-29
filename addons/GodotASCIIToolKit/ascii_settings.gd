@tool
extends Node
## Godot ASCII ToolKit #########################################################
##
## Configuration file for the Godot ASCII ToolKit.
##
## Specify the credits scenes and main menu after the Godot ASCII splash.
## 
## The tools are intended to be used in a Godot project and editor with specific
## settings. 
##
## Notably:
## - Editor settings
## -- Grid size for 2D editor must be TILE_SIZE_PX
## -- Grid snap activated
## - ProjectSettings
## -- Viewport size must be VIEWPORT_SIZE_PX (set in the script).
##
## This global tool overrides the mentioned settings when I know how to do it.
##
## This script must be loaded as global.
################################################################################
##
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
################################################################################
# Size of the viewport before activating the plugin
var original_viewport_size: Vector2i

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

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	original_viewport_size.x = ProjectSettings.get_setting(
		"display/window/size/viewport_width"
	)
	original_viewport_size.y = ProjectSettings.get_setting(
		"display/window/size/viewport_height"
	)
	ProjectSettings.set_setting(
		"display/window/size/viewport_width", VIEWPORT_SIZE_PX.X
	)
	ProjectSettings.set_setting(
		"display/window/size/viewport_height", VIEWPORT_SIZE_PX.Y
	)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	ProjectSettings.set_setting(
		"display/window/size/viewport_width", original_viewport_size.x
	)
	ProjectSettings.set_setting(
		"display/window/size/viewport_height", original_viewport_size.y
	)
