//%attributes = {}
  // MÉTODO: MPAdbu_DetectaItemsSinPromedio
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


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
CREATE EMPTY SET:C140([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
ARRAY LONGINT:C221($aRecNum;0)
  //QUERY([Alumnos_EvaluacionAprendizajes];[Alumnos_EvaluacionAprendizajes]ID_Asignatura;=;51;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1>0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;>;0;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;#;Logro_Aprendizaje;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11<0)
ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;<)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$aRecNum;"")
For ($i;1;Size of array:C274($aRecNum))
	GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$aRecNum{$i})
	$id_asignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
	$id_Dimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
	$id_eje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
	$id_alumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
	$modoCalculoDimensiones:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6)
	$modoCalculoEjes:=KRL_GetNumericFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10)
	Case of 
		: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje) & ($modoCalculoDimensiones>3))
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$id_asignatura;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$id_alumno;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$id_Dimension;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>0)
			If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
				GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$aRecNum{$i})
				ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
			End if 
		: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje) & ($modoCalculoEjes>1))
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$id_asignatura;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$id_alumno;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;>;Dimension_Aprendizaje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$id_eje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>0)
			If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
				GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$aRecNum{$i})
				ADD TO SET:C119([Alumnos_EvaluacionAprendizajes:203];"$noCalculados")
			End if 
	End case 
End for 

SET_UseSet ("$noCalculados")
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
If (Records in selection:C76([Asignaturas:18])>0)
	CD_Dlog (0;String:C10(Records in selection:C76([Asignaturas:18]))+__ (" asignatura(s) presenta(n) inconsistencia en los cálculos de dimensiones o ejes de aprendizaje.\r\rPor favor verifique la configuración de los mapas y las matrices de evaluación correspondientes y recalcule los promedios."))
Else 
	CD_Dlog (0;__ ("No se detectaron ejes o dimensiones sin promedios calculados."))
End if 

yBWR_currentTable:=Table:C252(18)
CREATE SET:C116(yBWR_CurrentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;18)

USR_RegisterUserEvent (UE_TabSelection;vlBWR_SelectedTableRef)

REDUCE SELECTION:C351(yBWR_currentTable->;0)
BWR_PanelSettings 
BWR_SelectTableData 

XS_SetInterface 
ALP_SetInterface (xALP_Browser)