ARRAY LONGINT:C221($aLines;0)
$page:=Selected list items:C379(hlTab_STR_alumnosHistorico)
Case of 
	: ($page=1)
		Case of 
			: (alProEvt=1)
				$err:=AL_GetSelect (xALP_HNotasECursos;$aLines)
				If (Size of array:C274($aLines)=1)
					$line:=$aLines{1}
				Else 
					$line:=0
				End if 
				
			: ((alProEvt=2))
				  //CD_Dlog (0;"La edición de registros históricos está temporalmente inhabilitada.")
				  //If (False)
				$line:=AL_GetLine (xALP_HNotasECursos)
				If (vb_HistoricoEditable)
					If ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0) | (USR_GetMethodAcces ("EditarHistórico";0)))
						READ WRITE:C146([Alumnos_Calificaciones:208])
						READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
						READ WRITE:C146([Asignaturas_Historico:84])
					Else 
						READ ONLY:C145([Alumnos_Calificaciones:208])
						READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
						READ ONLY:C145([Asignaturas_Historico:84])
					End if 
					KRL_GotoRecord (->[Alumnos_Calificaciones:208];aNtaRecNum{$line};vb_HistoricoEditable)
					KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;vb_HistoricoEditable)
					KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;vb_HistoricoEditable)
					
					  //If ([Asignaturas_Historico]ID_AsignaturaOriginal#0)
					If ((Records in selection:C76([Alumnos_ComplementoEvaluacion:209])=0) | ([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5=0))  //20190609 ASM Ticket 209081 
						  //20130910 ASM para cargar los complementos de evaluación cuando la asignatura historico no es original
						QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48=[Asignaturas_Historico:84]ID_RegistroHistorico:1;*)
						QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6=[Alumnos_Calificaciones:208]ID_Alumno:6)
						vb_HistoricoEditable2:=Not:C34(vb_HistoricoEditable)
						KRL_ResetPreviousRWMode (->[Alumnos_ComplementoEvaluacion:209];vb_HistoricoEditable2)
						
					End if 
				Else 
					READ ONLY:C145([Alumnos_Calificaciones:208])
					READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
					READ ONLY:C145([Asignaturas_Historico:84])
					KRL_GotoRecord (->[Alumnos_Calificaciones:208];aNtaRecNum{$line};False:C215)
					KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;False:C215)
					If ([Asignaturas_Historico:84]ID_AsignaturaOriginal:30#0)
						KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;vb_HistoricoEditable)
					Else 
						  //20130910 ASM para cargar los complementos de evaluación cuando la asignatura historico no es original
						QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48=[Asignaturas_Historico:84]ID_RegistroHistorico:1;*)
						QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6=[Alumnos_Calificaciones:208]ID_Alumno:6)
						KRL_ResetPreviousRWMode (->[Alumnos_ComplementoEvaluacion:209];True:C214)
					End if 
				End if 
				aNtaRecNum:=$line
				  //QUERY([Asignaturas_Histórico];[Asignaturas_Histórico]ID_RegistroHistorico=aHId{$line})
				WDW_OpenFormWindow (->[Asignaturas_Historico:84];"Infos";-1;8;__ ("Info: ")+[Asignaturas_Historico:84]Asignatura:2;"wdwClose")
				KRL_ModifyRecord (->[Asignaturas_Historico:84];"Infos")
				CLOSE WINDOW:C154
				aNtaAsignatura{$line}:=[Asignaturas_Historico:84]Asignatura:2
				  //AL_UpdateArrays (xALP_HNotasECursos;-1)
				If (OK=1)
					READ WRITE:C146([Alumnos_Calificaciones:208])
					LOAD RECORD:C52([Alumnos_Calificaciones:208])
					ALh_RecalcHistoric 
					SAVE RECORD:C53([Alumnos_Calificaciones:208])
					KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones:208])
				End if 
				KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones:208])
				
				AL_PromedioUChile_cl 
				
				al_LoadHNotas 
				  //End if 
		End case 
		
	: ($page=2)
		
	: ($page=3)
		
		
	: ($page=4)
		Case of 
			: (alProEvt=1)
				$line:=AL_GetLine (xALP_HNotasECursos)
				GOTO SELECTED RECORD:C245([Cursos_Eventos:128];$line)
			: (alProEvt=2)
				$line:=AL_GetLine (xALP_HNotasECursos)
				GOTO SELECTED RECORD:C245([Cursos_Eventos:128];$line)
				$añoAYears:=Year of:C25([Cursos_Eventos:128]Fecha_Observación:2)
				WDW_OpenFormWindow (->[Cursos_Eventos:128];"Input";-1;5)
				SET WINDOW TITLE:C213(__ ("Detalle de Evento para ")+[Alumnos_Historico:25]Curso:3+__ (", año ")+String:C10(Year of:C25([Cursos_Eventos:128]Fecha_Observación:2)))
				KRL_ModifyRecord (->[Cursos_Eventos:128];"Input")
				CLOSE WINDOW:C154
				READ ONLY:C145([Cursos:3])
				CREATE SET:C116([Cursos:3];"CursoActual")
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos_Historico:25]Curso:3)
				CU_LoadEventosCurso (vl_Year_Historico;[Cursos:3]Numero_del_curso:6;xALP_HNotasECursos)
				USE SET:C118("CursoActual")
				CLEAR SET:C117("CursoActual")
		End case 
End case 
REDRAW WINDOW:C456