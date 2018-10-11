  //[Cursos_Eventos].Input.BIECursoC

If (vl_Year#<>gYear)
	PERIODOS_LeeDatosHistoricos ([Cursos:3]Nivel_Numero:7;vl_Year)
Else 
	PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
End if 
If (DateIsValid ([Cursos_Eventos:128]Fecha_Observación:2;0))
	If (([Cursos_Eventos:128]Categoría:3#"") & ([Cursos_Eventos:128]Observacion:5#""))
		AL_UpdateArrays (xALP_EventosCurso;0)
		READ WRITE:C146([Cursos_Eventos:128])
		If (Is new record:C668([Cursos_Eventos:128]))
			If ((USR_checkRights ("A";->[Cursos_Eventos:128])) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
				LOG_RegisterEvt ("Creación de evento para el curso "+[Cursos:3]Curso:1+", año "+String:C10(Year of:C25([Cursos_Eventos:128]Fecha_Observación:2))+".")
				SAVE RECORD:C53([Cursos_Eventos:128])
			Else 
				USR_ALERT_UserHasNoRights (2)
			End if 
		Else 
			If (KRL_RegistroFueModificado (->[Cursos_Eventos:128]))
				If (((USR_checkRights ("M";->[Cursos_Eventos:128])) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
					LOG_RegisterEvt ("Modificación de evento para el curso "+[Cursos:3]Curso:1+", año "+String:C10(Year of:C25([Cursos_Eventos:128]Fecha_Observación:2))+".")
					SAVE RECORD:C53([Cursos_Eventos:128])
				Else 
					USR_ALERT_UserHasNoRights (1)
				End if 
			End if 
		End if 
		KRL_ReloadAsReadOnly (->[Cursos_Eventos:128])
		CANCEL:C270
	Else 
		CD_Dlog (0;__ ("Debe ingresar la categoría y la observación"))
	End if 
	
Else 
	CD_Dlog (0;"La fecha del evento no corresponde a ningún día de clases.")
End if 