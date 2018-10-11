//%attributes = {}
  // EVS_ActualizaIndicadorEsfuerzo()
  //
  //
  // creado por: Alberto Bachler Klein: 15-07-16, 12:21:30
  // -----------------------------------------------------------
C_LONGINT:C283($l_progreso)
C_TEXT:C284($t_indicadorAntesEdicion;$t_indicadorDespuesEdicion)

ARRAY TEXT:C222($at_indicadorEsfuerzo;0)

$t_indicadorAntesEdicion:=$1
$t_indicadorDespuesEdicion:=$2

If ($t_indicadorAntesEdicion#"")
	READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
	KRL_RelateSelection (->[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16=$t_indicadorAntesEdicion;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21=$t_indicadorAntesEdicion;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26=$t_indicadorAntesEdicion;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31=$t_indicadorAntesEdicion;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36=$t_indicadorAntesEdicion)
	CREATE SET:C116([Alumnos_ComplementoEvaluacion:209];"SelActual")
	If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
		$l_progreso:=IT_UThermometer (1;0;__ ("Actualizando evaluaciones..."))
		CREATE SET:C116([Alumnos_ComplementoEvaluacion:209];"SelActual")
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16=$t_indicadorAntesEdicion)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			AT_RedimArrays (Records in selection:C76([Alumnos_ComplementoEvaluacion:209]);->$at_indicadorEsfuerzo)
			AT_Populate (->$at_indicadorEsfuerzo;->$t_indicadorDespuesEdicion)
			KRL_Array2Selection (->$at_indicadorEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16)
		End if 
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21=$t_indicadorAntesEdicion)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			AT_RedimArrays (Records in selection:C76([Alumnos_ComplementoEvaluacion:209]);->$at_indicadorEsfuerzo)
			AT_Populate (->$at_indicadorEsfuerzo;->$t_indicadorDespuesEdicion)
			KRL_Array2Selection (->$at_indicadorEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21)
			AT_Initialize (->$at_indicadorEsfuerzo)
		End if 
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26=$t_indicadorAntesEdicion)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			AT_RedimArrays (Records in selection:C76([Alumnos_ComplementoEvaluacion:209]);->$at_indicadorEsfuerzo)
			AT_Populate (->$at_indicadorEsfuerzo;->$t_indicadorDespuesEdicion)
			KRL_Array2Selection (->$at_indicadorEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26)
			AT_Initialize (->$at_indicadorEsfuerzo)
		End if 
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31=$t_indicadorAntesEdicion)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			AT_RedimArrays (Records in selection:C76([Alumnos_ComplementoEvaluacion:209]);->$at_indicadorEsfuerzo)
			AT_Populate (->$at_indicadorEsfuerzo;->$t_indicadorDespuesEdicion)
			KRL_Array2Selection (->$at_indicadorEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31)
			AT_Initialize (->$at_indicadorEsfuerzo)
		End if 
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36=$t_indicadorAntesEdicion)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			AT_RedimArrays (Records in selection:C76([Alumnos_ComplementoEvaluacion:209]);->$at_indicadorEsfuerzo)
			AT_Populate (->$at_indicadorEsfuerzo;->$t_indicadorDespuesEdicion)
			KRL_Array2Selection (->$at_indicadorEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36)
			AT_Initialize (->$at_indicadorEsfuerzo)
		End if 
		UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
		READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
		IT_UThermometer (-2;$l_progreso)
	End if 
	
	
End if 