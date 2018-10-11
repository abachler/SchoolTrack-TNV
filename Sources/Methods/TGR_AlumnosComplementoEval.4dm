//%attributes = {}
  // MÉTODO: TGR_AlumnosComplementoEval
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/03/12, 17:20:54
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // TGR_AlumnosComplementoEval()
  // ----------------------------------------------------
C_LONGINT:C283($l_modoRegistroAsistencia;$l_recNumSintesisAnual)
C_TEXT:C284($t_llaveSintesisAnual)




  // CODIGO PRINCIPAL
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_ComplementoEvaluacion:209]ID:90:=SQ_SeqNumber (->[Alumnos_ComplementoEvaluacion:209]ID:90)
			If (([Alumnos_ComplementoEvaluacion:209]Año:3<<>gYear) | ([Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48#0))
				[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=-Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5)
			End if 
			[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			[Alumnos_ComplementoEvaluacion:209]LLave_Asignatura:56:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))
			[Alumnos_ComplementoEvaluacion:209]LLave_Alumno:55:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			
			If ([Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48#0)
				[Alumnos_ComplementoEvaluacion:209]Llave_RegistroHistorico:87:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48))+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			End if 
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95:=-10
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96:=-10
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97:=-10
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98:=""
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99:=""
			
			[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Literal:62:=""
			[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Literal:63:=""
			[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Literal:64:=""
			[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Literal:65:=""
			[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Literal:66:=""
			
			[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Simbolo:77:=""
			[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Simbolo:78:=""
			[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Simbolo:79:=""
			[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Simbolo:80:=""
			[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Simbolo:81:=""
			
			[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Nota:67:=-10
			[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Nota:68:=-10
			[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Nota:69:=-10
			[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Nota:70:=-10
			[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Nota:71:=-10
			
			[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Puntos:72:=-10
			[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Puntos:73:=-10
			[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Puntos:74:=-10
			[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Puntos:75:=-10
			[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Puntos:76:=-10
			
			[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Real:57:=-10
			[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Real:58:=-10
			[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Real:59:=-10
			[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Real:60:=-10
			[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Real:61:=-10
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If (([Alumnos_ComplementoEvaluacion:209]Año:3<<>gYear) | ([Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48#0))
				[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=-Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5)
				[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=-Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
			End if 
			
			[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			[Alumnos_ComplementoEvaluacion:209]LLave_Asignatura:56:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))
			[Alumnos_ComplementoEvaluacion:209]LLave_Alumno:55:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			
			If ([Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48#0)
				[Alumnos_ComplementoEvaluacion:209]Llave_RegistroHistorico:87:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48))+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			End if 
			
			If ([Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
				RELATE ONE:C42([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5)
				  //$numeroNivel:=KRL_GetNumericFieldData (->[Asignaturas]Numero;->[Alumnos_SintesisAnual]ID_Alumno;->[Asignaturas]Numero_del_Nivel)
				$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)
				If ($l_modoRegistroAsistencia=4)
					[Alumnos_ComplementoEvaluacion:209]TotalInasistencias:10:=[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18+[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23+[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28+[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33+[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38
					
					$t_llaveSintesisAnual:=KRL_MakeStringAccesKey (->[Alumnos_ComplementoEvaluacion:209]ID_Institucion:2;->[Alumnos_ComplementoEvaluacion:209]Año:3;->[Asignaturas:18]Numero_del_Nivel:6;->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
					
					If ([Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18#Old:C35([Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18))
						$l_recNumSintesisAnual:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;True:C214)
						If (OK=1)
							[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98-Old:C35([Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18)+[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18
						End if 
					End if 
					
					If ([Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23#Old:C35([Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23))
						$l_recNumSintesisAnual:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;True:C214)
						If (OK=1)
							[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127-Old:C35([Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23)+[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23
						End if 
					End if 
					
					If ([Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28#Old:C35([Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28))
						$l_recNumSintesisAnual:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;True:C214)
						If (OK=1)
							[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156-Old:C35([Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28)+[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28
						End if 
					End if 
					
					If ([Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33#Old:C35([Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33))
						$l_recNumSintesisAnual:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;True:C214)
						If (OK=1)
							[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185-Old:C35([Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33)+[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33
						End if 
					End if 
					
					If ([Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38#Old:C35([Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38))
						$l_recNumSintesisAnual:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;True:C214)
						If (OK=1)
							[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214-Old:C35([Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38)+[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38
						End if 
					End if 
					
					SAVE RECORD:C53([Alumnos_SintesisAnual:210])
					UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
					
				End if 
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	SN3_MarcarRegistros (SN3_DTi_Conducta;SN3_SDTx_InasistHoraAcumulado)
	SN3_MarcarRegistros (SN3_DTi_Observaciones;SN3_SDTx_Asignatura)
End if 