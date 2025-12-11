@tool
class_name ASCIICustomTextBox
extends ASCIIBox
## Plugin custom type ##########################################################
## Description -----------------------------------------------------------------
## ASCII box containing text.
## The margins are customizable, that is why is class is refered as "custom".
##
## Enums -----------------------------------------------------------------------
## - unamed: {LEFT, RIGHT, TOP, BOTTOM}
##     Enum for margins index.
##
## Exported properties ---------------------------------------------------------
## - text: String
##     Text to be displayed inside the textbox.
## - box_visible: bool
##     Boolean that sets the visibility of the framebox.
## - horizontal_alignment: int
##     Horizontal alignment of the text within the framebox.
## - vertical_alignment: int
##     Vertical alignment of the text within the framebox.
## - margins: Array[int] (length = 4)
##     Value of the margins of the text with respect to the framebox in tiles.
##     Corresponding index is given by enum. 
##
## Nodes created ---------------------------------------------------------------
## - Nodes of all super class
## - "TextLabel": ASCIILabel
##     Displays the text of the text box.
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

enum {
	LEFT,
	RIGHT,
	TOP,
	BOTTOM,
}

@export var text: String:
	set(value):
		text = value
		property_changed.emit("text", value)

@export var box_visible: bool = true:
	set(value):
		box_visible = value
		property_changed.emit("box_visible", value)

@export_enum(
	"Left",
	"Center",
	"Right",
) var horizontal_alignment: int = 0:
	set(value):
		horizontal_alignment = value
		property_changed.emit("horizontal_alignment", value)

@export_enum(
	"Top",
	"Center",
	"Bottom",
) var vertical_alignment: int = 0:
	set(value):
		vertical_alignment = value
		property_changed.emit("vertical_alignment", value)

@export var margins: Array[int] = [1, 1, 0, 0]:
	set(value):
		margins = value
		property_changed.emit("margins",value)


func _ready():
	super()
	$BoxLabel.visible = box_visible
	$TextLabel.text = text
	$TextLabel.horizontal_alignment = horizontal_alignment
	$TextLabel.vertical_alignment = vertical_alignment
	$TextLabel.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	_update_margins()


func _add_required_nodes():
	super()
	## Adding text label
	var text_label = ASCIILabel.new()
	text_label.clip_text = true
	text_label.name = "TextLabel"
	text_label.text = text
	text_label.horizontal_alignment = horizontal_alignment
	text_label.vertical_alignment = vertical_alignment
	text_label.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	add_child(text_label)


func _remove_required_nodes():
	_remove_and_free_child("TextLabel")


func _default_properties():
	super()
	_update_minimum_size_tile()
	text = "Workers of the world, unite!"


func _update_minimum_size_tile():
	minimum_size_tile = Vector2i(
		1+margins[LEFT]+1+margins[RIGHT]+1, # box + margins + 1 char
		1+margins[TOP]+1+margins[BOTTOM]+1, # box + margins + 1 char
	)


func _update():
	super()
	_update_margins()


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"box_visible":
			$BoxLabel.visible = prop_value
		"text":
			$TextLabel.text = prop_value
		"margins":
			_update_margins()
			_update_protected()
		"horizontal_alignment":
			$TextLabel.horizontal_alignment = horizontal_alignment
		"vertical_alignment":
			$TextLabel.vertical_alignment = vertical_alignment
		_:
			super(prop_name, prop_value)


func _update_margins():
	_update_minimum_size_tile()
	var tile_size = get_tile_size()
	$TextLabel.set_deferred("position", Vector2i(
		(1 + margins[LEFT]) * tile_size.x,
		(1 + margins[TOP]) * tile_size.y,
	))
	var new_size_tile = Vector2i(
		(size_tile.x - margins[LEFT] - margins[RIGHT] - 2),
		(size_tile.y - margins[TOP] - margins[BOTTOM] - 2),
	)
	$TextLabel.set_deferred("size", Vector2i(
		new_size_tile.x * tile_size.x,
		new_size_tile.y * tile_size.y,
	))
