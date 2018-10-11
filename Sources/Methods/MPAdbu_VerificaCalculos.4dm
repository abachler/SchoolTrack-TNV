//%attributes = {}
  // MÉTODO: MPAdbu_VerificaCalculos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/05/12, 19:35:54
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPAdbu_DetectaItemsSinPromedio()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_BOOLEAN:C305($b_showAlertAfterExecution)
C_LONGINT:C283($i;$l_IdAlumno;$l_IdAsignatura;$l_IdDimension;$l_IdEje;$l_modoCalculoDimensiones;$l_modoCalculoEjes;$l_registrosEvaluados)
C_TEXT:C284($t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_messageIfFailure;$t_messageIfSucces;$t_uuid)

ARRAY LONGINT:C221($al_recNumAsignaturas;0)
ARRAY LONGINT:C221($al_recNumEvaluaciones;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY TEXT:C222($at_Alumnos;0)
ARRAY TEXT:C222($at_Asignatura;0)
ARRAY TEXT:C222($at_Cursos;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)

  // CODIGO PRINCIPAL
READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
CREATE EMPTY SET:C140([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")

  //DETECCION DE PROMEDIOS DE EJES O DIMENSION NO CALCULADOS EN EL PRIMER PERIODO
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosEvaluados)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11;#;-10)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($l_registrosEvaluados>0)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;#;Logro_Aprendizaje;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11;<;0)
	ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;<)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Detectando promedios no calculados en evaluación de aprendizajes.\rPeríodo 1")
	For ($i;1;Size of array:C274($al_recNumEvaluaciones))
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumEvaluaciones))
		GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
		$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
		$l_IdDimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
		$l_IdEje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
		$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
		$l_modoCalculoDimensiones:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6)
		$l_modoCalculoEjes:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10)
		Case of 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje) & ($l_modoCalculoDimensiones=Logro_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_IdDimension;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
					If (Not:C34(Is in set:C273("$noCalculados")))
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje) & ($l_modoCalculoEjes=Dimension_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;>;Dimension_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					If (Not:C34(Is in set:C273("$noCalculados")))
						GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
		End case 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 

  //DETECCION DE PROMEDIOS DE EJES O DIMENSION NO CALCULADOS EN EL SEGUNDO PERIODO
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosEvaluados)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23;#;-10)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($l_registrosEvaluados>0)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;#;Logro_Aprendizaje;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23<0)
	ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;<)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Detectando promedios no calculados en evaluación de aprendizajes.\rPeríodo 2")
	For ($i;1;Size of array:C274($al_recNumEvaluaciones))
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumEvaluaciones))
		GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
		$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
		$l_IdDimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
		$l_IdEje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
		$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
		$l_modoCalculoDimensiones:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6)
		$l_modoCalculoEjes:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10)
		Case of 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje) & ($l_modoCalculoDimensiones=Logro_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_IdDimension;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
					If (Not:C34(Is in set:C273("$noCalculados")))
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje) & ($l_modoCalculoEjes=Dimension_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;>;Dimension_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					If (Not:C34(Is in set:C273("$noCalculados")))
						GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
		End case 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 

  //DETECCION DE PROMEDIOS DE EJES O DIMENSION NO CALCULADOS EN EL TERCER PERIODO
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosEvaluados)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35;#;-10)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($l_registrosEvaluados>0)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;#;Logro_Aprendizaje;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35<0)
	ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;<)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Detectando promedios no calculados en evaluación de aprendizajes.\rPeríodo 3")
	For ($i;1;Size of array:C274($al_recNumEvaluaciones))
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumEvaluaciones))
		GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
		$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
		$l_IdDimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
		$l_IdEje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
		$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
		$l_modoCalculoDimensiones:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6)
		$l_modoCalculoEjes:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10)
		Case of 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje) & ($l_modoCalculoDimensiones=Logro_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_IdDimension;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
					If (Not:C34(Is in set:C273("$noCalculados")))
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje) & ($l_modoCalculoEjes=Dimension_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;>;Dimension_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					If (Not:C34(Is in set:C273("$noCalculados")))
						GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
		End case 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 

  //DETECCION DE PROMEDIOS DE EJES O DIMENSION NO CALCULADOS EN EL CUARTO PERIODO
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosEvaluados)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47;#;-10)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($l_registrosEvaluados>0)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;#;Logro_Aprendizaje;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47<0)
	ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;<)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Detectando promedios no calculados en evaluación de aprendizajes.\rPeríodo 4")
	For ($i;1;Size of array:C274($al_recNumEvaluaciones))
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumEvaluaciones))
		GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
		$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
		$l_IdDimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
		$l_IdEje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
		$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
		$l_modoCalculoDimensiones:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6)
		$l_modoCalculoEjes:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10)
		Case of 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje) & ($l_modoCalculoDimensiones>Logro_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_IdDimension;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
					If (Not:C34(Is in set:C273("$noCalculados")))
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje) & ($l_modoCalculoEjes=Dimension_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;>;Dimension_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					If (Not:C34(Is in set:C273("$noCalculados")))
						GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
		End case 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 

  //DETECCION DE PROMEDIOS DE EJES O DIMENSION NO CALCULADOS EN EL QUINTO PERIODO
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosEvaluados)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64;#;-10)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($l_registrosEvaluados>0)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;#;Logro_Aprendizaje;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11<0)
	ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;<)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Detectando promedios no calculados en evaluación de aprendizajes.\rPeríodo 5")
	For ($i;1;Size of array:C274($al_recNumEvaluaciones))
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumEvaluaciones))
		GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
		$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
		$l_IdDimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
		$l_IdEje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
		$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
		$l_modoCalculoDimensiones:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6)
		$l_modoCalculoEjes:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10)
		Case of 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje) & ($l_modoCalculoDimensiones=Logro_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_IdDimension;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
					If (Not:C34(Is in set:C273("$noCalculados")))
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
			: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje) & ($l_modoCalculoEjes=Dimension_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64#-2))
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$l_IdAlumno;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;>;Dimension_Aprendizaje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje;*)
				QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64>0)
				If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
					If (Not:C34(Is in set:C273("$noCalculados")))
						GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_recNumEvaluaciones{$i})
						ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
					End if 
				End if 
		End case 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 

