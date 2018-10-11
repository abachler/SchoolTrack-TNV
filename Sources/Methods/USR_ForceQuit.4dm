//%attributes = {}
  //USR_ForceQuit

C_TIME:C306($delayUntil;$elapsedTime)
C_LONGINT:C283($minutes;$1)

$minutes:=$1
$seconds:=$minutes*60
$delayUntil:=Current time:C178(*)+$seconds
$elapsedTime:=$seconds
$minutesString:=String:C10(Num:C11(Substring:C12(String:C10($elapsedTime);4;2)))
$secondsString:=String:C10(Num:C11(Substring:C12(String:C10($elapsedTime);7;2)))
$timeString:=$minutesString+" minutos y "+$secondsString+" segundos."
$pId:=IT_UThermometer (1;0;__ ("El servidor se cerrará en ")+$timeString+__ ("\rPor favor guarde sus cambios y cierre la aplicación lo antes posible.");-1)
Repeat 
	DELAY PROCESS:C323(Current process:C322;5*60)
	$elapsedTime:=$elapsedTime-5
	$minutesString:=String:C10(Num:C11(Substring:C12(String:C10($elapsedTime);4;2)))
	$secondsString:=String:C10(Num:C11(Substring:C12(String:C10($elapsedTime);7;2)))
	$timeString:=$minutesString+" minutos y "+$secondsString+" segundos."
	IT_UThermometer (0;$pId;__ ("El servidor se cerrará en ")+$timeString+__ ("\rPor favor guarde sus cambios y cierre la aplicación lo antes posible."))
Until (Current time:C178(*)>=$delayUntil)
IT_UThermometer (-2;$pId)
  //$pId:=New process("usr_userquit";64000;"cierre de la aplicación")


If (<>tUSR_CurrentUser#"")
	QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=<>lUSR_CurrentUserID)
	If (Records in selection:C76([xShell_Users:47])>0)
		If (Not:C34(KRL_IsRecordLocked (->[xShell_Users:47])))
			[xShell_Users:47]Nb_sesions:8:=[xShell_Users:47]Nb_sesions:8+1
			[xShell_Users:47]SessionDate:5:=Current date:C33(*)
			[xShell_Users:47]SessionTime:6:=Current time:C178(*)
			SAVE RECORD:C53([xShell_Users:47])
			UNLOAD RECORD:C212([xShell_Users:47])
			READ ONLY:C145([xShell_Users:47])
		End if 
	End if 
	LOG_RegisterEvt ("Fin de sesión")
End if 
  //UNREGISTER CLIENT

QUIT 4D:C291
