@tool
class_name ASCIIBoxedTextButton
extends ASCIICustomTextBox
## Just an ASCII looking button with a framebox.

@export var hoover: bool = true
@export_enum("Invert") var hoover_behavior: int = 0

signal button_down
signal button_up


func _ready():
	super()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	if not $BoxLabel.has_theme_color_override("font_color"):
		$BoxLabel.add_theme_color_override("font_color", Color.WHITE)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
			_invert_colors()
			button_down.emit()
		if event.button_index == MOUSE_BUTTON_LEFT && event.is_released():
			_invert_colors()
			button_up.emit()

func _on_mouse_entered():
	## used for the hoover if set
	_lighten_background_color(0.25)

func _on_mouse_exited():
	## used for the hoover if set
	_reset_background_color()

func _invert_colors():
	## Inverts background and text color
	var curr_background_color = $BackgroundRect.color
	var curr_text_color = $BoxLabel.get_theme_color("font_color")
	$BackgroundRect.color = curr_text_color
	$BoxLabel.set("theme_override_colors/font_color", curr_background_color)
	$TextLabel.set("theme_override_colors/font_color", curr_background_color)