SET_UseSet ("$noCalculados")
If (Records in set:C195("$noCalculados")>0)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>;[Alumnos:2]apellidos_y_nombres:40;>)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203];$aRecNums;[Asignaturas:18]Curso:5;$at_Cursos;[Asignaturas:18]denominacion_interna:16;$at_Asignatura;[Alumnos:2]apellidos_y_nombres:40;$at_Alumnos)
	For ($i;Size of array:C274($aRecNums);2;-1)
		If (($at_Cursos{$i}=$at_Cursos{$i-1}) & ($at_Asignatura{$i}=$at_Asignatura{$i-1}) & ($at_Alumnos{$i}=$at_Alumnos{$i-1}))
			AT_Delete ($i;1;->$at_Cursos;->$at_Asignatura;->$at_Alumnos;->$aRecNums)
		End if 
	End for 
	
	ARRAY TEXT:C222($at_errores;Size of array:C274($aRecNums))
	ARRAY LONGINT:C221($al_estilos;Size of array:C274($aRecNums))
	ARRAY LONGINT:C221($al_Colores;Size of array:C274($aRecNums))
	For ($i;1;Size of array:C274($aRecNums))
		$at_errores{$i}:="Promedios de ejes o dimensiones no calculados."
		$al_Colores{$i}:=Red:K11:4
	End for 
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Curso")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Asignatura")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Alumno")
	
	ARRAY LONGINT:C221($al_estilos;Size of array:C274($at_errores))
	ARRAY LONGINT:C221($al_Colors;Size of array:C274($at_errores))
	
	
	$t_Encabezado:="Detección de Promedios de ejes y dimensiones no calculados"
	$t_descripcion:="Las matrices de evaluación de aprendizaje de las siguientes asignaturas han sido configuradas para que el resultado de Dimensiones o Ejes de Aprendizajes sea "
	$t_descripcion:=$t_descripcion+"calculado sobre la base de los enunciados evaluados de nivel inferior.\r\r"
	$t_descripcion:=$t_descripcion+"Se ha detectado que en las asignaturas listadas a continuación dicho calculo no se ha efectuado."
	$t_descripcion:=$t_descripcion+"Por favor recalcule los promedios de las siguientes asignaturas.\r"
	$t_contenidoTexto:=""
	
	READ ONLY:C145([Asignaturas:18])
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas;"")
	$b_avisoPostEjecucion:=True:C214
	$t_MensajeFalla:="Aún existen promedios no calculados.\r\rEl detalle será mostrado en el centro de notificaciones."
	$t_MensajeExito:="No se detectó ningún promedio no calculado."
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_Cursos;->$at_Asignatura;->$at_Alumnos)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	NTC_Mensaje_DatosExplorador ($t_uuid;"SchoolTrack";Table:C252(->[Asignaturas:18]);->$al_recNumAsignaturas;"AS_RecalcAverages")
	
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_MensajeFalla;$t_MensajeExito)
	$0:=-1
Else 
	$0:=0
End if 

