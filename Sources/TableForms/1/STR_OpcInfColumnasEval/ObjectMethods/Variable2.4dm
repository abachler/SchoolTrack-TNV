vd_fechaEvaluacion:=DT_PopCalendar 
If (DateIsValid (vd_fechaEvaluacion))
	vt_fechaEvaluacion:=String:C10(vd_fechaEvaluacion)
	If (vd_fechaEntrega<vd_fechaEvaluacion)
		BEEP:C151
		vd_fechaEvaluacion:=Current date:C33(*)
		vt_fechaEvaluacion:=String:C10(vd_fechaEvaluacion)
		GOTO OBJECT:C206(vt_fechaEvaluacion)
	End if 
Else 
	vd_fechaEvaluacion:=Current date:C33(*)
	vt_fechaEvaluacion:=String:C10(vd_fechaEvaluacion)
End if 