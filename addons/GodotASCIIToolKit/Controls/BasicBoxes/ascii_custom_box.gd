@tool
class_name ASCIICustomBox
extends ASCIIControl
## Plugin custom type ##########################################################
## Description -----------------------------------------------------------------
## A specialized ASCIILabel to draw boxes
## Defines the characters you want to surround your box
##
## Enums -----------------------------------------------------------------------
## - unamed: {VERTICAL_LINE,...}
##     Correspondance between box_chars index and line of the box.
##     e.g. index 0 of array box_chars is the character corresponding to the 
##     vertical lines of the box.
## Exported properties ---------------------------------------------------------
## - box_chars: Array[char] (I know char do not exist in Godot)
##     Is the background visible or not.
##
## Nodes created ---------------------------------------------------------------
## - Nodes of all super class
## - "BoxLabel": ASCIILabel
##     Contains the label of the box.
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

## Enums
enum {
	VERTICAL_LINE,
	HORIZONTAL_LINE,
	TOP_LEFT_CORNER,
	TOP_RIGHT_CORNER,
	BOTTOM_LEFT_CORNER,
	BOTTOM_RIGHT_CORNER,
}

## Drawing attributes
@export var box_chars: Array = ['│','─','┌','┐','└','┘']:
	set(value):
		box_chars = value
		property_changed.emit("box_chars", value)


func _init() -> void:
	minimum_size_tile = Vector2i(2,2)


func _add_required_nodes():
	super()
	## Adding box label
	var box_label = ASCIILabel.new()
	box_label.clip_text = true
	box_label.name = "BoxLabel"
	box_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(box_label)


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"box_chars":
			_update_protected()
		_:
			super(prop_name, prop_value)

func _compute_box_str() -> String:
	## Compute the box string depending on its size in tiles.
	# First line
	var box_str : String = (
		box_chars[TOP_LEFT_CORNER] + 
		box_chars[HORIZONTAL_LINE].repeat(size_tile.x-2) +
		box_chars[TOP_RIGHT_CORNER] + "\n"
	)
	# Loop over the remaining lines except the last one...
	for j in range(1, size_tile.y-1):
		box_str += (
			box_chars[VERTICAL_LINE] +
			" ".repeat(size_tile.x - 2) +
			box_chars[VERTICAL_LINE] + "\n"
		)
	# Last line
	box_str += (
		box_chars[BOTTOM_LEFT_CORNER] + 
		box_chars[HORIZONTAL_LINE].repeat(size_tile.x-2) +
		box_chars[BOTTOM_RIGHT_CORNER] + "\n"
	)
	return box_str


func _update():
	## Compute the box and change the text of the label accordingly
	$BoxLabel.text = _compute_box_str()
