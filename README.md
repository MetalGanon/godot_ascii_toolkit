# Godot ASCII ToolKit

**An open source ASCII toolkit for the game engine Godot!**

This is the official repository for the GodotASCIIToolKit, a plugin of the game engine [Godot](https://godotengine.org/).

This repository contains:
- the sources of the plugin in [`addons/GodotASCIIToolKit`](./addons/GodotASCIIToolKit);
- a minimal working [Godot project](project.godot) using that plugin. It involves a ASCII splash screen of Godot, a main menu and a credits scene. 



While this doesn't work for all dialects of Markdown, I got this to work with GitLab, GitHub, and mdBook.

Basically, you create the table via HTML. Markdown and HTML don't mix well, but if you surround the Markdown with whitespace, sometimes the Markdown can be recognized.

https://docs.gitlab.com/ee/user/markdown.html#inline-html

<table>
<tr>
<td>

## Disclaimer

English is not my native language, so sorry in advance if I am not clear enough when explaining things. 

## Description

This plugin aims at providing tools to develop ASCII games in Godot while still using all its handy features at maximum. 

For now, only some Controls (User Interface) tools are available. 

## Usage

To use it, copy the directory `addons/GodotASCIIToolKit` in your Godot project (`res://addons/GodotASCIIToolKit`) and activate the plugin in the project settings menu.


</td>
<td>

```
                      ...          ...                      
                 ..++++++.        .++++++..                 
                 .++++++++.      .++++++++.                 
                 .++++++++++++++++++++++++.                 
                 .++++++++++++++++++++++++.                 
       ++.    ..++++++++++++++++++++++++++++..    .++       
     .++++++.++++++++++++++++++++++++++++++++++.++++++.     
   .++++++++++++++++++++++++++++++++++++++++++++++++++++.   
   .++++++++++++++++++++++++++++++++++++++++++++++++++++.   
    .++++++++++++++++++++++++++++++++++++++++++++++++++.    
      +++++++++++##++++++++++++++++++++++##+++++++++++      
      +++++++#@@@@@@@#++++++++++++++++#@@@@@@@#+++++++      
      ++++++#@@+....+@#+++++#@@#+++++#@+....+@@#++++++      
      ++++++@@+ .... #@+++++@@@@+++++@# .... +@@++++++      
      ++++++#@@+....+@#+++++@@@@+++++#@+....+@@#++++++      
      +++++++#@@@###@#++++++@@@@++++++#@###@@@#+++++++      
      +++++++++++##++++++++++##++++++++++##+++++++++++      
      +#++++++++++++++++++++++++++++++++++++++++++++#+      
      #@@@@@@@@#+++++++++##########+++++++++#@@@@@@@@#      
      .+++++++@@++++++++@@@@@@@@@@@@++++++++@@++++++++      
      .+++++++#@########@@++++++++@@########@#+++++++.      
       ++++++++##@@@@@@@@#++++++++#@@@@@@@@##++++++++       
        .++++++++++++++++++++++++++++++++++++++++++.        
          .++++++++++++++++++++++++++++++++++++++.          
             ..++++++++++++++++++++++++++++++..             
                    ......++++++++.......                   
```

</td>
</tr>
</table>

## Disclaimer

English is not my native language, so sorry in advance if I am not clear enough when explaining things. 

## Description

This plugin aims at providing tools to develop ASCII games in Godot while still using all its handy features at maximum. 

For now, only some Controls (User Interface) tools are available. 

## Usage

To use it, copy the directory `addons/GodotASCIIToolKit` in your Godot project (`res://addons/GodotASCIIToolKit`) and activate the plugin in the project settings menu.

## Motivations

I can draw a bit, but I am not able to make beautiful game assets. Being mainly suited for programming, ASCII-based graphics seemed natural.

Moreover, I am truly amazed by the quality of certain forms of ASCII art despite their apparent simplicity. I am a huge fan of [Dwarf Fortress](https://www.bay12games.com/dwarves/) and [Candy Box 2](https://candybox2.github.io/) but my main reference here is [Stone Story RPG](https://stonestoryrpg.com/). It is an idle game (so almost exclusively pieces of UI) and, even if it is not scrictly ASCII, it is the most beautiful ASCII-based video game I have ever seen.

I have been using Godot to program games for 4 or 5 years, so the question raised naturally: *how can I program a Stone Story RPG-like using godot?*

I made a quick review of existing tools and assets:
- user nofacer made an [ASCII Screen plugin](https://godotengine.org/asset-library/asset/4336) to put characters on a screen manually in a very [RoguelikeDev](https://www.reddit.com/r/roguelikedev/wiki/) way. While it is awesome for learning how to code, making something as graphically complex as Stone Story RPG with this method would be a real pain. Furthermore, it does not take advantage of Godot and its great features, especially the WYSIWYG editor and animation players. 
- People also made ASCII shaders (*e.g.* [Dan's](https://godotshaders.com/shader/ascii-shader/)) which is very cool! However, it seems more suited as a filter for 3D games aiming for a retro vibe. Out of the present scope.

So you know what they say, when the right tool does not exist, then you have to build it; that's what I do!

## Further information

For documentation and details about the plugin, please refer to [this README](./addons/GodotASCIIToolKit/README.md).

## Credits

```
 a88888b.  888888ba   88888888b 888888ba  dP d888888P .d88888b 
d8'   `88  88    `8b  88        88    `8b 88    88    88.    "'
88        a88aaaa8P' a88aaaa    88     88 88    88    `Y88888b.
88         88   `8b.  88        88     88 88    88          `8b
Y8.   .88  88     88  88        88    .8P 88    88    d8'   .8P
 Y88888P'  dP     dP  88888888P 8888888P  dP    dP     Y88888P 
 ```



 ```
  _  __ ________    __ _    ___ __
|_|(_ /   |  |    |_ / \|\| | (_ 
| |__)\___|__|_   |  \_/| | | __)
```

- Bigfig - Glenn Chappell
- Nancyj - Vampyr
- [Mx437 IBM VGA 8x16](https://fontinfo.opensuse.org/fonts/Mx437IBMVGA8x16Regular.html)

 ```
  _  __ ________   ___ _  _     __
|_|(_ /   |  |     | / \/ \|  (_ 
| |__)\___|__|_    | \_/\_/|____)
```

- 
- [ASCII Art Archive](https://www.asciiart.eu/)
- [ascii-image-converter](https://github.com/TheZoraiz/ascii-image-converter)
