# Godot ASCII ToolKit

**An open source ASCII toolkit for Godot!**

## License

MIT (*cf.* [LICENSE file](LICENSE)). 

## Principle

As mentioned in [this README](../../README.md), the idea is to develop a tool for creating ASCII games while making the most of Godot's features, especially: 
- WYSIWYG editor,
- signal handling,
- tweens and animation players.

So I created tool scripts to mimick the behavior of some Control nodes in Godot (I use the prefix `ASCII`). To do that, I relied mainly on the Label node. I made a custom version of it called `ASCIILabel` loading a custom theme ([`ascii_label_theme.tres`](Resources/Godot/Themes/)) which basically ensure that the Font is [Mx437_IBM_VGA_8x16](Resources/Font/), with correct size of 16 and no line spacing. From that, I build on top to make boxes, text boxes, buttons, *etc.*

I am not sure it is a good idea, so please feel free to share your objections and thoughts with me in the issues section.

## Installation

### Instructions

To install the plugin you can:
- (**easiest**) Install it directly from the Asset Lib dock with the Godot editor!
- (**still very easy**) Download the zip file (from either github, itch.io or the Godot Asset Library) and extract it in your Godot project (`res://addons/GodotASCIIToolKit`).

Then, you just have to enable the plugin in the project settings menu and voilà!

### Upon enabling the plugin

When the plugin is enabled, it modifies the following `ProjectSettings`:
- `"application/boot_splash/show_image"` set to `false`
	In order to replace the original Godot Splash screen by the ASCII Godot splash screen.
- `"application/boot_splash/bg_color"` set to `Color.BLACK`
	Because the ASCII Godot splash background is black.
- `"rendering/textures/canvas_textures/default_texture_filter"` set to nearest:
	So that the ASCII font looks nice and sharp even when zooming in. 
- `"application/run/main_scene"` to `ascii_godot_splash_screen.tscn`
	To replace the original godot splash screen with the ASCII one.
- `"display/window/size/viewport_width"` to 1280 (Godot ASCII ToolKit default)
- `"display/window/size/viewport_height"` to 720 (Godot ASCII ToolKit default)
and creates news ones:
- `"GodotASCIIToolKit/scene_after_ascii_splash_scene"`: `String`
	Path of the scene that goes after the ASCII Godot splash screen.
	When enabling the plugin:
	- if no `main_scene` is defined:
		the scene after splash is set to ascii_credits_screen.tscn, containing the credits for the Godot ASCII ToolKit!
	- if a `main_scene` is defined:
		the scene after splash is set to the `main_scene`.
- `"GodotASCIIToolKit/tile_size_px_x"`: `int = 8`
	The size of an individual ASCII character along the x axis. By default,	a lot of ASCII monospace font are using a character width of 8 pixels.
- `"GodotASCIIToolKit/tile_size_px_x"`: `int = 16`
	The size of an individual ASCII character along the y axis. By default, a lot of ASCII monospace font are using a character width of 16 pixels.

**_Important note_**: The ASCII tools are intended to be used in an editor with specific editor settings; notably: 
- Grid size for 2D editor must be equal to the size of a tile in pixel (i.e. `GodotASCIIToolKit/tile_size_px_x` x `GodotASCIIToolKit/tile_size_px_y`)
- Grid snap activated

- Default Font size is 8x16 (in pixels).
- Default viewport size is 1280x720 in pixels (meaning 160 columns and 45 lines and an aspect ratio of 16:9).
- The tools are **designed to be used with grid snapping on** (the grid must be 8x16). I do not know how to configure this from gdscript, so it has to be done manually in the editor for now.

## Features

### Godot ASCII Splash

I made a Godot ASCII splash screen which replace the original one by default!

### List of custom types

(*parenthesis indicate inheritance*)

