C_DATE:C307($dFrom)
$dFrom:=dFrom
dFrom:=DT_PopCalendar 
If (dFrom<=Current date:C33(*))
	If (DateIsValid (dFrom))
		dTo:=dFrom
	Else 
		dFrom:=!00-00-00!
		dTo:=dFrom
	End if 
Else 
	dFrom:=$dFrom
	dTo:=$dFrom
	$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una inasistencia anticipadamente."))
End if 