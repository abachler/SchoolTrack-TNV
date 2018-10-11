//%attributes = {}
  //AL_PromedioUChileEgresados_cl

C_REAL:C285($grade)
$0:=0

$recNum:=Record number:C243([Alumnos:2])
If (([Alumnos:2]nivel_numero:29=Nivel_Egresados) & (<>vtXS_CountryCode="cl"))
	
	CREATE EMPTY SET:C140([Alumnos_SintesisAnual:210];"Historicos")
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1*-1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=12;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
	ADD TO SET:C119([Alumnos_SintesisAnual:210];"Historicos")
	
	
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1*-1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=11;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
	ADD TO SET:C119([Alumnos_SintesisAnual:210];"Historicos")
	
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1*-1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=10;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
	ADD TO SET:C119([Alumnos_SintesisAnual:210];"Historicos")
	
	
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1*-1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=9;*)
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
	
	[Alumnos:2]Chile_PromedioEMedia:73:=Trunc:C95($sum/$div;2)
	[Alumnos:2]Chile_SumaNotasEMedia:74:=$sum
	[Alumnos:2]Chile_TotalAsignaturasEMedia:75:=$div
	$0:=[Alumnos:2]Chile_PromedioEMedia:73
	READ ONLY:C145([Alumnos_Historico:25])
	QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Nivel:11=12;*)
	QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1)
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos_Historico:25]Curso:3)
	If (Records in selection:C76([Cursos:3])>0)
		[Alumnos:2]Chile_PuntajePromedioEM:92:=AL_PuntajeNEM_cl ([Alumnos:2]Chile_PromedioEMedia:73;[Cursos:3]cl_CodigoTipoEnseñanza:21)
	End if 
	SAVE RECORD:C53([Alumnos:2])
End if 