- `ASCIILabel(Label)`: Just a label with the good properties for ASCII tools.
- `ASCIIControl(Control)`: Specialization class of Control for ASCII grids.
- `ASCIICustomBox(ASCIIControl)`: A specialized `ASCIIControl` containing a `ASCIILabel` to draw boxes. Box characters are customizable.
- `ASCIIBackgroundCustomBox(ASCIICustomBox)`: `ASCIICustomBox` with a solid background.
- `ASCIIBox(ASCIIBackgroundCustomBox)`: ASCII Box where the box characters are chosen from a list of types.
- `ASCIICustomTextBox(ASCIIBox)`: ASCII text box with custom margins.
- `ASCIITitledBox(ASCIIBox)`: A box with a title on the frame.
- `ASCIIBoxedTextButton(ASCIICustomTextBox)`: ASCII looking button with text and framebox.

Each `class` is documented directly in its gdscript, following the template given in [this section](#documentation-template). 

### ASCII themes customization

The graphical aspects of ASCII UI elements is built on an ASCII theme. 

1. **So, What is an ASCII theme?**

What I call ASCII Theme is a string containing characters used to build ASCII UI elements. Each index in the string correspond to a given "*character function*". For instance, the character at index 0 is used as a vertical line, the character at index 1 as an horizontal line, *etc.*

2. **How does it work in practice?**

In practice, all available themes are embedded within a Godot custom `Resource` called [`ASCIIThemes`](./Resources/ASCIIResources/ascii_themes.gd). `ASCIIThemes` contains a `Dictionary[String, String]` which makes the correspondance between themes names and their respective constitutive strings (*i.e.* the string containing the characters used to build graphical elements such as corners or lines). `ASCIIThemes` also contains an `enum` embedding the correspondance between the character fonction and the index in the constitutive string:

``` gdscript
enum {
	VERTICAL_LINE,
	HORIZONTAL_LINE,
	TOP_LEFT_CORNER,
	TOP_RIGHT_CORNER,
	BOTTOM_LEFT_CORNER,
	BOTTOM_RIGHT_CORNER,
}
```

3. **How to add custom themes?**

When the plugin is enabled, the file `res://addons/GodotASCIIToolKit/Resources/ASCIIResources/ascii_themes.tres` is (if it does not exists) created from the `ASCIIThemes` `Resource`. This way, **the user can add custom new themes by editing this file directly in the Godot editor!**

Another way, for customizing only one instance for an `ASCII` tool that derives from `ASCIICustomBox` is to modify its `box_chars` property.

## Documentation template

Every custom type is documented using the following the template describe in file [full_documentation_template.txt](full_documentation_template.txt)

```
## Script type #################################################################
## Description -----------------------------------------------------------------
##
## Statics ---------------------------------------------------------------------
##
## Enums -----------------------------------------------------------------------
##
## Exported properties ---------------------------------------------------------
##
## Internal properties ---------------------------------------------------------
## 
## Signals ---------------------------------------------------------------------
##
## Nodes created ---------------------------------------------------------------
##
## Comments --------------------------------------------------------------------
## 
## Author(s) -------------------------------------------------------------------
##
################################################################################
```

I will try to document functions more exhaustively.

## Very precise Godot questions: can you help?

- How can I configure grid size and activate grid snap in the 2D editor through gdscript? I know about [EditorSettings](https://docs.godotengine.org/en/stable/classes/class_editorsettings.html), but it does not seem to include it... Other "solutions" I found were more like messy workaround and, when you have to do things like that, it usually means that you've missed something (at least in my own experience).
- I am really confused about themes. I didn't manage to create it from script, so I have to rely on a ressource created from the editor... If someone knows, please show me in the [`ASCIILabel`](Controls/ascii_label.gd).

## Contributing

As long as they are properly documented and respect [gdscript styling](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html), all contributions are welcome!

## Ask for help or new features

Do not hesitate to ask, I know I am not always clear in my explanations. Also, it is always nice to have feedbacks from users to enhance the tool! :) 
