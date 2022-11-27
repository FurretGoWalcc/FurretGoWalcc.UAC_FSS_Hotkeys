#NoEnv
#KeyHistory 0
ListLines Off
InvMode := false
ShellMode := false
InputVar := 0
Angle := 0
Shell := 1
Radius := 1
Interval := 0.8000
Movespeed := 0

Tracking := true ; Shell config used
; A couple variables used for conditional hotkeys
DisableInventory := false
DisableHotkeys := false ; prevents a second trigger when recieving Input

^!s::
ShellMode := !ShellMode
RefreshGui()
return

#If WinActive("ahk_class StarCraft II")

XButton2::
SendInput {MButton}
return

; Begin Shell Mode Code:

; Shells
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
; MsgBox, "Hotkeys disabled"
Input, InputVar,V * T15,{Enter}{Escape},
if(InStr(ErrorLevel, "EndKey:")) {
	; MsgBox, "Hotkeys back on"
	DisableHotkeys := false
}
else if (ErrorLevel = "Timeout")
	DisableHotkeys := false
	; MsgBox, "Hotkeys back on"
return

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
	RefreshGui()
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
		Angle := 135
		case "w":
		Angle := 90
		case "e":
		Angle := 45
		case "d":
		Angle := 360
		case "c":
		Angle := 315
		case "x":
		Angle := 270
		case "z":
		Angle := 225
		case "a":
		Angle := 180
		case "s":
		Angle := "c"
		Interval := 0.2
		Movespeed := 5
		case "g":
		SendInput g
	}
	SendShell()
	RefreshGui()
}
DisableHotkeys := false
return

; Interval
CapsLock::
DisableInventory := true
Input, InputVar, L1 T1,,,1,2,3,4,5,6,7
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
	}
	SendShell()
	RefreshGui()
}
DisableInventory := false
return

SendShell() {
	global
	if(Tracking) {
		str := "{enter}-c " . Shell . " " . Angle . " " . Interval . " " . Radius . "     " . Movespeed . " Tracking{enter}" 
	}
	else {
		str := "{enter}-c " . Shell . " " . Angle . " 0.2 2.4     Saturation{enter}"
	}
	SendInput % str
	return
}

#If ; End Shell mode code

; Swap Between Ctrl Group and Inventory Numbers
XButton1::
InvMode := !InvMode
RefreshGui()
return

RefreshGui() {
	global
	Gui, Destroy
	Gui +LastFound +ToolWindow +
	Gui, Color, 0e1117
	Gui, Font,Q3 s30 w600
	str := InvMode ? "Inventory" : "CtrlGroup"
	if(ShellMode)
		str := % str . "    S: " . Shell .  "    I: " . IntervalArray[Interval] . "    D: " . Angle
	Gui, Add, Text,R1 H10  C00FFFF, % str
	; WinSet, TransColor, 0e1117 150
	Gui -Caption
	Gui, Show, x2000 y0 NoActivate
	return
}

#If InvMode and not DisableInventory
SetNumLockState, On
2::SendInput {Numpad2}
return
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

/*RefreshGui() {
	global
	Gui, Destroy
	Gui +LastFound +AlwaysOnTop +ToolWindow +Disabled
	Gui, Color, EEAA99
	Gui, Font,Q3 s15 w600
	str := InvMode ? "Inventory" : "CtrlGroup"
	if(ShellMode)
		str := % str . "    S: " . Shell .  "    I: " . IntervalArray[Interval] . "    D: " . Angle
	Gui, Add, Text,R1 H10  C00FFFF, % str
	; WinSet, TransColor, EEAA99 150
	Gui -Caption
	Gui, Show, x1300 y0 NoActivate
	return
}/*
