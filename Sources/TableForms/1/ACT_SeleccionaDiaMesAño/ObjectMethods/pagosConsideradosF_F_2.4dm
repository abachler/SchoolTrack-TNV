vd_fechaCorte:=DT_PopCalendar 
If (vd_fechaCorte=!00-00-00!)
	BEEP:C151
	vd_fechaCorte:=Current date:C33(*)
End if 