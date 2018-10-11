//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 01-06-18, 14:43:08
  // ----------------------------------------------------
  // Método: CAE_InitPropEvaluacion
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_BOOLEAN:C305($b_readOnlyState)
C_LONGINT:C283($l_columna;$l_idAsignatura;$l_periodo)
C_TEXT:C284($t_nodo)
C_OBJECT:C1216($o_temporal)

READ WRITE:C146([Asignaturas:18])

ARRAY REAL:C219(arAS_EvalPropPercent;0)
ARRAY LONGINT:C221(alAS_EvalPropSourceID;0)
ARRAY TEXT:C222(atAS_EvalPropSourceName;0)
ARRAY TEXT:C222(atAS_EvalPropClassName;0)
ARRAY TEXT:C222(atAS_EvalPropPrintName;0)
ARRAY BOOLEAN:C223(abAS_EvalPropPrintDetail;0)
ARRAY LONGINT:C221(aiAS_EvalPropEnterable;0)
$l_idAsignatura:=$1

QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idAsignatura)
$b_readOnlyState:=Read only state:C362([Asignaturas:18])

If ($b_readOnlyState)
	KRL_ReloadInReadWriteMode (->[Asignaturas:18])
End if 

If (r1InitPropEvaluacion=1)
	AS_PropEval_Inicializa 
	SAVE RECORD:C53([Asignaturas:18])
	QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=[Asignaturas:18]Numero:1)
	KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
