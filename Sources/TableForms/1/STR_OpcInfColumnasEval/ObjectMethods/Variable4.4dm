vd_fechaEntrega:=DT_PopCalendar 
If (DateIsValid (vd_fechaEntrega))
	vt_fechaEntrega:=String:C10(vd_fechaEntrega)
	If (vd_fechaEntrega<vd_fechaEvaluacion)
		BEEP:C151
		vd_fechaEntrega:=Current date:C33(*)
		vt_fechaEntrega:=String:C10(vd_fechaEntrega)
		GOTO OBJECT:C206(vt_fechaEntrega)
	End if 
Else 
	vd_fechaEntrega:=Current date:C33(*)
	vt_fechaEntrega:=String:C10(vd_fechaEntrega)
End if 