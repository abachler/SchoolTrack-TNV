$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(Self:C308->;1;2));Num:C11(Substring:C12(Self:C308->;3;2));Num:C11(Substring:C12(Self:C308->;5)))
$StringFecha:=String:C10($date)
$FechaFecha:=Date:C102(DT_StrDateIsOK ($StringFecha))
If ($FechaFecha=!00-00-00!)
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
Else 
	Self:C308->:=$StringFecha
	vdDate:=$FechaFecha
End if 
If (vdDate<Current date:C33(*))
	CD_Dlog (0;__ ("No puede programar la emisión para una fecha anterior a la actual."))
	vdDate:=Current date:C33(*)
	vt_Fecha:=String:C10(vdDate;7)
	GOTO OBJECT:C206(vt_Fecha)
End if 