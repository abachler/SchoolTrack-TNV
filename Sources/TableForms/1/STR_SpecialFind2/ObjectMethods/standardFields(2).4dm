$el:=Num:C11(Self:C308->)
If (($el<=Size of array:C274(aPeriodo)) & ($el>0))
	aPeriodo:=$el
Else 
	aPeriodo:=Find in array:C230(aiSTR_Periodos_Numero;viSTR_PeriodoActual_Numero)
End if 
dDate1:=adSTR_Periodos_Desde{aPeriodo}
dDate2:=adSTR_Periodos_Hasta{aPeriodo}
sMonth:=""
vt_periodo:=atSTR_Periodos_Nombre{aPeriodo}
sWeek:=""
d2Today:=0
d1LastSevenDays:=0