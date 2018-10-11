If (Self:C308->>0)
	dDate1:=adSTR_Periodos_Desde{Self:C308->}
	dDate2:=adSTR_Periodos_Hasta{Self:C308->}
	sMonth:=""
	vt_periodo:=Self:C308->{Self:C308->}
	sWeek:=""
	d2Today:=0
	d1LastSevenDays:=0
Else 
	Self:C308->:=Find in array:C230(aiSTR_Periodos_Numero;viSTR_PeriodoActual_Numero)
End if 