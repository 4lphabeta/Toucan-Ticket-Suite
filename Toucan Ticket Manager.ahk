;		v2.2.4b		by Connor Richards
#SingleInstance Force
#installKeybdHook
#Persistent

Menu, Tray, NoStandard
Menu, Tray, Add, Hotkeys, , P0
Menu, Tray, Add
Menu, Tray, Add, New Ticket, #space
Menu, Tray, Add, New Callback, ^#space
Menu, Tray, Add
Menu, Tray, Add, Default User Name, AltDefUser, P1
Menu, Tray, Add, Default Callback Name, AltDefCallback, P2
Menu, Tray, Add, Open File Location, OpenFileLocation, P3
Menu, Tray, Add, Open Startup Shortcut, OpenShortcut, P4
Menu, Tray, Add
Menu, Tray, Add, Restart, , P3
Menu, Tray, Add, Exit, QuitNow

DirSource = C:\Toucan\Toucan.ico
I_Icon = % DirSource
ICON [I_Icon]
Menu, Tray, Icon , %I_Icon%
TrayTip, Toucan Ticket Manager, Started, 1
Sleep 1500   ; Let it display for 1.5 seconds.
HideTrayTip()

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

StringTrimRight, OutputVar, A_Temp, 11
VarAppData1 = % OutputVar "\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
VarAppData := RegExReplace(VarAppData1,"(\n|\r)")

FileRead, DefUser, C:\Toucan\UserDef.txt
Sleep 20
FileRead, DefCallback, C:\Toucan\CallbackDef.txt
DetectHiddenWindows, On
SetTitleMatchMode, 2
SetKeyDelay, 20, 10
Return

Hotkeys:
	Gui, Add, ListView, r6 w200, Function|Shortcut
	
	LV_Add(Vis, "New Ticket", "Win + Space")
	LV_Add(Vis, "Callback", "Ctrl + Win + Space")
	LV_Add(Vis, "Close Ticket", "Ctrl + Alt + Space")
	LV_Add(Vis, "Restart Script", "Ctrl + Alt + C")
	LV_ModifyCol()  ; Auto-size each column to fit its contents.

	Gui, Show
Return

AltDefUser:
	InputBox, DefUser, Change Default User, Please enter your first name:, ,230 ,125 , , , , , 
	If ErrorLevel = 0
	{
		;Continue
		;OK was selected
	}
	Else
	{
		Return
		;Cancel was selected
	}
	FileDelete, C:\Toucan\UserDef.txt
	FileAppend, % DefUser, C:\Toucan\UserDef.txt,
	FileRead, DefUser, C:\Toucan\UserDef.txt
Return

AltDefCallback:
	InputBox, DefCallback , Change Default Callback Name, Please enter the first name of who you would like callbacks to default to:, ,250 ,150 , , , , , 
	If ErrorLevel = 0
	{
		;Continue
		;OK was selected
	}
	Else
	{
		Return
		;Cancel was selected
	}
	FileDelete, C:\Toucan\CallbackDef.txt
	FileAppend, % DefCallback, C:\Toucan\CallbackDef.txt,
	FileRead, DefCallback, C:\Toucan\CallbackDef.txt
Return

OpenFileLocation:
	Run, explore C:\Toucan
Return

OpenShortcut:
	Run, explore %VarAppData%
Return

Restart:
	Reload
Return

QuitNow:
	ExitApp
Return

$^space::		;Ctrl + Space
	WinActivate, ahk_exe spotify.exe
	WinWaitActive, ahk_exe spotify.exe
	WinRestore
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)		;Needs this twice
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
	ControlSend, , {SPACE}, ahk_id %spotifyHwnd%
	return

#space::		;Win + Space
	RunWait, http://support.affinitus.co.uk/WorkOrder.do?woMode=newWO,,
	Leave = 
	;WaitForPageLoad(245, 1038, "0xf5f5f5")
	Sleep 3000
	WinGet, WindowID, ID, ManageEngine ServiceDesk Plus - Google Chrome
	ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome
	ControlFocus,,ahk_id %controlID%
	Sleep 50
	ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 3}, Google Chrome
	Sleep 200
	ControlSend, Chrome_RenderWidgetHostHWND1, %DefUser%, Google Chrome		;Change to your name via Default User Name
	Sleep 200
	ControlSend, Chrome_RenderWidgetHostHWND1, {Enter}, Google Chrome
	Sleep 100
	ControlSend, Chrome_RenderWidgetHostHWND1, +{TAB 3}, Google Chrome
	Sleep 100
	return

