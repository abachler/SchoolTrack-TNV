Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283(vl_paginaFormulario)
		If (vl_paginaFormulario=0)
			vl_paginaFormulario:=1
		End if 
		FORM GOTO PAGE:C247(vl_paginaFormulario)
		XS_SetInterface 
		
		ARRAY TEXT:C222(aMeses;0)
		ARRAY TEXT:C222(aMeses2;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		COPY ARRAY:C226(aMeses;aMeses2)
		vs1:=aMeses{1}
		vs2:=aMeses{12}
		aMeses:=Find in array:C230(aMeses;vs1)
		aMeses2:=Find in array:C230(aMeses2;vs2)
		vdACT_AñoAviso:=Year of:C25(Current date:C33(*))
		vdACT_AñoAviso2:=Year of:C25(Current date:C33(*))
		
		C_TEXT:C284(vt_CursoSeleccionado)
		C_DATE:C307(vd_Fecha1;vd_Fecha2)
		C_TEXT:C284(vt_Fecha1;vt_Fecha2)
		vd_Fecha1:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
		vd_Fecha2:=DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*)))
		vt_Fecha1:=String:C10(vd_Fecha1)
		vt_Fecha2:=String:C10(vd_Fecha2)
		
		vt_CursoSeleccionado:=""
		cs_Imprimir:=1
		cs_Exportar:=0
		vl_dctoPorMes:=0
		IT_SetButtonState (False:C215;->bOK)
		<>aCursos:=0
	: (Form event:C388=On Clicked:K2:4)
		IT_SetButtonState ((((cs_Imprimir=1) | (cs_Exportar=1)) & (vt_CursoSeleccionado#""));->bOK)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 