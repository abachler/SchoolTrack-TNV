//%attributes = {}
  //EVT_OnEventHandler

C_BOOLEAN:C305(<>vb_MsgON)
C_TEXT:C284(<>vtXS_CountryCode;$string)
C_LONGINT:C283(<>vl_Langage)
C_BOOLEAN:C305(<>vb_AutoSpellCheck;<>vb_SpellCheckTextFieldOnly)


$OptionKeyDown:=modifiers ?? Option key bit:K16:8
$CMDKeyDown:=modifiers ?? Command key bit:K16:2
$shiftKeyDown:=modifiers ?? Shift key bit:K16:4
$capsLockDown:=modifiers ?? Caps lock key bit:K16:6
$mouseDown:=(mouseDown=1)
If (SYS_IsMacintosh )
	$MacCTRLKeyDown:=modifiers ?? Control key bit:K16:10
End if 


Case of 
	: (((keycode=Character code:C91(".")) | (keycode=Character code:C91(":"))) & ($shiftKeyDown & $CMDKeyDown) & (<>vtXS_CountryCode#""))
		  //corregir ortografía
		<>vb_SpellCheckNow:=True:C214
		$process:=Frontmost process:C327(*)
		POST OUTSIDE CALL:C329($process)
		
		
		  //: (((keycode=Character code(",")) | (keycode=Character code(";"))) & ($shiftKeyDown & $CMDKeyDown) & (<>vtXS_CountryCode#""))
		  //  //$p:=New process("SPELL_SpellCheckPreferences";pila_256;"SpellCheck Preferences")
		
		
	: (keyCode=27)
		<>stopExec:=True:C214
		  //FILTER EVENT
		
		
	: ((((keycode=Character code:C91("d")) | (keycode=Character code:C91("D"))) | ($mouseDown)) & ($shiftKeyDown & $CMDKeyDown))
		  //activación desactivación del log de debug
		$msgOn:=<>vb_MsgON
		<>vb_MsgON:=True:C214
		
		
		$debugMode:=Get database parameter:C643(Debug log recording:K37:34;$string)
		If ($debugMode=0)
			$choice:=CD_Dlog (0;__ ("¿Desea activar el log de depuración?");"";__ ("Modo normal");__ ("Modo detallado");__ ("No activar"))
			If ($choice<3)
				SET DATABASE PARAMETER:C642(Debug log recording:K37:34;$choice)
			End if 
		Else 
			$choice:=CD_Dlog (0;__ ("El log de depuración está activado.\r¿Desea desactivarlo?");"";__ ("Desactivar");__ ("Mantener activo"))
			If ($choice=1)
				SET DATABASE PARAMETER:C642(Debug log recording:K37:34;0)
			End if 
		End if 
		
		<>vb_MsgON:=$msgOn
		
		
		
End case 
