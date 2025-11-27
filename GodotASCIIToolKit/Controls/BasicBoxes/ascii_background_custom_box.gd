@tool
class_name ASCIIBackgroundCustomBox
extends ASCIICustomBox
## ASCII box with a solid background

@export var background_visible: bool = true:
	set(value):
		background_visible = value
		property_changed.emit("background_visible", value)
@export var background_color: Color = Color.BLACK:
	set(value):
		background_color = value
		property_changed.emit("background_color", value)


func _ready():
	super()
	$BackgroundRect.visible = background_visible


func _on_property_changed(prop_name, prop_value):
	match prop_name:
		"background_visible":
			$BackgroundRect.visible = prop_value
		"background_color":
			$BackgroundRect.color = background_color
		_:
			super(prop_name, prop_value)

func _lighten_background_color(luminosity: float):
	## Lighten the background for hoovering
	$BackgroundRect.color += Color(luminosity, luminosity, luminosity, 1.0)
	
func _reset_background_color():
	## Resetting to initial background color
	$BackgroundRect.color = background_color
