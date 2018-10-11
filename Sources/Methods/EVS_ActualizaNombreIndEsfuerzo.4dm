//%attributes = {}
  //EVS_ActualizaNombreIndEsfuerzo


If (OldIndicador#"")
	
	READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
	KRL_RelateSelection (->[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16=OldIndicador;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21=OldIndicador;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26=OldIndicador;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31=OldIndicador;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36=OldIndicador)
	CREATE SET:C116([Alumnos_ComplementoEvaluacion:209];"SelActual")
	If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
		_O_ARRAY STRING:C218(5;EvEsfuerzo;0)
		$Process:=IT_UThermometer (1;0;__ ("Actualizando evaluaciones..."))
		CREATE SET:C116([Alumnos_ComplementoEvaluacion:209];"SelActual")
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16=OldIndicador)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			_O_ARRAY STRING:C218(5;aEvEsfuerzo;Records in selection:C76([Alumnos_ComplementoEvaluacion:209]))
			dummytxt:=aIndEsfuerzo{vRow}
			AT_Populate (->aEvEsfuerzo;->dummytxt)
			KRL_Array2Selection (->aEvEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16)
			AT_Initialize (->aEvEsfuerzo)
		End if 
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21=OldIndicador)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			_O_ARRAY STRING:C218(5;aEvEsfuerzo;Records in selection:C76([Alumnos_ComplementoEvaluacion:209]))
			dummytxt:=aIndEsfuerzo{vRow}
			AT_Populate (->aEvEsfuerzo;->dummytxt)
			KRL_Array2Selection (->aEvEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21)
			AT_Initialize (->aEvEsfuerzo)
		End if 
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26=OldIndicador)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			_O_ARRAY STRING:C218(5;aEvEsfuerzo;Records in selection:C76([Alumnos_ComplementoEvaluacion:209]))
			dummytxt:=aIndEsfuerzo{vRow}
			AT_Populate (->aEvEsfuerzo;->dummytxt)
			KRL_Array2Selection (->aEvEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26)
			AT_Initialize (->aEvEsfuerzo)
		End if 
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31=OldIndicador)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			_O_ARRAY STRING:C218(5;aEvEsfuerzo;Records in selection:C76([Alumnos_ComplementoEvaluacion:209]))
			dummytxt:=aIndEsfuerzo{vRow}
			AT_Populate (->aEvEsfuerzo;->dummytxt)
			KRL_Array2Selection (->aEvEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31)
			AT_Initialize (->aEvEsfuerzo)
		End if 
		
		USE SET:C118("SelActual")
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36=OldIndicador)
		If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
			_O_ARRAY STRING:C218(5;aEvEsfuerzo;Records in selection:C76([Alumnos_ComplementoEvaluacion:209]))
			dummytxt:=aIndEsfuerzo{vRow}
			AT_Populate (->aEvEsfuerzo;->dummytxt)
			KRL_Array2Selection (->aEvEsfuerzo;->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36)
			AT_Initialize (->aEvEsfuerzo)
		End if 
		UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
		READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
		IT_UThermometer (-2;$Process)
	End if 
	
	
End if 