$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_Fecha:=$fecha
	VdDate:=$Fechafecha
Else 
	vt_Fecha:=""
	vdDate:=!00-00-00!
End if 
If (vdDate<Current date:C33(*))
	CD_Dlog (0;__ ("No puede programar la emisión para una fecha anterior a la actual."))
	vdDate:=Current date:C33(*)
	vt_Fecha:=String:C10(vdDate;7)
	GOTO OBJECT:C206(vt_Fecha)
End if 