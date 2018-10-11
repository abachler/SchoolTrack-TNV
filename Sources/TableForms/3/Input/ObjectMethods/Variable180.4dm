If ((USR_checkRights ("A";->[Cursos_Eventos:128])) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
	WDW_OpenFormWindow (->[Cursos_Eventos:128];"Input";-1;5)
	FORM SET INPUT:C55([Cursos_Eventos:128];"Input")
	ADD RECORD:C56([Cursos_Eventos:128];*)
	CLOSE WINDOW:C154
	CU_LoadEventosCurso (<>gYear;[Cursos:3]Numero_del_curso:6;xALP_EventosCurso)
Else 
	USR_ALERT_UserHasNoRights (2)
End if 