@tool
extends ASCIIBox
class_name ASCIITitledBox
## A box with a title on the frame
enum {TOP, BOTTOM}
enum {LEFT, CENTER, RIGHT}

@export var title_text: String = "Das Kapital":
	set(value):
		title_text = value
		property_changed.emit("title_text", value)

@export_enum("Top", "Bottom") var title_vertical_position: int = 0:
	set(value):
		title_vertical_position = value
		property_changed.emit("title_vertical_position", value)

@export_enum("Left", "Center", "Right") var title_horizontal_alignment: int = 0:
	set(value):
		title_horizontal_alignment = value
		property_changed.emit("title_horizontal_alignment", value)


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"title_text":
			_update_protected()
		"title_vertical_position":
			_update_protected()
		"title_horizontal_alignment":
			_update_protected()
		_:
			super(prop_name, prop_value)


func _compute_box_str() -> String:
	## Override of the compute box for title
	if size_tile.x >= title_text.length() + 2:
		# First line
		var box_str : String = _compute_first_line()
		# Loop over the remaining lines except the last one...
		for j in range(1, size_tile.y-1):
			box_str += (
				box_chars[VERTICAL_LINE] +
				" ".repeat(size_tile.x - 2) +
				box_chars[VERTICAL_LINE] + "\n"
			)
		# Last line
		box_str += _compute_last_line()
		return box_str
	else:
		return super()


func _compute_first_line() -> String:
	if title_vertical_position == TOP:
		return _compute_title_line(
			box_chars[TOP_LEFT_CORNER],
			box_chars[HORIZONTAL_LINE],
			box_chars[TOP_RIGHT_CORNER],
		)
	else:
		return (
			box_chars[TOP_LEFT_CORNER] + 
			box_chars[HORIZONTAL_LINE].repeat(size_tile.x-2) +
			box_chars[TOP_RIGHT_CORNER] + "\n"
		)


func _compute_last_line() -> String:
	if title_vertical_position == BOTTOM:
		return _compute_title_line(
			box_chars[BOTTOM_LEFT_CORNER],
			box_chars[HORIZONTAL_LINE],
			box_chars[BOTTOM_RIGHT_CORNER],
		)
	else:
		return (
			box_chars[BOTTOM_LEFT_CORNER] + 
			box_chars[HORIZONTAL_LINE].repeat(size_tile.x-2) +
			box_chars[BOTTOM_RIGHT_CORNER] + "\n"
		)


func _compute_title_line(left_corner, horizontal_line, right_corner) -> String:
	var line: String = left_corner
	match title_horizontal_alignment:
		LEFT:
			line += (
				title_text + 
				horizontal_line.repeat(
					size_tile.x-2-title_text.length()
				)
			)
		RIGHT:
			line += (
				horizontal_line.repeat(
					size_tile.x-2-title_text.length()
				) + 
				title_text
			)
		CENTER:
			var a = (size_tile.x-2-title_text.length()) / 2
			var b = (size_tile.x-2-title_text.length()) - a
			line += (
				horizontal_line.repeat(a) + 
				title_text +
				horizontal_line.repeat(b)
			)
	line += right_corner + "\n"
	return line
