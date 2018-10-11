If ([ACT_CuentasCorrientes:175]Matriculado:29)
	$Fechafecha:=DT_PopCalendar 
	If ($Fechafecha#!00-00-00!)
		[ACT_CuentasCorrientes:175]Matriculado_el:54:=$Fechafecha
	End if 
Else 
	BEEP:C151
End if 