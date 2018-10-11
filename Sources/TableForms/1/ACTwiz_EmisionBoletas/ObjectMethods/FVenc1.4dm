$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(Self:C308->;1;2));Num:C11(Substring:C12(Self:C308->;3;2));Num:C11(Substring:C12(Self:C308->;5)))
$StringFecha:=String:C10($date;7)
$FechaFecha:=Date:C102(DT_StrDateIsOK ($StringFecha))
If ($FechaFecha=!00-00-00!)
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
Else 
	vdACT_FVencimientoBol:=$FechaFecha
End if 

ACTbol_CargaDiasVencimiento ("ValidaCambioFecha";->vdACT_FVencimientoBol)

vtACT_FVencimientoBol:=String:C10(vdACT_FVencimientoBol;7)