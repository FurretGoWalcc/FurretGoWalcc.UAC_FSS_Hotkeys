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
tempInterval := 0

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
if(Radius==1) { ; ...then we should turn on saturation
	Radius=2.4
	SendInput % "{Enter}-r " . Radius  . "{Enter}"
	SendInput % "{Enter}-i 0.2{Enter}"
}
else { ; ...turn off saturation
	Radius=1
	SendInput % "{Enter}-r " . Radius  . "{Enter}"
	SendInput % "{Enter}-i " . Interval  . "{Enter}"
}
return


Enter::
SendInput, {Enter}
DisableHotkeys := true
; MsgBox, "Hotkeys disabled"
Input, InputVar,V * T10,{Enter}{Escape},
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
			if(Shell = 1)
				SendInput % "{Enter}-d " . Angle  . "{Enter}" ; d 0 is more accurate than d c with 1 shell
			Shell := InputVar2+5
		}
	}
	else if (Shell = 1 and InputVar != 1 and InputVar != "s") {
		SendInput % "{Enter}-d " . Angle  . "{Enter}" ; d 0 is more accurate than d c with 1 shell
		Shell := InputVar
	}
	else {
		SendInput % "{Enter}-d " . 0  . "{Enter}"
		Shell := InputVar
	}
	SendInput % "{Enter}-s " . Shell  . "{Enter}"
	
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
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		RefreshGui()
		case "w":
		Angle := 90
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		RefreshGui()
		case "e":
		Angle := 45
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		RefreshGui()
		case "d":
		Angle := 360
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		RefreshGui()
		case "c":
		Angle := 315
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		RefreshGui()
		case "x":
		Angle := 270
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		RefreshGui()
		case "z":
		Angle := 225
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		RefreshGui()
		case "a":
		Angle := 180
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		RefreshGui()
		case "s":
		Angle := "c"
		SendInput % "{Enter}-d " . Angle  . "{Enter}"
		SendInput % "{Enter}-i 0.2{Enter}"
		RefreshGui()
		case "g":
		SendInput g
	}
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
		SendInput % "{Enter}-i " . Interval  . "    2.5{Enter}"
		case 2:
		Interval := 0.3636 ; 2.75
		SendInput % "{Enter}-i " . Interval  . "    2.75{Enter}"
		case 3:
		Interval := 0.3333 ; 3
		SendInput % "{Enter}-i " . Interval  . "    3{Enter}"
		case 4:
		Interval := 0.3077 ; 3.25
		SendInput % "{Enter}-i " . Interval  . "    3.25{Enter}"
		case 5:
		Interval := 0.2857 ; 3.5
		SendInput % "{Enter}-i " . Interval  . "    3.5{Enter}"
		case 6:
		Interval := 0.2667 ; 3.75
		SendInput % "{Enter}-i " . Interval  . "    3.75{Enter}"
		case 7:
		Interval := 0.2500 ; 4
		SendInput % "{Enter}-i " . Interval  . "    4{Enter}"	
	}
	RefreshGui()
}
DisableInventory := false
return


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
