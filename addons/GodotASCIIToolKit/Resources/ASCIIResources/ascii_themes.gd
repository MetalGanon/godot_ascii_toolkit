@tool
class_name ASCIIThemes
extends Resource
## Plugin custom resource ######################################################
## Description -----------------------------------------------------------------
## A resource to handles the different ASCII Theme for different UI elements.
##
## What is an ASCII Theme? 
## What I call ASCII Theme is a string containing characters used to build
## ASCII UI elements. Each index in the string correspond to a given 
## "character function". For instance, the character at index 0 is used 
## as a vertical line, the character at index 1 as an horizontal line, etc.
##
## The correspondance between index and character function is given in the
## unamed enum.  
##
## Enums -----------------------------------------------------------------------
## - unamed: {VERTICAL_LINE, HORIZONTAL_LINE, TOP_LEFT_CORNER, ...}
##     Correspondance between the position in the theme string and the character
##     function.
## Exported properties ---------------------------------------------------------
## - themes: Dictionnary[String, String]
##     The actual data of the ressource. Each item key is the name of the theme
##     while the value is the actual theme string.
##
## Signals ---------------------------------------------------------------------
## - themes_changed:
##     Signal emited when the var themes changes. This allow to detect when the
##     user adds news themes in the editor to update related ASCII nodes (such
##     as ASCIIBox which rely on the dictionnary of themes, notably exported 
##     properties.
##
## Comments --------------------------------------------------------------------
## Should add a tutorial some day because it makes it easy to add custom themes.
## 
## Author(s) -------------------------------------------------------------------
## Vost
##
################################################################################

signal themes_changed

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
