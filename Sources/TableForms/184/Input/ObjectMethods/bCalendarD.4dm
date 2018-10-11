$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	$vb_continuar:=True:C214
	If ($Fechafecha>Current date:C33(*))
		$vb_continuar:=(CD_Dlog (0;"La fecha seleccionada es superior a hoy."+"\r\r"+"¿Desea continuar?";"";"Si";"No")=1)
	End if 
	If ($vb_continuar)
		[ACT_Pagares:184]Fecha_Devolucion:14:=$Fechafecha
	End if 
Else 
	[ACT_Pagares:184]Fecha_Devolucion:14:=Current date:C33(*)
End if 