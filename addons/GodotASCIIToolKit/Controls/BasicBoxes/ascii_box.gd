@tool
class_name ASCIIBox
extends ASCIIBackgroundCustomBox
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
## ASCII Box with list for type of boxes
##
## Box types include (shoule be includes in a class later?)
## - Simple (default)
## - Double
## - Thick
## - Sharp

# I would like it to be static const but hey, var does the trick.
const chars: Array[Array] = [
	['│','─','┌','┐','└','┘'],
	['║','═','╔','╗','╚','╝'],
	['█','█','█','█','█','█'],
	['#','#','#','#','#','#'],
]

@export_enum(
	"Simple",
	"Double", 
	"Thick",
	"Sharp"
) var box_type: int:
	set(value):
		box_type = value
		property_changed.emit("box_type", value)


func _ready():
	super()
	box_chars = chars[box_type]


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"box_type":
			box_chars = chars[prop_value]
		_:
			super(prop_name, prop_value)
