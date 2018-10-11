$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(Self:C308->;1;2));Num:C11(Substring:C12(Self:C308->;3;2));Num:C11(Substring:C12(Self:C308->;5)))
$StringFecha:=String:C10($date)
$FechaFecha:=Date:C102(DT_StrDateIsOK ($StringFecha))
If ($FechaFecha=!00-00-00!)
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
Else 
	Self:C308->:=$StringFecha
	vd_fechaEntrega:=$FechaFecha
	If (vd_fechaEntrega<vd_fechaEvaluacion)
		BEEP:C151
		vd_fechaEntrega:=Current date:C33(*)
		vt_fechaEntrega:=String:C10(vd_fechaEntrega)
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 