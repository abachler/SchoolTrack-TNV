//%attributes = {}
  //SR_SeleccionaFecha

vi_TipoInforme:=3
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;__ ("Selección del período de generación"))
DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")
CLOSE WINDOW:C154
If (ok=1)
	$0:=True:C214
	C_DATE:C307(viniDate)
	C_DATE:C307(vendDate)
	Case of 
		: (b1=1)
			viniDate:=Current date:C33(*)
			vendDate:=Current date:C33(*)
		: (b3=1)
			viniDate:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;viAño)
			vendDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vi_selectedMonth;viAño);vi_selectedMonth;viAño)
		: (b5=1)
			viniDate:=DT_GetDateFromDayMonthYear (1;1;viAño2)
			vendDate:=DT_GetDateFromDayMonthYear (31;12;viAño2)
		: (b6=1)
			viniDate:=vd_Fecha1
			vendDate:=vd_Fecha2
	End case 
Else 
	$0:=False:C215
End if 