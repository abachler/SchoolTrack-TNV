If ((USR_checkRights ("M";->[Alumnos_Calificaciones:208])) | (USR_checkRights ("M";->[Asignaturas:18])) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4))
	AS_CalendarClickHandler 
End if 
