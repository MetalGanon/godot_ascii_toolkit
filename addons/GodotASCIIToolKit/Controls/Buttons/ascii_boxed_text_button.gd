@tool
class_name ASCIIBoxedTextButton
extends ASCIICustomTextBox
## Plugin custom type ##########################################################
## Description -----------------------------------------------------------------
## ASCII looking button with text and framebox.
## Includes:
## - background lightening when hoovering,
## - background/text color inverting when clicking.
##
## Exported properties ---------------------------------------------------------
## - hoover: bool
##     Enable/disable hoovering.
##
## Signals ---------------------------------------------------------------------
## - button_down
##    Aim at mimicking the button_down signal of Button (i.e. left click down)
## - button_up
##    Aim at mimicking the button_up signal of Button (i.e. left click released)
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

@export var hoover: bool = true

signal button_down
signal button_up


func _ready():
	super()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	for node in get_children():
		node.mouse_filter = MOUSE_FILTER_PASS
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	if not $BoxLabel.has_theme_color_override("font_color"):
		$BoxLabel.add_theme_color_override("font_color", Color.WHITE)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
			_invert_colors()
			button_down.emit()
		if event.button_index == MOUSE_BUTTON_LEFT && event.is_released():
			_invert_colors()
			button_up.emit()

func _default_properties():
	super()
	text = "Grève Générale!"

func _on_mouse_entered():
	## used for the hoover if set
	if hoover:
		_lighten_background_color(0.25)

func _on_mouse_exited():
	## used for the hoover if set
	if hoover:
		_reset_background_color()

func _invert_colors():
	## Inverts background and text color
	var curr_background_color = background_color
	var curr_text_color = $BoxLabel.get_theme_color("font_color")
	background_color = curr_text_color
	$BackgroundRect.color = curr_text_color
	$BoxLabel.set("theme_override_colors/font_color", curr_background_color)
	$TextLabel.set("theme_override_colors/font_color", curr_background_color)