Else 
	If (r2InitPropEvaluacion=1)
		
		If (bInitPonderaciones=1)
			If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				For ($l_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
					$t_nodo:="P"+String:C10($l_periodo)
					$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;$t_nodo)
					AT_Initialize (->arAS_EvalPropPercent)
					AT_RedimArrays (12;->arAS_EvalPropPercent)
					OB SET ARRAY:C1227($o_temporal;"Percent";arAS_EvalPropPercent)
					OB SET:C1220([Asignaturas:18]Configuracion:63;"Anual";$o_temporal)
					SAVE RECORD:C53([Asignaturas:18])
				End for 
				
			Else 
				$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;"Anual")
				AT_Initialize (->arAS_EvalPropPercent)
				AT_RedimArrays (12;->arAS_EvalPropPercent)
				OB SET ARRAY:C1227($o_temporal;"Percent";arAS_EvalPropPercent)
				OB SET:C1220([Asignaturas:18]Configuracion:63;"Anual";$o_temporal)
				SAVE RECORD:C53([Asignaturas:18])
			End if 
		End if 
		
		If (bEliminarSubasignaturas=1)
			If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				For ($l_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
					$t_nodo:="P"+String:C10($l_periodo)
					$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;$t_nodo)
					AT_Initialize (->alAS_EvalPropSourceID;->atAS_EvalPropSourceName;->atAS_EvalPropClassName)
					OB GET ARRAY:C1229($o_temporal;"SourceID";alAS_EvalPropSourceID)
					OB GET ARRAY:C1229($o_temporal;"SourceName";atAS_EvalPropSourceName)
					OB GET ARRAY:C1229($o_temporal;"ClassName";atAS_EvalPropClassName)
					OB GET ARRAY:C1229($o_temporal;"PrintName";atAS_EvalPropPrintName)
					OB GET ARRAY:C1229($o_temporal;"PrintDetail";abAS_EvalPropPrintDetail)
					OB GET ARRAY:C1229($o_temporal;"Enterable";aiAS_EvalPropEnterable)
					
					For ($l_columna;1;Size of array:C274(alAS_EvalPropSourceID))
						If (alAS_EvalPropSourceID{$l_columna}<0)
							  //Elimino la subasignatura configurada
							QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]LongID:7=alAS_EvalPropSourceID{$l_columna};*)
							QUERY:C277([xxSTR_Subasignaturas:83]; & ;[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
							QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=$l_columna;*)
							QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=$l_periodo)
							KRL_DeleteSelection (->[xxSTR_Subasignaturas:83])
							atAS_EvalPropSourceName{$l_columna}:="Evaluación ingresable"
							alAS_EvalPropSourceID{$l_columna}:=0
							atAS_EvalPropClassName{$l_columna}:=""
							atAS_EvalPropPrintName{$l_columna}:=""
							abAS_EvalPropPrintDetail{$l_columna}:=False:C215
							aiAS_EvalPropEnterable{$l_columna}:=1
						Else 
							If (bInicializarConsolidaciones=1)
								atAS_EvalPropSourceName{$l_columna}:="Evaluación ingresable"
								alAS_EvalPropSourceID{$l_columna}:=0
								atAS_EvalPropClassName{$l_columna}:=""
								atAS_EvalPropPrintName{$l_columna}:=""
								abAS_EvalPropPrintDetail{$l_columna}:=False:C215
								aiAS_EvalPropEnterable{$l_columna}:=1
							End if 
						End if 
					End for 
					
					OB SET ARRAY:C1227($o_temporal;"SourceID";alAS_EvalPropSourceID)
					OB SET ARRAY:C1227($o_temporal;"SourceName";atAS_EvalPropSourceName)
					OB SET ARRAY:C1227($o_temporal;"ClassName";atAS_EvalPropClassName)
					OB SET ARRAY:C1227($o_temporal;"PrintName";atAS_EvalPropPrintName)
					OB SET ARRAY:C1227($o_temporal;"PrintDetail";abAS_EvalPropPrintDetail)
					OB SET ARRAY:C1227($o_temporal;"Enterable";aiAS_EvalPropEnterable)
					OB SET:C1220([Asignaturas:18]Configuracion:63;$t_nodo;$o_temporal)
					SAVE RECORD:C53([Asignaturas:18])
					
				End for 
			Else 
				$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;"Anual")
				AT_Initialize (->alAS_EvalPropSourceID;->atAS_EvalPropSourceName;->atAS_EvalPropClassName)
				OB GET ARRAY:C1229($o_temporal;"SourceID";alAS_EvalPropSourceID)
				OB GET ARRAY:C1229($o_temporal;"SourceName";atAS_EvalPropSourceName)
				OB GET ARRAY:C1229($o_temporal;"ClassName";atAS_EvalPropClassName)
				OB GET ARRAY:C1229($o_temporal;"PrintName";atAS_EvalPropPrintName)
				OB GET ARRAY:C1229($o_temporal;"PrintDetail";abAS_EvalPropPrintDetail)
				OB GET ARRAY:C1229($o_temporal;"Enterable";aiAS_EvalPropEnterable)
				
				For ($l_columna;1;Size of array:C274(alAS_EvalPropSourceID))
					If (alAS_EvalPropSourceID{$l_columna}<0)
						  //Elimino la subasignatura configurada
						QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]LongID:7=alAS_EvalPropSourceID{$l_columna};*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & ;[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=$l_columna)
						KRL_DeleteSelection (->[xxSTR_Subasignaturas:83])
						atAS_EvalPropSourceName{$l_columna}:="Evaluación ingresable"
						alAS_EvalPropSourceID{$l_columna}:=0
						atAS_EvalPropClassName{$l_columna}:=""
						atAS_EvalPropPrintName{$l_columna}:=""
						abAS_EvalPropPrintDetail{$l_columna}:=False:C215
						aiAS_EvalPropEnterable{$l_columna}:=1
					Else 
						If (bInicializarConsolidaciones=1)
							atAS_EvalPropSourceName{$l_columna}:="Evaluación ingresable"
							alAS_EvalPropSourceID{$l_columna}:=0
							atAS_EvalPropClassName{$l_columna}:=""
							atAS_EvalPropPrintName{$l_columna}:=""
							abAS_EvalPropPrintDetail{$l_columna}:=False:C215
							aiAS_EvalPropEnterable{$l_columna}:=1
						End if 
					End if 
				End for 
				
				OB SET ARRAY:C1227($o_temporal;"SourceID";alAS_EvalPropSourceID)
				OB SET ARRAY:C1227($o_temporal;"SourceName";atAS_EvalPropSourceName)
				OB SET ARRAY:C1227($o_temporal;"ClassName";atAS_EvalPropClassName)
				OB SET ARRAY:C1227($o_temporal;"PrintName";atAS_EvalPropPrintName)
				OB SET ARRAY:C1227($o_temporal;"PrintDetail";abAS_EvalPropPrintDetail)
				OB SET ARRAY:C1227($o_temporal;"Enterable";aiAS_EvalPropEnterable)
				OB SET:C1220([Asignaturas:18]Configuracion:63;"Anual";$o_temporal)
				SAVE RECORD:C53([Asignaturas:18])
			End if 
			
		End if 
		
		If (bInicializarConsolidaciones=1)
			If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				For ($l_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
					$t_nodo:="P"+String:C10($l_periodo)
					$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;$t_nodo)
					AT_Initialize (->alAS_EvalPropSourceID;->atAS_EvalPropSourceName;->atAS_EvalPropClassName)
					OB GET ARRAY:C1229($o_temporal;"SourceID";alAS_EvalPropSourceID)
					OB GET ARRAY:C1229($o_temporal;"SourceName";atAS_EvalPropSourceName)
					OB GET ARRAY:C1229($o_temporal;"ClassName";atAS_EvalPropClassName)
					OB GET ARRAY:C1229($o_temporal;"PrintName";atAS_EvalPropPrintName)
					OB GET ARRAY:C1229($o_temporal;"PrintDetail";abAS_EvalPropPrintDetail)
					OB GET ARRAY:C1229($o_temporal;"Enterable";aiAS_EvalPropEnterable)
					
					For ($l_columna;1;Size of array:C274(alAS_EvalPropSourceID))
						
						If (alAS_EvalPropSourceID{$l_columna}<0)
							READ WRITE:C146([xxSTR_Subasignaturas:83])
							QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]LongID:7=alAS_EvalPropSourceID{$l_columna};*)
							QUERY:C277([xxSTR_Subasignaturas:83]; & ;[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
							QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=$l_columna;*)
							QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=$l_periodo)
							APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Columna:13:=0)
							KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
						End if 
						
						atAS_EvalPropSourceName{$l_columna}:="Evaluación ingresable"
						alAS_EvalPropSourceID{$l_columna}:=0
						atAS_EvalPropClassName{$l_columna}:=""
						atAS_EvalPropPrintName{$l_columna}:=""
						abAS_EvalPropPrintDetail{$l_columna}:=False:C215
						aiAS_EvalPropEnterable{$l_columna}:=1
					End for 
					
					OB SET ARRAY:C1227($o_temporal;"SourceID";alAS_EvalPropSourceID)
					OB SET ARRAY:C1227($o_temporal;"SourceName";atAS_EvalPropSourceName)
					OB SET ARRAY:C1227($o_temporal;"ClassName";atAS_EvalPropClassName)
					OB SET ARRAY:C1227($o_temporal;"PrintName";atAS_EvalPropPrintName)
					OB SET ARRAY:C1227($o_temporal;"PrintDetail";abAS_EvalPropPrintDetail)
					OB SET ARRAY:C1227($o_temporal;"Enterable";aiAS_EvalPropEnterable)
					OB SET:C1220([Asignaturas:18]Configuracion:63;$t_nodo;$o_temporal)
					SAVE RECORD:C53([Asignaturas:18])
					
				End for 
			Else 
				$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;"Anual")
				AT_Initialize (->alAS_EvalPropSourceID;->atAS_EvalPropSourceName;->atAS_EvalPropClassName)
				OB GET ARRAY:C1229($o_temporal;"SourceID";alAS_EvalPropSourceID)
				OB GET ARRAY:C1229($o_temporal;"SourceName";atAS_EvalPropSourceName)
				OB GET ARRAY:C1229($o_temporal;"ClassName";atAS_EvalPropClassName)
				OB GET ARRAY:C1229($o_temporal;"PrintName";atAS_EvalPropPrintName)
				OB GET ARRAY:C1229($o_temporal;"PrintDetail";abAS_EvalPropPrintDetail)
				OB GET ARRAY:C1229($o_temporal;"Enterable";aiAS_EvalPropEnterable)
				
				For ($l_columna;1;Size of array:C274(alAS_EvalPropSourceID))
					
					If (alAS_EvalPropSourceID{$l_columna}<0)
						READ WRITE:C146([xxSTR_Subasignaturas:83])
						QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]LongID:7=alAS_EvalPropSourceID{$l_columna};*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & ;[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=$l_columna;*)
						APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Columna:13:=0)
						KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
					End if 
					
					atAS_EvalPropSourceName{$l_columna}:="Evaluación ingresable"
					alAS_EvalPropSourceID{$l_columna}:=0
					atAS_EvalPropClassName{$l_columna}:=""
					atAS_EvalPropPrintName{$l_columna}:=""
					abAS_EvalPropPrintDetail{$l_columna}:=False:C215
					aiAS_EvalPropEnterable{$l_columna}:=1
				End for 
				
				OB SET ARRAY:C1227($o_temporal;"SourceID";alAS_EvalPropSourceID)
				OB SET ARRAY:C1227($o_temporal;"SourceName";atAS_EvalPropSourceName)
				OB SET ARRAY:C1227($o_temporal;"ClassName";atAS_EvalPropClassName)
				OB SET ARRAY:C1227($o_temporal;"PrintName";atAS_EvalPropPrintName)
				OB SET ARRAY:C1227($o_temporal;"PrintDetail";abAS_EvalPropPrintDetail)
				OB SET ARRAY:C1227($o_temporal;"Enterable";aiAS_EvalPropEnterable)
				OB SET:C1220([Asignaturas:18]Configuracion:63;"Anual";$o_temporal)
				SAVE RECORD:C53([Asignaturas:18])
			End if 
			QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=[Asignaturas:18]Numero:1)
			KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
		End if 
		
	End if 
End if 

If ($b_readOnlyState)
	KRL_ReloadAsReadOnly (->[Asignaturas:18])
End if 

