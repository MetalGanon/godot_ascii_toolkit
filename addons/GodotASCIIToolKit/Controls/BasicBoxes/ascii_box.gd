@tool
class_name ASCIIBox
extends ASCIIBackgroundCustomBox
## Plugin custom type ##########################################################
## Description -----------------------------------------------------------------
## ASCII Box where the box characters are chosen from the list of ASCII themes.
##
## Exported properties ---------------------------------------------------------
## - themes_names: Array[String]
##     Empty at init, it then (when _update_themes_list is called) holds the 
##     names of the themes defines in ascii_themes.tres. themes_names is also
##     updated each time ascii_themes.tres changes so that it accounts for user
##     added themes.
##     This variable is used to build the "hint_string" of box_type variable.
##
## - box_types: int
##     The integer corresponding to the index of the ASCII theme used to draw
##     the box. It is selected using the list of themes_names.
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

@export_storage var themes_names: Array[String] = []

var box_type: int:
	set(value):
		box_type = value
		property_changed.emit("box_type", value)


func _ready():
	super()
	ascii_themes.themes_changed.connect(_update_themes_list)
	_update_themes_list()
	box_chars = ascii_themes.get_theme(box_type)


func _get_property_list() -> Array:
	## I am not sure how it works really but this piece of code if from the goat
	var props = []

	props.append({
		"name": "box_type",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(themes_names)
	})
	
	return props


func _update_themes_list():
	themes_names = ascii_themes.get_themes_names()
	# Apparently this calls the above method
	notify_property_list_changed()


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"box_type":
			box_chars = ascii_themes.get_theme(prop_value)
		_:
			super(prop_name, prop_value)
