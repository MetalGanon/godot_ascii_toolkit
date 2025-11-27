@tool
class_name ASCIIBox
extends ASCIIBackgroundCustomBox
## ASCII Box with list for type of boxes
##
## Box types include (shoule be includes in a class later?)
## - Simple (default)
## - Double
## - Thick
## - Sharp

static var chars: Array[Array] = [
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


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"box_type":
			box_chars = chars[box_type]
		_:
			super(prop_name, prop_value)
