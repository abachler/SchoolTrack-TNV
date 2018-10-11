READ ONLY:C145([Profesores:4])
QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
$line:=AL_GetLine (xALP_EventosCurso)
If ($line>0)
	If (((USR_checkRights ("D";->[Cursos_Eventos:128])) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)) | ([Cursos_Eventos:128]ProfesorJefe_Nombre:8=[Profesores:4]Apellidos_y_nombres:28))
		$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente borrar este registro?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			LOG_RegisterEvt ("Eliminación de evento para el curso "+[Cursos:3]Curso:1+". Fecha de evento eliminado: "+String:C10([Cursos_Eventos:128]Fecha_Observación:2))
			READ WRITE:C146([Cursos_Eventos:128])
			  //$añoAYears:=Year of([Cursos_Eventos]Fecha_Observación) para calendario B y colegios con config raras infocap
			
			DELETE RECORD:C58([Cursos_Eventos:128])
			SAVE RECORD:C53([Cursos_Eventos:128])
			  //CANCEL
			CU_LoadEventosCurso (vl_Year;[Cursos:3]Numero_del_curso:6;xALP_EventosCurso)
			READ ONLY:C145([Cursos_Eventos:128])
		End if 
	Else 
		USR_ALERT_UserHasNoRights (3)
	End if 
End if 