If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
	OK:=0
Else 
	DT_SetCalendar (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
	CAL_FillMonth 
End if 
