@tool
class_name ASCIICustomTextBox
extends ASCIIBox
## Text box with custom margins
##
## Some more description
enum {
	LEFT,
	RIGHT,
	TOP,
	BOTTOM,
}

@export var text: String = "Worker of the world, unite!":
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


func _init():
	_update_minimum_size_tile()


func _ready():
	super()
	$TextLabel.text = text
	$TextLabel.horizontal_alignment = horizontal_alignment
	$TextLabel.vertical_alignment = vertical_alignment


func _update_minimum_size_tile():
	minimum_size_tile = Vector2i(
		1+margins[LEFT]+1+margins[RIGHT]+1, # box + margins + 1 char
		1+margins[TOP]+1+margins[BOTTOM]+1, # box + margins + 1 char
	)


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
	var new_position = Vector2i(
		(1 + margins[LEFT]) * GodotASCIIToolKit.TILE_SIZE_PX.X,
		(1 + margins[TOP]) * GodotASCIIToolKit.TILE_SIZE_PX.Y,
	)
	$TextLabel.position = new_position 
	var new_size_tile = Vector2i(
		(size_tile.x - margins[LEFT] - margins[RIGHT] - 2),
		(size_tile.y - margins[TOP] - margins[BOTTOM] - 2),
	)
	$TextLabel.set_deferred("size", Vector2i(
		new_size_tile.x * GodotASCIIToolKit.TILE_SIZE_PX.X,
		new_size_tile.y * GodotASCIIToolKit.TILE_SIZE_PX.Y,
	))


func _update():
	super()
	$TextLabel.visible = true


func _invalid_update():
	$TextLabel.visible = false
