If (Self:C308-><0)
	Self:C308->:=1
End if 

If (Self:C308->>31)
	BEEP:C151
	Self:C308->:=1
End if 

If (Self:C308->>28)
	BEEP:C151
	CD_Dlog (0;"Esta configuración no se aplicará para los meses que tengan menos de "+String:C10(Self:C308->)+" días.")
End if 

LOG_RegisterEvt ("Cambio en día de aplicación de asignación automática de matrices de cargo. Día configurado: "+String:C10(Self:C308->)+".")