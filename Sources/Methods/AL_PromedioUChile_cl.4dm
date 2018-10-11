//%attributes = {}
  //AL_PromedioUChile_cl

C_REAL:C285($grade)
$0:=0

$recNum:=Record number:C243([Alumnos:2])
If (([Alumnos:2]nivel_numero:29=12) & (<>vtXS_CountryCode="cl"))
	If ([Alumnos:2]Situacion_final:33="P")
		CREATE EMPTY SET:C140([Alumnos_SintesisAnual:210];"Historicos")
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1*-1;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=[Alumnos:2]nivel_numero:29-3;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
		ADD TO SET:C119([Alumnos_SintesisAnual:210];"Historicos")
		
		
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1*-1;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=[Alumnos:2]nivel_numero:29-2;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
		ADD TO SET:C119([Alumnos_SintesisAnual:210];"Historicos")
		
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1*-1;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=[Alumnos:2]nivel_numero:29-1;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
		ADD TO SET:C119([Alumnos_SintesisAnual:210];"Historicos")
		
		USE SET:C118("Historicos")
		ARRAY LONGINT:C221($hist;0)
		
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$hist)
		
		$sum:=0
		$div:=0
		C_LONGINT:C283($j)
		
		For ($j;1;Size of array:C274($hist))
			GOTO RECORD:C242([Alumnos_SintesisAnual:210];$hist{$j})
			
			EV2_RegistrosDelAlumno (Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4);[Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas_Historico:84]Promediable:6=True:C214;*)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33>0)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$aGrade;[Asignaturas_Historico:84]Promediable:6;$aInAv;[Asignaturas_Historico:84]Incluida_En_Actas:7;$aEnActas;[Asignaturas_Historico:84]Asignatura:2;$aSubsector)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			GOTO RECORD:C242([Alumnos:2];$recNum)
			For ($i;1;Size of array:C274($aGrade))
				$grade:=$aGrade{$i}
				If (($aInAv{$i}) & ($aEnActas{$i}) & ($grade>0))
					$sum:=$sum+$grade
					$div:=$div+Num:C11($grade>0)
				End if 
			End for 
			
		End for 
		
		  //ABC193361 
		  //agrego parametro del curso, ya que si no se lee la config del nivel y se Pierde la especifica alñ Curso.
		ACTAS_LeeConfiguracion ([Alumnos:2]nivel_numero:29;[Alumnos:2]curso:20)
		
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas:18]Incide_en_promedio:27=True:C214;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33>0)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$aGrade;[Asignaturas:18]Asignatura:3;$aSubsector)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		KRL_GotoRecord (->[Alumnos:2];$recNum;True:C214)  //MONO 186875
		For ($k;1;Size of array:C274($aGrade))
			$grade:=$aGrade{$K}
			If ($grade>0)
				$sum:=$sum+$grade
				$div:=$div+Num:C11($grade>0)
			End if 
		End for 
		[Alumnos:2]Chile_PromedioEMedia:73:=Round:C94($sum/$div;2)
		[Alumnos:2]Chile_SumaNotasEMedia:74:=$sum
		[Alumnos:2]Chile_TotalAsignaturasEMedia:75:=$div
		$0:=[Alumnos:2]Chile_PromedioEMedia:73
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
		[Alumnos:2]Chile_PuntajePromedioEM:92:=AL_PuntajeNEM_cl ([Alumnos:2]Chile_PromedioEMedia:73;[Cursos:3]cl_CodigoTipoEnseñanza:21)
	Else 
		[Alumnos:2]Chile_PromedioEMedia:73:=0
		[Alumnos:2]Chile_SumaNotasEMedia:74:=0
		[Alumnos:2]Chile_TotalAsignaturasEMedia:75:=0
		[Alumnos:2]Chile_PuntajePromedioEM:92:=0
	End if 
	SAVE RECORD:C53([Alumnos:2])
End if 
