//%attributes = {}
  //EVT_InterrumpeImpresion

$OptionKeyDown:=modifiers ?? Option key bit:K16:8
$CMDKeyDown:=modifiers ?? Command key bit:K16:2
$shiftKeyDown:=modifiers ?? Shift key bit:K16:4
$capsLockDown:=modifiers ?? Caps lock key bit:K16:6
If (SYS_IsMacintosh )
	$MacCTRLKeyDown:=modifiers ?? Control key bit:K16:10
End if 

If (keycode#0)
	Case of 
		: ((keycode=Character code:C91(".")) & ($CMDKeyDown))
			<>stopExec:=True:C214
			TRACE:C157
		: (keyCode=27)
			<>stopExec:=True:C214
			FILTER EVENT:C321
			TRACE:C157
			
	End case 
End if 
