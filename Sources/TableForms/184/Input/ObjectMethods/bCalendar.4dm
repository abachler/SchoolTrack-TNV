$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	$vb_continuar:=True:C214
	If ($Fechafecha>Current date:C33(*))
		$vb_continuar:=(CD_Dlog (0;"La fecha seleccionada es superior a hoy."+"\r\r"+"¿Desea continuar?";"";"Si";"No")=1)
	End if 
	If ($vb_continuar)
		vdACT_fechaCambioEstado:=$Fechafecha
	End if 
Else 
	vdACT_fechaCambioEstado:=Current date:C33(*)
End if 