^#space::		;Ctrl + Win + Space
	RunWait, http://support.affinitus.co.uk/WorkOrder.do?woMode=newWO,,
	Leave =
	;WaitForPageLoad(245, 1038, "0xf5f5f5")
	Sleep 3000
	WinGet, WindowID, ID, ManageEngine ServiceDesk Plus - Google Chrome
	ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome
	ControlFocus,,ahk_id %controlID%
	Sleep 500
	ControlSend, Chrome_RenderWidgetHostHWND1, Call Centre, Google Chrome
	Sleep 500
	ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 3}, Google Chrome
	Sleep 600
	ControlSend, Chrome_RenderWidgetHostHWND1, %DefCallback%, Google Chrome		;Change via Default Callback Name
	Sleep 200
	ControlSend, Chrome_RenderWidgetHostHWND1, +{TAB}, Google Chrome
	Sleep 100
	ControlSend, Chrome_RenderWidgetHostHWND1, Telephone, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 2}, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, Telephone, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 5}, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, Call Back - NAME`, COMPANY, Google Chrome
	Sleep 200
	ControlSend, Chrome_RenderWidgetHostHWND1, {TAB}, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, Telephone, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, {TAB}, Google Chrome
	Sleep 100
	ControlSend, Chrome_RenderWidgetHostHWND1, :`), Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, +{TAB 2}, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, {HOME}, Google Chrome
	Sleep 100
	ControlSend, Chrome_RenderWidgetHostHWND1, {RIGHT 12}, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, {SHIFT down}{END}{SHIFT up}, Google Chrome
	return

$^!space::		;Ctrl + Alt + Space
	OldClip = %Clipboard%
	Clipboard =
	WinGet, WindowID, ID, ManageEngine ServiceDesk Plus - Google Chrome
	ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome
	ControlFocus,,ahk_id %controlID%
	Send {LControl}{Home}
	SendInput {PgUp 5}
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, +{TAB}, Google Chrome
	Sleep 150
	ControlSend, Chrome_RenderWidgetHostHWND1, {Alt down}d{Alt up}, Google Chrome
	Sleep 50
	Send ^c
	ClipWait
	; MsgBox Control-C copied the following contents to the clipboard:`n`n%clipboard%
	Sleep 100
	If Clipboard = http://support.affinitus.co.uk/WorkOrder.do?woMode=newWO
	{
		;In new ticket screen
		Sleep 100
		ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 2}, Google Chrome
		Sleep 150
		Send Closed
		Sleep 250
		Sleep 600
		SendInput {Enter}
		BlockInput MouseMove
		DllCall("SetCursorPos", int, 948, int, 442)
		Click
		BlockInput MouseMoveOff
		Sleep 200
		ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 2}, Google Chrome
		Sleep 150
		ControlSend, Chrome_RenderWidgetHostHWND1, Success, Google Chrome
		Sleep 150
		ControlSend, Chrome_RenderWidgetHostHWND1, +{TAB}, Google Chrome
	}	
	Else
	{	
		;In existing ticket screen
		Sleep 400
		BlockInput MouseMove
		DllCall("SetCursorPos", int, 1705, int, 230)
		Click
		BlockInput MouseMoveOff
		Sleep 200
		Send Closed
		Sleep 200
		SendInput {Enter}
		Sleep 2500
		ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 7}, Google Chrome
		Sleep 100
		ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 6}, Google Chrome
		Sleep 100
		ControlSend, Chrome_RenderWidgetHostHWND1, {TAB 6}, Google Chrome
	}
	If OldClip <>
	{
		Clipboard = %OldClip%
		ClipWait
	}
	Sleep 50
	return
	
^!c::		;Ctrl + Alt + C
	Reload
	Sleep 200
	return
	
$#UP::		;Win + Up
		Sleep 50
		Send {W}
		Sleep 10
		Send {e}
		Sleep 10
		Send {l}
		Sleep 10
		Send {c}
		Sleep 10
		Send {o}
		Sleep 10
		Send {m}
		Sleep 10
		Send {e}
		Sleep 10
		Send {@}
		Sleep 10
		Send {2}
		Sleep 10
		Send {0}
		Sleep 10
		Send {2}
		Sleep 10
		Send {0}
		Sleep 10
		Send {!}
		Sleep 50
		;SendInput {Enter}
	return
	
#DOWN::
	MouseGetPos, xpos, ypos 
	;FileAppend, X%xpos% Y%ypos%.`n, test.txt
	msgbox X%xpos%, Y%ypos%
	return
	
WaitForPageLoad(x, y, color)
{
	Loop
	{
		if Leave = y
			break
		PixelGetColor, Initial, 245, 1038, Slow
		Sleep 50
		if Initial = 0x000000
			Loop
			{
				PixelGetColor, Loaded, %x%, %y%, Slow
				Sleep 50
				if Loaded = %color%
				{
					Loaded =
					color = 
					Leave = y
					break
				}
			}
	}
}
	
Return