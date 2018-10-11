//%attributes = {}
  //UD_v20170530_FixPropEvalObj
  //Mono: Corregimos el problema del defecto de las tareas de fin de día con respecto al objeto de las propiedades de evaluación 
  // Defecto existente en la versión 12.01.14172 o inferior.

  //STR_ReadGlobals 
C_LONGINT:C283($l_proc)
C_TEXT:C284($t_versionBaseDeDatos)
  //ARRAY TEXT($at_uuid;0)  //uuid colegios con 12.01(30-05-2017) 
  //APPEND TO ARRAY($at_uuid;"2AA1B88F5309421ABE6408AA5572D99A")  //SAINT GEORGE S COLLEGE
  //APPEND TO ARRAY($at_uuid;"E7EEAE1D635040FA85349C0433D7C16D")  //WENLOCK
  //APPEND TO ARRAY($at_uuid;"FE1144C3D70441228C8C45BEF9AD1A77")  //Colegio Alemán Sankt Thomas Morus
  //APPEND TO ARRAY($at_uuid;"088C89956C07452A8905811A43E7202A")  //Universitario Inglés
  //APPEND TO ARRAY($at_uuid;"4BEAADE5FE8F424EAC96B5EAF61FF689")  //Escuela integral (UY)
  //APPEND TO ARRAY($at_uuid;"905087877B43440CAE8F452AC2CF1BD8")  //(ST-UY) The British Schools
  //$fia:=Find in array($at_uuid;<>gUUID)


  //20170613 RCH Se hacen cambios para 
  //******* INICIO
  //$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos 

  //If ($t_versionBaseDeDatos="12.01.@")
  //$l_proc:=IT_UThermometer (1;0;"Restaurando Propiedades de Evaluación en Asignaturas ...")
  //READ WRITE([Asignaturas])
  //ALL RECORDS([Asignaturas])
  //APPLY TO SELECTION([Asignaturas];[Asignaturas]Configuracion:=OB_Create )
  //KRL_UnloadReadOnly (->[Asignaturas])
  //IT_UThermometer (-2;$l_proc)
  //AsignaturaConfigBlob2Object 
  //dbu_VerificaConsolidaciones 
  //End if 
  //******* FIN

C_LONGINT:C283($l_sumaP1;$l_sumaP2;$l_sumaP3;$l_sumaP4;$l_sumaP5)
C_LONGINT:C283($l_indice;$l_indiceP)

$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos 

If ($t_versionBaseDeDatos="12.01.@")
	$l_proc:=IT_UThermometer (1;0;"Restaurando Propiedades de Evaluación en Asignaturas ...")
	READ ONLY:C145([Asignaturas:18])
	
	  //QUERY([Asignaturas];[Asignaturas]Numero=3117)
	ALL RECORDS:C47([Asignaturas:18])
	
	ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
	ARRAY LONGINT:C221($al_recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNums;"")
	
	For ($l_indice;1;Size of array:C274($al_recNums))
		READ ONLY:C145([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$al_recNums{$l_indice})
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		ARRAY LONGINT:C221($al_periodos;0)
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			AT_CopyArrayElements (->aiSTR_Periodos_Numero;->$al_periodos)
		Else 
			APPEND TO ARRAY:C911($al_periodos;0)
		End if 
		
		$l_sumaP1:=0
		$l_sumaP2:=0
		$l_sumaP3:=0
		$l_sumaP4:=0
		$l_sumaP5:=0
		
		For ($l_indiceP;1;Size of array:C274($al_periodos))
			AS_PropEval_Lectura ("";$al_periodos{$l_indiceP})
			
			ARRAY LONGINT:C221($al_result;0)
			Case of 
				: ($l_indiceP=1)
					$l_sumaP1:=AT_GetSumArray (->alAS_EvalPropSourceID)+AT_GetSumArray (->arAS_EvalPropPercent)+AT_SearchArray (->atAS_EvalPropPrintName;"#";->$al_result)
				: ($l_indiceP=2)
					$l_sumaP2:=AT_GetSumArray (->alAS_EvalPropSourceID)+AT_GetSumArray (->arAS_EvalPropPercent)+AT_SearchArray (->atAS_EvalPropPrintName;"#";->$al_result)
				: ($l_indiceP=3)
					$l_sumaP3:=AT_GetSumArray (->alAS_EvalPropSourceID)+AT_GetSumArray (->arAS_EvalPropPercent)+AT_SearchArray (->atAS_EvalPropPrintName;"#";->$al_result)
				: ($l_indiceP=4)
					$l_sumaP4:=AT_GetSumArray (->alAS_EvalPropSourceID)+AT_GetSumArray (->arAS_EvalPropPercent)+AT_SearchArray (->atAS_EvalPropPrintName;"#";->$al_result)
				: ($l_indiceP=5)
					$l_sumaP5:=AT_GetSumArray (->alAS_EvalPropSourceID)+AT_GetSumArray (->arAS_EvalPropPercent)+AT_SearchArray (->atAS_EvalPropPrintName;"#";->$al_result)
			End case 
		End for 
		
		If (($l_sumaP1+$l_sumaP2+$l_sumaP3+$l_sumaP4+$l_sumaP5)=0)
			READ WRITE:C146([Asignaturas:18])
			GOTO RECORD:C242([Asignaturas:18];$al_recNums{$l_indice})
			[Asignaturas:18]Configuracion:63:=OB_Create 
			SAVE RECORD:C53([Asignaturas:18])
			
			AS_CreateConfigObj ([Asignaturas:18]Numero:1)
			KRL_UnloadReadOnly (->[Asignaturas:18])
		End if 
		
		KRL_UnloadReadOnly (->[Asignaturas:18])
	End for 
	
	dbu_VerificaConsolidaciones 
	
	IT_UThermometer (-2;$l_proc)
	
End if 