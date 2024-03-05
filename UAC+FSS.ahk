#NoEnv
#KeyHistory 0
ListLines Off
InvMode := false
ShellMode := false
InputVar := 0
Angle := 0
Cardinal := "E"
Shell := 1
Radius := 1
Interval := 0.3333
Movespeed := 3.00
Rockets := 0

Tracking := true ; Shell config used
; A couple variables used for conditional hotkeys
DisableInventory := false
DisableHotkeys := false ; prevents a second hotkey trigger when recieving Input
DisableNumTwo := false ; on MOS like ghost, having control group 2 always selectable is more important than inventory

#If WinActive("ahk_class StarCraft II")

XButton2::
SendInput {MButton}
return

; Begin Shell Mode Code:
#If WinActive("ahk_class StarCraft II") and ShellMode and not DisableHotkeys

; Saturation, Spam some shells in a line going backwards
`::
Tracking := !Tracking
SendShell()
return

; When someone is manually typing, don't trigger hotkeys!
Enter::
SendInput, {Enter}
DisableHotkeys := true
Input, InputVar,V * T15,{Enter}{Escape},
DisableHotkeys := false
return

; Shell Count
s::
DisableHotkeys := true
DisableInventory := true
Input, InputVar, L1 T1,,1,2,3,4,5,s
if (ErrorLevel = "Match") {
	if (InputVar = "s") {
		Input, InputVar2, L1 T1,,1,2,3,4,5
		if (ErrorLevel = "Match") {
			Shell := InputVar2+5
		}
	}
	else
		Shell := InputVar
	SendShell()
}
DisableHotkeys := false
DisableInventory := false
return

; Direction
g::
DisableHotkeys := true
Input, InputVar, L1 T1,,a,q,w,e,d,c,x,z,s,g
if (ErrorLevel = "Match") {
	switch InputVar {
		case "q":
		Angle := "135"
		Cardinal := "NW"
		case "w":
		Angle := "90  "
		Cardinal := "N "
		case "e":
		Angle := "45  "
		Cardinal := "NE"
		case "d":
		Angle := "360"
		Cardinal := "E "
		case "c":
		Angle := "315"
		Cardinal := "SE"
		case "x":
		Angle := "270"
		Cardinal := "S "
		case "z":
		Angle := "225"
		Cardinal := "SW"
		case "a":
		Angle := "180"
		Cardinal := "W "
		case "s":
		Angle := "c"
		Cardinal := "  "
		case "g": {
			SendInput g
			DisableHotkeys := false
			return
		}
	}
	SendShell()
}
DisableHotkeys := false
return

; Interval
CapsLock::
DisableInventory := true
Input, InputVar, L1 T1,,,1,2,3,4,5,6,7,8
if (ErrorLevel = "Match") {
	switch InputVar {
		case 1:
		Interval := 0.4000 ; 2.50
		Movespeed := 2.50
		case 2:
		Interval := 0.3636 ; 2.75
		Movespeed := 2.75
		case 3:
		Interval := 0.3333 ; 3
		Movespeed := 3.00
		case 4:
		Interval := 0.3077 ; 3.25
		Movespeed := 3.25
		case 5:
		Interval := 0.2857 ; 3.5
		Movespeed := 3.50
		case 6:
		Interval := 0.2667 ; 3.75
		Movespeed := 3.75
		case 7:
		Interval := 0.2500 ; 4
		Movespeed := 4.00
		case 8:
		Interval := 0.2000 ; 5
		Movespeed := 5.00	
	}
	SendShell()
}
DisableInventory := false
return

SendShell() {
	global
	if(Tracking) {
		if(Angle="c") {
			str := "{enter}-c " . Shell . " c 0.2 " . Radius . "     5.00 Stationary{enter}"
		}
		else {
			str := "{enter}-c " . Shell . " " . Angle . " " . Interval . " " . Radius . "     " . Movespeed . " " . Cardinal . "{enter}" 
		}
	}
	else {
		str := "{enter}-c " . Shell . " " . Angle . " 0.2 2.4      " . Cardinal . " Saturation{enter}"
	}
	SendInput % str
	return
}

; Suppresive Barrage Rockets
b::
DisableHotkeys := true
DisableInventory := true
Input, InputVar, L1 T1,,1,2,3,4,5,b
if (ErrorLevel = "Match") {
	if (InputVar = "b") {
		Input, InputVar2, L1 T1,,1,2,3,4,5
		if (ErrorLevel = "Match") {
			Rockets := (InputVar2*2)+12
		}
	}
	else
		Rockets := (InputVar*2)+2
	SendInput % "{enter}-b " . Rockets . "{enter}"
}
DisableHotkeys := false
DisableInventory := false
return

#If ; End Shell mode code

; Swap Between Ctrl Group and Inventory Numbers
XButton1::
InvMode := !InvMode
return

^!s::
ShellMode := !ShellMode
return

^!d::
DisableNumTwo := !DisableNumTwo
return

SetNumLockState, On

; Map numbers to numpad if InvMode
#If InvMode and not DisableInventory and not DisableNumTwo
2::SendInput {Numpad2}
return
#If InvMode and not DisableInventory
3::SendInput {Numpad3}
return
4::SendInput {Numpad4} 
return
5::SendInput {Numpad5} 
return
6::SendInput {Numpad6} 
return
#If
^e::
Gui, Hide
ExitApp
return
