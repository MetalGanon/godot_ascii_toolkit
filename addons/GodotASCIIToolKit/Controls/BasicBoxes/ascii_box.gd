@tool
class_name ASCIIBox
extends ASCIIBackgroundCustomBox
## Doc to be updated
## Plugin custom type ##########################################################
## Description -----------------------------------------------------------------
## ASCII Box where the box characters are chosen from a list of types.
##
## Statics ---------------------------------------------------------------------
## - chars: Array[Array[char]]
##     Array of Array of characters corresponding to box types, i.e. characters 
##     constitutives of the box. Each element coressponds to a box_chars in the  
##     sense of ASCIICustomBox (cf. ascii_custom_box.gd).
##     Index correspond to enum box_type. 
##     I think it should be a ressource loaded externally at terms, in order to
##     box types more easily. 
## Enums -----------------------------------------------------------------------
##
## Exported properties ---------------------------------------------------------
## - box_types: int [ENUM: Simple, "Double", "Thick", "Sharp"]
##     The integer corresponding to the index of the type of box in static chars
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

@export_storage var themes_names = ["1", "2"]

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
	notify_property_list_changed()


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"box_type":
			box_chars = ascii_themes.get_theme(prop_value)
		_:
			super(prop_name, prop_value)
