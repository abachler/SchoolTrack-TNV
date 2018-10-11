$Fechafecha:=DT_PopCalendar 

If ($Fechafecha>Current date:C33(*))
	CD_Dlog (0;__ ("El deceso no puede producirse en una fecha posterior a hoy."))
Else 
	If ($Fechafecha#!00-00-00!)
		[Personas:7]Fecha_Deceso:89:=$Fechafecha
	End if 
End if 