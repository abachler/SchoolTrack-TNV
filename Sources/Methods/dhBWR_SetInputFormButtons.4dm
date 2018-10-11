//%attributes = {}
  //dhBWR_SetInputFormButtons


Case of 
	: (vsBWR_CurrentModule="MediaTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[BBL_Lectores:72]))
				IT_SetButtonState (([BBL_Lectores:72]ID:1>0) & (USR_checkRights ("M";yBWR_currentTable));->bBWR_Delete;->bBWR_SaveRecord)
		End case 
		
	: (vsBWR_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				_O_DISABLE BUTTON:C193(bBWR_Delete)
				DISABLE MENU ITEM:C150(2;16)
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				_O_DISABLE BUTTON:C193(bBWR_Delete)
				DISABLE MENU ITEM:C150(2;16)
		End case 
	: (vsBWR_CurrentModule="AdmissionTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				_O_DISABLE BUTTON:C193(bBWR_Delete)
				DISABLE MENU ITEM:C150(2;16)
		End case 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Asignaturas:18]))
				Case of 
					: (vlSTR_PaginaFormAsignaturas=3)
						OBJECT SET VISIBLE:C603(bBWR_CloseRecord;True:C214)
						OBJECT SET VISIBLE:C603(bBWR_SaveRecord;False:C215)
						OBJECT SET VISIBLE:C603(bBWR_Cancel;False:C215)
						
					: (vlSTR_PaginaFormAsignaturas=6)
						IT_SetButtonState (USR_checkRights ("M";yBWR_currentTable) | USR_checkRights ("M";->[Alumnos_Calificaciones:208]) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168]));->bBWR_SaveRecord)
					: (vlSTR_PaginaFormAsignaturas=7)
						IT_SetButtonState (USR_checkRights ("M";yBWR_currentTable) | USR_checkRights ("M";->[Alumnos_Calificaciones:208]) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169]));->bBWR_SaveRecord)
					Else 
						IT_SetButtonState (USR_checkRights ("M";yBWR_currentTable) | USR_checkRights ("M";->[Alumnos_Calificaciones:208]) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4);->bBWR_SaveRecord)
				End case 
				IT_SetButtonState ((USR_checkRights ("M";yBWR_currentTable)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4);->b2;->b1;->b4)
				MNU_SetMenuItemState ((USR_checkRights ("M";yBWR_currentTable)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4);1;5)
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Actividades:29]))
				Case of 
					: (vlSTR_PaginaFormActividades=2)
						OBJECT SET VISIBLE:C603(bBWR_CloseRecord;True:C214)
						OBJECT SET VISIBLE:C603(bBWR_SaveRecord;False:C215)
						OBJECT SET VISIBLE:C603(bBWR_Cancel;False:C215)
					Else 
						IT_SetButtonState (USR_checkRights ("M";yBWR_currentTable) | USR_checkRights ("M";->[Actividades:29]) | (<>lUSR_RelatedTableUserID=[Actividades:29]No_Profesor:3);->bBWR_SaveRecord)
				End case 
				IT_SetButtonState ((USR_checkRights ("M";yBWR_currentTable)) | (<>lUSR_RelatedTableUserID=[Actividades:29]No_Profesor:3);->b2;->b1;->b4)
				MNU_SetMenuItemState ((USR_checkRights ("M";yBWR_currentTable)) | (<>lUSR_RelatedTableUserID=[Actividades:29]No_Profesor:3);1;5)
				
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				Case of 
					: (vlSTR_PaginaFormAlumnos=1)
						IT_SetButtonState (USR_checkRights ("M";->[Alumnos:2]);->bBWR_SaveRecord)
						MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos:2]);1;5)
					: (vlSTR_PaginaFormAlumnos=2)
						IT_SetButtonState ((USR_checkRights ("A";->[Alumnos_Conducta:8]) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36));->bBWR_SaveRecord)
						MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_Conducta:8]);1;5;3;7;3;8;3;9;3;10;3;11;3;12;3;13)
					: (vlSTR_PaginaFormAlumnos=3)
						  //nothing    
					: (vlSTR_PaginaFormAlumnos=5)
						IT_SetButtonState (USR_checkRights ("M";->[Alumnos_FichaMedica:13]);->bBWR_SaveRecord)
						MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_FichaMedica:13]);1;5)
					: (vlSTR_PaginaFormAlumnos=6)
						IT_SetButtonState (USR_checkRights ("M";->[Alumnos_Orientacion:15]);->bBWR_SaveRecord)
						MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_Orientacion:15]);1;5)
					: (vlSTR_PaginaFormAlumnos=7)
						IT_SetButtonState (((USR_checkRights ("M";->[Alumnos_EventosPersonales:16])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36));->bBWR_SaveRecord)
						MNU_SetMenuItemState (((USR_checkRights ("M";->[Alumnos_EventosPersonales:16])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36));1;5)
					: (vlSTR_PaginaFormAlumnos=8)
						IT_SetButtonState (USR_checkRights ("M";->[Familia:78]);->bBWR_SaveRecord)
						MNU_SetMenuItemState (USR_checkRights ("M";->[Familia:78]);1;5)
					: (vlSTR_PaginaFormAlumnos=9)
						  //nothing
					: (vlSTR_PaginaFormAlumnos=10)
						IT_SetButtonState (USR_checkRights ("M";->[Alumnos:2]);->bBWR_SaveRecord)
						MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos:2]);1;5)
				End case 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Cursos:3]))
				Case of 
					: (vlSTR_PaginaFormCursos=3)
						IT_SetButtonState ((USR_checkRights ("M";->[Alumnos_EvaluacionValorica:23])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2);->bBWR_SaveRecord)
				End case 
		End case 
End case 