#include <MsgBoxConstants.au3>
#include <Array.au3>

HotKeySet("^!c", "open_chrome")
HotKeySet("^!s", "open_cmd")
HotKeySet("^!q", "close_program")
; HotKeySet("^!t", "ontop.ahk")
HotKeySet("^!1", "workplace_1")
HotKeySet("^!2", "workplace_2")
;HotKeySet("^!3", "workplace_3")
;HotKeySet("^!4", "workplace_4")

Global $current_workplace = "1"
Global $workplace_programs = ""

While 1:
   Sleep(100)
WEnd

Func open_chrome()
   _open_in_workplace($current_workplace, "C:\Program Files (x86)\Google\Chrome\Application\chrome")
EndFunc

Func open_cmd()
   _open_in_workplace($current_workplace, "C:\Windows\System32\cmd")
EndFunc

Func close_program()
   $handle = WinGetHandle("")
   WinClose($handle)
   ; remove from open processes
EndFunc

Func workplace_1()
   $current_workplace = "1"
   _open_workplace($current_workplace)
EndFunc

Func workplace_2()
   $current_workplace = "2"
   _open_workplace($current_workplace)
EndFunc

Func _open_workplace($index)
   ;WinMinimizeAll()
   _hide_all()
   ; change to a different workplace
   $processes = StringSplit($workplace_programs, ";")
   $relevant_processes = ""
   $handle = ""
   for $i = 1 to UBound($processes) - 2
	  if $processes[$i] <> "" Then
		 If StringInStr($processes[$i], $current_workplace & "__") Then
			$pid = StringReplace($processes[$i], "__", "")
			$pid = StringTrimLeft($pid, 1)
			if ProcessExists($pid) <> 0 Then
			   $handle = _GetHwndFromPID($pid)
			   WinSetState($handle, "", @SW_SHOW)
			Else
			   $workplace_programs = StringReplace($workplace_programs, $processes[$i] & ";", "")
			EndIf
		 EndIf
	  EndIf
   Next
   if $handle <> "" Then
	  WinActivate($handle)
   EndIf
EndFunc

Func _open_in_workplace($index, $program)
   $pid = Run($program)
   ; add to current workplace list of apps
   if $pid > 0 Then
	  $workplace_programs = $workplace_programs & $index & "__" & $pid & ";"
	  ConsoleWrite($workplace_programs)
   EndIf

EndFunc

Func _hide_all()
   $processes = StringSplit($workplace_programs, ";")
   for $i = 1 to UBound($processes) - 2
	  if $processes[$i] <> "" Then
		 $pid = StringReplace($processes[$i], "__", "")
		 $pid = StringTrimLeft($pid, 1)
		 if ProcessExists($pid) <> 0 Then
			$handle = _GetHwndFromPID($pid)
			WinSetState($handle, "", @SW_HIDE)
		 Else
			$workplace_programs = StringReplace($workplace_programs, $processes[$i] & ";", "")
			ConsoleWrite($workplace_programs)
		 EndIf
	  EndIf
   Next
EndFunc

;Function for getting HWND from PID
Func _GetHwndFromPID($PID)
	$hWnd = 0
	$winlist = WinList()
	Do
		For $i = 1 To $winlist[0][0]
			If $winlist[$i][0] <> "" Then
				$iPID2 = WinGetProcess($winlist[$i][1])
				If $iPID2 = $PID Then
					$hWnd = $winlist[$i][1]
					ExitLoop
				EndIf
			EndIf
		Next
	Until $hWnd <> 0
	Return $hWnd
EndFunc;==>_GetHwndFromPID
