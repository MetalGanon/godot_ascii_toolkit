@tool
class_name ASCIIBackgroundCustomBox
extends ASCIICustomBox
## Plugin custom type ##########################################################
## Description -----------------------------------------------------------------
## ASCII box with a solid background
##
## Exported properties ---------------------------------------------------------
## - background_visible: bool
##     Is the background visible or not.
## - background_color: Color
##     The background rectangle color.
##
## Nodes created ---------------------------------------------------------------
## - Nodes of all super class
## - "BackgroundRect": ColorRect
##     The background rectangle.
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

@export var background_visible: bool = true:
	set(value):
		background_visible = value
		property_changed.emit("background_visible", value)
@export var background_color: Color = Color.BLACK:
	set(value):
		background_color = value
		property_changed.emit("background_color", value)


func _ready():
	super()
	$BackgroundRect.visible = background_visible
	$BackgroundRect.color = background_color

func _add_required_nodes():
	## Adding box label
	var background_rect = ColorRect.new()
	background_rect.name = "BackgroundRect"
	background_rect.color = background_color
	background_rect.visible = background_visible
	background_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(background_rect)
	super()


func _remove_required_nodes():
	_remove_and_free_child("BackgroundRect")
	super()


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"background_visible":
			$BackgroundRect.visible = prop_value
		"background_color":
			$BackgroundRect.color = prop_value
		_:
			super(prop_name, prop_value)

func _lighten_background_color(luminosity: float):
	## Lighten the background for hoovering
	$BackgroundRect.color += Color(luminosity, luminosity, luminosity, 1.0)
	
func _reset_background_color():
	## Resetting to initial background color
	$BackgroundRect.color = background_color
