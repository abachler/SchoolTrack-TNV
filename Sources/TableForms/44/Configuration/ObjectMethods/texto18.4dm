  // [xxSTR_EstilosEvaluacion].Configuration.texto18()
  //
  //
  // creado por: Alberto Bachler Klein: 16-07-16, 10:38:13
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_verdadero)
C_LONGINT:C283($l_resultado)

ARRAY BOOLEAN:C223($ab_booleano;0)
ARRAY LONGINT:C221($l_progreso;0)
ARRAY LONGINT:C221($l_opcion;0)
ARRAY TEXT:C222($at_vacio;0)

If (cb_EvaluaEsfuerzo=1)
	$l_opcion:=CD_Dlog (0;__ ("¿Desea habilitar el registro de Esfuerzo en las asignaturas que utilizan este estilo de evaluación?");__ ("");__ ("No");__ ("Si"))
	If ($l_opcion=2)
		$l_progreso:=IT_UThermometer (1;0;__ ("Aplicando cambios..."))
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
		AT_RedimArrays (Records in selection:C76([Asignaturas:18]);->$ab_booleano)
		$b_verdadero:=True:C214
		AT_Populate (->$ab_booleano;->$b_verdadero)
		OK:=KRL_Array2Selection (->$ab_booleano;->[Asignaturas:18]Ingresa_Esfuerzo:40)
		If (OK=1)
			r1_EvEsfuerzoIndicadores:=1
			r2_EvEsfuerzoBonificacion:=0
			EVS_GuardaEstiloEvaluacion 
			EVS_SetModified 
		Else 
			cb_EvaluaEsfuerzo:=0
		End if 
		IT_UThermometer (-2;$l_progreso)
	End if 
	
	
	
Else 
	
	READ WRITE:C146([Asignaturas:18])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
	
	READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
	KRL_RelateSelection (->[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16#"";*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21#"";*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26#"";*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31#"";*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36#"")
	MESSAGES OFF:C175
	If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
		$l_opcion:=CD_Dlog (0;__ ("Los esfuerzos ingresados en las asignaturas cuyo estilo de evaluación es ")+[xxSTR_EstilosEvaluacion:44]Name:2+__ (" serán eliminados.\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
		If ($l_opcion=2)
			$l_progreso:=IT_UThermometer (1;0;__ ("Actualizando evaluaciones..."))
			AT_Initialize (->$at_vacio)
			AT_RedimArrays (Records in selection:C76([Alumnos_ComplementoEvaluacion:209]);->$at_vacio)
			$l_resultado:=KRL_Array2Selection (->$at_vacio;->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;->$at_vacio;->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;->$at_vacio;->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;->$at_vacio;->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;->$at_vacio;->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36)
			
			
			If ($l_resultado=1)
				AT_RedimArrays (Records in selection:C76([Asignaturas:18]);->$ab_booleano)
				$l_resultado:=KRL_Array2Selection (->$ab_booleano;->[Asignaturas:18]Ingresa_Esfuerzo:40;->$ab_booleano;->[Asignaturas:18]Pondera_Esfuerzo:61)
				vlEVS_CurrentEvStyleID:=0
				EVS_CargaEstiloEvaluacion (aEvStyleId{aEvStyleId})
			End if 
			
			If ($l_resultado=1)
				r1_EvEsfuerzoIndicadores:=0
				r2_EvEsfuerzoBonificacion:=0
				EVS_GuardaEstiloEvaluacion 
				EVS_SetModified 
			Else 
				cb_EvaluaEsfuerzo:=1
			End if 
			IT_UThermometer (-2;$l_progreso)
		Else 
			cb_EvaluaEsfuerzo:=1
		End if 
		
	Else 
		$l_progreso:=IT_UThermometer (1;0;__ ("Aplicando cambios..."))
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
		AT_RedimArrays (Records in selection:C76([Asignaturas:18]);->$ab_booleano)
		OK:=KRL_Array2Selection (->$ab_booleano;->[Asignaturas:18]Ingresa_Esfuerzo:40;->$ab_booleano;->[Asignaturas:18]Pondera_Esfuerzo:61)
		If (OK=1)
			EVS_GuardaEstiloEvaluacion 
			EVS_SetModified 
		Else 
			cb_EvaluaEsfuerzo:=1
		End if 
		IT_UThermometer (-2;$l_progreso)
	End if 
	UNLOAD RECORD:C212([Asignaturas:18])
	UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
	READ ONLY:C145([Asignaturas:18])
	READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
	
End if 


EVS_SetModified 