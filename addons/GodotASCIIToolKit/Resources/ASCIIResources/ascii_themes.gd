@tool
class_name ASCIIThemes
extends Resource

signal themes_changed

## Corresponding Theme Name / index
enum {
	SIMPLE,
	DOUBLE,
	THICK,
	SHARP,
}

## Theme characters enum
enum {
	VERTICAL_LINE,
	HORIZONTAL_LINE,
	TOP_LEFT_CORNER,
	TOP_RIGHT_CORNER,
	BOTTOM_LEFT_CORNER,
	BOTTOM_RIGHT_CORNER,
}

@export var themes : Dictionary[String, String] = {
	"simple":"│─┌┐└┘",
	"double":"║═╔╗╚╝",
	"thick":"██████",
	"sharp":"######",
}:
	set(value):
		themes = value
		themes_changed.emit()


func get_default_theme():
	return themes["simple"]


func get_themes_names():
	return themes.keys()


func get_theme(theme_index: int):
	return themes.values()[theme_index]
