Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		wref:=WDW_GetWindowID 
		ARRAY TEXT:C222(atSTR_Evaluaciones;17)
		ARRAY POINTER:C280(ap_evaluaciones;17)
		C_POINTER:C301(ptr2Grade)
		C_DATE:C307(vd_fechaEvaluacion;vd_fechaEntrega)
		C_TEXT:C284(vt_Observaciones)
		atSTR_Evaluaciones{1}:="Parcial 1"
		atSTR_Evaluaciones{2}:="Parcial 2"
		atSTR_Evaluaciones{3}:="Parcial 3"
		atSTR_Evaluaciones{4}:="Parcial 4"
		atSTR_Evaluaciones{5}:="Parcial 5"
		atSTR_Evaluaciones{6}:="Parcial 6"
		atSTR_Evaluaciones{7}:="Parcial 7"
		atSTR_Evaluaciones{8}:="Parcial 8"
		atSTR_Evaluaciones{9}:="Parcial 9"
		atSTR_Evaluaciones{10}:="Parcial 10"
		atSTR_Evaluaciones{11}:="Parcial 11"
		atSTR_Evaluaciones{12}:="Parcial 12"
		atSTR_Evaluaciones{12}:="Parcial 12"
		atSTR_Evaluaciones{13}:="-"
		atSTR_Evaluaciones{14}:="Control de período"
		atSTR_Evaluaciones{15}:="Promedio final"
		atSTR_Evaluaciones{16}:="Examen"
		atSTR_Evaluaciones{17}:="Nota final"
		vd_fechaEvaluacion:=Current date:C33(*)
		vd_fechaEntrega:=vd_fechaEvaluacion
		vt_fechaEvaluacion:=String:C10(vd_fechaEvaluacion)
		vt_fechaEntrega:=String:C10(vd_fechaEntrega)
		vt_Observaciones:=""
		$filter:="&9##"+<>tXS_RS_DateSeparator+"##"+<>tXS_RS_DateSeparator+"####"
		OBJECT SET FILTER:C235(*;"fecha@";$filter)
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
End case 
