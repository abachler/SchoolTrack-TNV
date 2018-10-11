//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:51:41
  // ----------------------------------------------------
  // Método: STWA2_OWC_replicarPlanes
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
$recNumPlan:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
If ($recNumPlan=-1)
	If (KRL_GotoRecord (->[Asignaturas:18];$rnAsig;False:C215))
		PERIODOS_Init 
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=[Asignaturas:18]Numero:1)
		QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=vdSTR_Periodos_InicioEjercicio;*)
		QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; | [Asignaturas_PlanesDeClases:169]Desde:3=!00-00-00!)
		SELECTION TO ARRAY:C260([Asignaturas_PlanesDeClases:169]Desde:3;adSTRas_Planes_Desde;[Asignaturas_PlanesDeClases:169]Hasta:4;adSTRas_Planes_Hasta)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas_PlanesDeClases:169];$rnPlanes;"")
		For ($row;1;Size of array:C274(adSTRas_Planes_Desde))
			$idAsignatura:=[Asignaturas:18]Numero:1
			$recNumPlan:=$rnPlanes{$row}
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=[Asignaturas:18]Asignatura:3;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;=;[Asignaturas:18]Numero_del_Nivel:6;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion_por_sexo:24=[Asignaturas:18]Seleccion_por_sexo:24;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$idAsignatura)
			SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aIds)
			KRL_RelateSelection (->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
			QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3=adSTRas_Planes_Desde{$row};*)
			QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; & [Asignaturas_PlanesDeClases:169]Hasta:4=adSTRas_Planes_Hasta{$row})
			KRL_DeleteSelection (->[Asignaturas_PlanesDeClases:169])
			For ($i;1;Size of array:C274($aIds))
				KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$recNumPlan)
				DUPLICATE RECORD:C225([Asignaturas_PlanesDeClases:169])
				[Asignaturas_PlanesDeClases:169]ID_Asignatura:2:=$aIds{$i}
				[Asignaturas_PlanesDeClases:169]ID_Plan:1:=SQ_SeqNumber (->[Asignaturas_PlanesDeClases:169]ID_Plan:1)
				[Asignaturas_PlanesDeClases:169]Auto_UUID:15:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
				SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
				  //MONO 193174
				$t_logmsj:="Planes de Clases: Creación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
				$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
				$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
				LOG_RegisterEvt ($t_logmsj)
			End for 
			KRL_GotoRecord (->[Asignaturas:18];$rnAsig;False:C215)
		End for 
		$ob_raiz:=OB_Create 
		OB_SET_Text ($ob_raiz;"ok";"replica")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text ($jsonT;"replica";"ok")
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	Else 
		$json:=STWA2_JSON_SendError (-60000)
	End if 
Else 
	If (KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$recNumPlan;False:C215))
		$idAsignatura:=[Asignaturas_PlanesDeClases:169]ID_Asignatura:2
		If (KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$idAsignatura;False:C215)#-1)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=[Asignaturas:18]Asignatura:3;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;=;[Asignaturas:18]Numero_del_Nivel:6;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion_por_sexo:24=[Asignaturas:18]Seleccion_por_sexo:24;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$idAsignatura)
			SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aIds)
			KRL_RelateSelection (->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
			QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3=[Asignaturas_PlanesDeClases:169]Desde:3;*)
			QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; & [Asignaturas_PlanesDeClases:169]Hasta:4=[Asignaturas_PlanesDeClases:169]Hasta:4)
			KRL_DeleteSelection (->[Asignaturas_PlanesDeClases:169])
			For ($i;1;Size of array:C274($aIds))
				KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$recNumPlan)
				DUPLICATE RECORD:C225([Asignaturas_PlanesDeClases:169])
				[Asignaturas_PlanesDeClases:169]ID_Asignatura:2:=$aIds{$i}
				[Asignaturas_PlanesDeClases:169]ID_Plan:1:=SQ_SeqNumber (->[Asignaturas_PlanesDeClases:169]ID_Plan:1)
				[Asignaturas_PlanesDeClases:169]Auto_UUID:15:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
				SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
				  //MONO 193174
				$t_logmsj:="Planes de Clases: Creación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
				$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
				$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
				LOG_RegisterEvt ($t_logmsj)
			End for 
			  //$jsonT:=JSON New 
			  //$node:=JSON Append text ($jsonT;"replica";"ok")
			  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
			  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
			$ob_raiz:=OB_Create 
			OB_SET_Text ($ob_raiz;"ok";"replica")
			$json:=OB_Object2Json ($ob_raiz)
		Else 
			$json:=STWA2_JSON_SendError (-60000)
		End if 
	Else 
		$json:=STWA2_JSON_SendError (-60003)
	End if 
End if 

$0:=$json

