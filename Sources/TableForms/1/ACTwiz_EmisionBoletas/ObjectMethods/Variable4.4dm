$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(Self:C308->;1;2));Num:C11(Substring:C12(Self:C308->;3;2));Num:C11(Substring:C12(Self:C308->;5)))
$StringFecha:=String:C10($date;7)
$FechaFecha:=Date:C102(DT_StrDateIsOK ($StringFecha))
If ($FechaFecha=!00-00-00!)
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
Else 
	C_BOOLEAN:C305($b_valida)
	$b_valida:=(ACTfear_OpcionesGenerales ("ValidaFechaEmision";->$Fechafecha)="1")
	If ($b_valida)
		vdACT_FEmisionBol:=$FechaFecha
	Else 
		vdACT_FEmisionBol:=!00-00-00!
	End if 
	
End if 

ACTbol_CargaDiasVencimiento ("ValidaCambioFecha";->vdACT_FEmisionBol)

vtACT_FEmisionBol:=String:C10(vdACT_FEmisionBol;7)
