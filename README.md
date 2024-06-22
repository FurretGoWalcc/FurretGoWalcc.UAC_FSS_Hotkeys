---
aliases: []
creation date: 2024-06-21 23:17
modification date: Friday 21st June 2024 23:17:37
---

> He who lives in harmony with himself lives in harmony with the universe.
> — <cite>Marcus Aurelius</cite>



This is basically a bunch of hotkeys I've compiled to help with playing FSS and UAC in general.
# Hotkeys
## General
I've included a couple general hotkeys with this script which have been helpful but are not directly related to FSS.

![](generalhotkeys.png)

1. Fireteam TL Designate is mapped to `Xbutton2`, which for me is the top button on my mouse. This simulates a middle-mouse press, which for me is very helpful since my mine is broken, but in general is a better mapping for it because you do not have to move fingers from the left or right mouse buttons.
2. <u> Inventory</u>: 
	1. Press a number key 2-6 to activate numpad 2-6. If your SC2 inventory buttons are mapped to numpad, this means that you can simulate clicking on the inventory by pressing a convenient number key.
	2. To turn Inventory Hotkeys On/Off, use the lower button on the mouse, `XButton1`.
	3. The inventory hotkey's can be manually adjusted in SC2, but I disliked the idea of using an inventory system that would conflict with my control groups while playing PL.
	4. `Ctrl+alt+d` disables and enables `2` inventory hotkey, so it is always available for control groups (like group one). Helpful when playing classes like JTAC/Ghost who needs control group two open for heli and ion, or for BBs. Activate this like you would `ctrl+alt+del`

## Shelling
These hotkeys control FSS's shelling parameters. **Shelling hotkeys are disabled when the program is started**. You can toggle them On/Off by pressing `ctrl+alt+s`, activate this like you would `ctrl+alt+del`.
**Note**: Most hotkeys in this guide are notated with `key+#`. Unless otherwise specified, these are sequential hotkeys- you do *not* have to hold the key at the same time as the number. Press and release the key, then press the number you wish.

![](shellmodehotkeys.png)

<u> Shell Count</u>: 
- Use `s+#` to adjust shell count. Ex: entering `s`, then `5`, would set to 5 shells.
- Use `s+s+#` to get more than 5 shells, Ex: entering `ss`, then `1` would send 6 shells, `ss`, then `2` would send 7, etc.

<u> Interval/Movespeed</u>: 
Use `caps-lock+#` to set movespeed of the shell.
There is two intervals that can be set (and will store their value independently)
1. Tracking (moving) shells. This is designed to match the speed of some zombie.
	- Because interval is unintuitive, I've abstracted it away. Pressing `caps+1` gives you an interval that makes your shells move at 2.5 movespeed, and then each number greater than 1 increases it by 0.25 movespeed. Ex: `caps+7` gives 4 movespeed shells.
	- For those uninitiated in the greater theory of shellonomics, most things move around 3.00 movespeed, so start at `caps+3` and adjust as needed.
2. Stationary. When your shells are set to fall in a circle (you just used `g+s`), you are setting large time intervals.
	- The `1` key is the smallest interval possible, the rest are one less than the number in seconds. Ex:
		- `caps-lock+1` will set interval to 0.2 (drop a shell every 1/5 second) (default)
		- `caps-lock+2` will set interval to 1 (drop a shell every 1 second)
		- `cap-lock+3` will set interval to 2...
	- Can be a helpful alternative to saturation on areas like bridges or for area denial on low hp targets (PMC).

<u> Directional</u>: 
- Press `g+{q,w,e,d,c,x,z,a,s}` to change direction
- Imagine a circle centered on the `s` key, with 0 degrees being East and 90 degrees being North. Doing `g+e` gives you a shell that moves towards 45 degrees. Doing `g+x` gives you a shell that moves towards 270 degrees. 
- `g+s` sets your direction to `-d c` and interval as fast as possible (`-i 0.2`, which lines up with movespeed of 5.0). This is unrecommended because it builds bad habits and can waste shells, but I included it because when you are shelling with 2 or less shells, direction isn't quite as important. You will have to set movespeed back manually after using circular shells.
- To use railgun, press `g` then `g` again, it will send an actual `g` instead of waiting for direction.
- When direction is set with `g`, it will also send out a line to change the A-10 direction to the same (Ex: `g+a` will send `-a 180`)

<u> Shelling Mode</u>: 
To toggle between modes, press the grave key (the weird 'apostrophe' that is to the right of 1 key and above tab).
There are two shell modes: Tracking and Saturation.
1. Tracking is best suited for shelling accurately or having your shells "track" a target. This is the default mode.
2. Saturation is all about getting shells on the ground quickly to hit low HP targets and lower IL. 
	- Here is a rough Desmos graph of what saturation looks like:
	
	![](saturation.png)
	
	- The red circles represent areas where full shell damage is done, the blue is 60%, and green is 40%. At 4k damage a shell, anywhere you get two greens overlapping or one blue is enough to kill a hunter/yeti in non UT1 modes (>2k damage).
	- Basically, the radius is set so that the pattern above is gonna be right for units moving at 3.0 movespeed at a shell interval of 0.2. 
	- You can add more shells to this mode to make it longer, and adjust the direction, but changing interval has no effect on the command that will be sent out.
	- Saturation is designed to be fire backwards rather than forwards, which  makes it easier to time to hit the first unit in a train of hunters/yetis/cursed/lacs.

<u> Rocket Barrage</u>: 
- Very similar to shell count setting.
- Use `b+#` to adjust rocket count. Ex: entering `b`, then `1`, would set to 4 rockets.
- Each number steps up by 2, so `b+2` sends 6, `b+3` sends 8.
- Use `b+b+#` to get more than 12 rockets, Ex: entering `bb`, then `1` would send 14 rockets, `bb`, then `5` would send 24, etc.
## Understanding the Shelling Output
Every time you change a parameter, the program will send out the unified command to adjust the parameters ingame plus some additional info which may be helpful.

![](shellmodeoutput.png)

Shell, direction, interval, and radius should be self-explanatory at this point. The first extra thing added is the movement speed that you are set to. The second is the cardinal direction equivalent of the direction in degrees.

# Installation
Basically there's two options:
1. Download the compiled .exe from the releases tab of GitHub and double click it to start up the hotkey like any other program (as far as I know, a limitation of AHK is that it's restricted to Windows OS). It's set to not trigger any hotkeys unless SC2 is open.
2. If you distrust downloading the program directly, cannot use the compiled version for one reason or another, or want to edit the script yourself, you can either compile it from source or run the .ahk file directly.
	1. Either way, you will want to go grab a version of AHK at https://www.autohotkey.com/.
	2. If you are compiling, go look at the docs at https://www.autohotkey.com/docs/Scripts.htm#ahk2exe for guidance.
	3. If you want to run the scripts directly without compiling, download the source file (or copy paste it into a new script), and double click the .ahk file to run. 