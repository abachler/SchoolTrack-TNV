Case of 
	: (_O_During:C30)
		Case of 
			: (alProEvt=1)
				$line:=AL_GetLine (Self:C308->)
				GOTO SELECTED RECORD:C245([Cursos_Eventos:128];$line)
				If (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
					IT_SetButtonState ($line>0;->bDeleteLineEvCurso)
				End if 
				If (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
					IT_SetButtonState (False:C215;->bDeleteLineEvCurso)
				End if 
			: (alProEvt=2)
				If ((USR_checkRights ("M";->[Cursos_Eventos:128])) | (USR_checkRights ("L";->[Cursos_Eventos:128])) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
					$line:=AL_GetLine (Self:C308->)
					GOTO SELECTED RECORD:C245([Cursos_Eventos:128];$line)
					$añoAYears:=Year of:C25([Cursos_Eventos:128]Fecha_Observación:2)
					WDW_OpenFormWindow (->[Cursos_Eventos:128];"Input";-1;5)
					If ([Cursos_Eventos:128]Fecha_Observación:2=!00-00-00!)
						SET WINDOW TITLE:C213(__ ("Nuevo Evento para ")+[Cursos:3]Curso:1)
					Else 
						SET WINDOW TITLE:C213(__ ("Detalle de Evento ")+[Cursos_Eventos:128]Categoría:3+__ (" para ")+[Cursos:3]Curso:1+__ (", año ")+String:C10(Year of:C25([Cursos_Eventos:128]Fecha_Observación:2)))
					End if 
					
					KRL_ModifyRecord (->[Cursos_Eventos:128];"Input")
					CLOSE WINDOW:C154
					CU_LoadEventosCurso ($añoAYears;[Cursos:3]Numero_del_curso:6;xALP_EventosCurso)
				Else 
					BEEP:C151
				End if 
		End case 
End case 