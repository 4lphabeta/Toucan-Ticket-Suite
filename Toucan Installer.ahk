splitString(string, delemiter){
   arr := []
   loop, parse, string, %delemiter%
   {
      arr[A_Index] := A_LoopField
   }
   return arr
}

DetectHiddenText, Off
SetTitleMatchMode, 2

WinGetText, out,A
word_array := splitString(out, " ")
path = % word_array[5]

path2 := RegExReplace(path, "(\n|\r)")

IfNotInString, path2, Downloads
{
	StringTrimRight, OutputVar, path, 7
	var1 = % OutputVar
	var2 = \Toucan Ticket Manager\
	DirSource = %var1%%var2%
	Script1 = % DirSource "Toucan Ticket Manager.ahk"
	Script := RegExReplace(Script1,"(\n|\r)")
	Logo1 = % DirSource "Toucan.ico"
	Logo := RegExReplace(Logo1,"(\n|\r)")
	Shortcut1 = % DirSource "Toucan Ticket Manager.lnk"
	Shortcut := RegExReplace(Logo1,"(\n|\r)")

	StringTrimRight, OutputVar, A_Temp, 19
	VarAppData1 = % OutputVar "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
	VarAppData := RegExReplace(VarAppData1,"(\n|\r)") "\Toucan Ticket Manager.lnk"
}
else
{
	StringTrimRight, OutputVar, A_Temp, 19
	var1 = % OutputVar
	var2 = \Downloads\Toucan Ticket Manager\
	DirSource = %var1%%var2%
	Script1 = % DirSource "Toucan Ticket Manager.ahk"
	Script := RegExReplace(Script1,"(\n|\r)")
	Logo1 = % DirSource "Toucan.ico"
	Logo := RegExReplace(Logo1,"(\n|\r)")
	Shortcut1 = % DirSource "Toucan Ticket Manager.lnk"
	Shortcut := RegExReplace(Logo1,"(\n|\r)")
	
	VarAppData1 = % OutputVar "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
	VarAppData := RegExReplace(VarAppData1,"(\n|\r)") "\Toucan Ticket Manager.lnk"
}

if not (FileExist("C:\Toucan")) {
	FileCreateDir, C:\Toucan
}

Sleep 500

FileCopy, % Logo, C:\Toucan, 1
FileCopy, % Script, C:\Toucan, 1
FileCreateShortcut, C:\Toucan\Toucan Ticket Manager.ahk, % VarAppData , C:\Toucan, , , C:\Toucan\Toucan.ico, , , 1

Sleep 100

MsgBox, 4,, Would you like to run the program now? (press Yes or No)
IfMsgBox Yes
    Run, C:\Toucan\Toucan Ticket Manager.ahk

MsgBox Done