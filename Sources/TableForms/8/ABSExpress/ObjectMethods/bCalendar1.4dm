$Fechafecha:=DT_PopCalendar 
If ($Fechafecha<=Current date:C33(*))
	$r:=DateIsValid ($Fechafecha)
	If (Not:C34($r))
		dDate:=!00-00-00!
		GOTO OBJECT:C206(dDate)
	Else 
		dDate:=$Fechafecha
	End if 
Else 
	Self:C308->:=!00-00-00!
	dTo:=dFrom
	$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una inasistencia anticipadamente."))
End if 

If ((<>aCursos{0}="") | (dDate=!00-00-00!))
	OBJECT SET ENTERABLE:C238(sName;False:C215)
Else 
	OBJECT SET ENTERABLE:C238(sName;True:C214)
End if 
