@tool
class_name ASCIIControl
extends Control
## Plugin custom type ##########################################################
## Description -----------------------------------------------------------------
## Specialization class of Control for ASCII grids.
## - Provides methods to check placement of current node within the ASCII Grid.
## - Handles size and position
## - Handles init of the ASCIIControl nodes (adding required nodes and setting 
##   default values for exported properties if needed).
##
## Internal properties ---------------------------------------------------------
## - size_tile: Vector2i
##     Size in tiles (instead of pixels)
## - position_tile: Vector2i
##     Position in tiles (instead of pixels)
## - minimum_size_tile: Vector2i
##     Used to set the custom_minimum_size property which does not allow to
##     resize below that value in the editor.
##
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

## Size in tiles (instead of pixels)
var size_tile: Vector2i = Vector2i(2, 2)
 ## Position in tiles (instead of pixels)
var position_tile: Vector2i = Vector2i(0, 0) 
## If the size is inferior to minimum size, no update is performed. 
var minimum_size_tile: Vector2i = Vector2i(2, 2)

signal property_changed(name, value)


func _init():
	_add_required_nodes()
	if Engine.is_editor_hint():
		# Node has never been initialized
		if size == Vector2(0.0, 0.0):
			_default_properties()
			var tile_size = get_tile_size()
			custom_minimum_size = Vector2i(
				minimum_size_tile.x*tile_size.x,
				minimum_size_tile.y*tile_size.y,
			)
			size_tile = minimum_size_tile
			set_deferred("size", custom_minimum_size)


func _ready():
	check_grid_conforming()
	property_changed.connect(_on_property_changed)
	_update_protected()


func get_tile_size() -> Vector2i:
	var tile_size_x = ProjectSettings.get_setting(
	"GodotASCIIToolKit/tile_size_px_x"
	)
	var tile_size_y = ProjectSettings.get_setting(
	"GodotASCIIToolKit/tile_size_px_y"
	)
	return Vector2i(tile_size_x, tile_size_y)


func _default_properties():
	pass


func _add_required_nodes():
	## To be overriden in child class
	pass


func _remove_required_nodes():
	## To be overriden in child class
	pass


func _remove_and_free_child(name: String) -> void:
	var node = get_node(name)
	remove_child(node)


func _on_property_changed(_prop_name, _prop_value):
	## To be overriden in child class
	pass


func _update_protected():
	## Update the text after checking it is required
	if _size_tile_changed():
		_update_size_tile()
	_update()


func _update():
	## To be overriden in child class
	pass


func _size_tile_changed() -> bool:
	## Checks if the size in tiles has changed.
	##
	## Return true if the size in tiles has changed. False else. 
	var tile_size = get_tile_size()
	if (size_tile.x != int(size.x / tile_size.x) or 
		size_tile.y != int(size.y / tile_size.y)
	):
		return true
	else:
		return false


func _update_size_tile() -> void:
	## Compute the size of the current control node in tiles
	##
	## from size
	var tile_size = get_tile_size()
	size_tile.x = int(size.x / tile_size.x)
	size_tile.y = int(size.y / tile_size.y)


func _update_size():
	## Compute the size of the current control node in pixels
	##
	## from size_tile
	var tile_size = get_tile_size()
	size.x = size_tile.x * tile_size.x
	size.y = size_tile.y * tile_size.y 


func _position_tile_changed() -> bool:
	## Checks if the position in tiles has changed.
	##
	## Return true if it has. False else. 
	var tile_size = get_tile_size()
	var new_p_tile_x = int(position_tile.x / tile_size.x) 
	var new_p_tile_y = int(position_tile.y / tile_size.y)
	if position_tile.x != new_p_tile_x or position_tile.y != new_p_tile_y:
		return true
	else:
		return false


func _update_position_tile() -> void:
	## Compute the size of the current control node in tiles
	var tile_size = get_tile_size()
	position_tile.x = int(position.x / tile_size.x)
	position_tile.y = int(position.y / tile_size.y)


func check_grid_conforming():
	## Check if position and size is grid conforming.
	##
	## - The size in pixels is a multiple of the tile size in pixel.
	## - The position in pixels is a multiple of the tile size in pixel. 
	## Return true if the nodes is conforming, false else.
	var tile_size = get_tile_size()
	if (int(size.x) % tile_size.x != 0 or 
		int(size.y) % tile_size.y != 0 or
		int(position.x) % tile_size.x != 0 or
		int(position.y) % tile_size.y  != 0
	):
		push_warning(
			"Grid of ASCIIControl named %s is not conforming..." % name
			)


func _notification(what):
	match what:
		NOTIFICATION_RESIZED:
			_update_protected()
