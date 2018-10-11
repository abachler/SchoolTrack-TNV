//%attributes = {}
  //CORP_Create_and_Update_Scripts 
  //Revisa el webservice de las corporaciones en la intranet para crear o actualizar en la bd los scripts que tiene activo el colegio para ejecutar en las tareas de fin de día.

ARRAY LONGINT:C221($al_id;0)
ARRAY TEXT:C222($at_msj;0)
ARRAY OBJECT:C1221($ao_scripts;0)
ARRAY TEXT:C222($at_fechasEjecucion;0)
C_BOOLEAN:C305($b_error;$b_estado)
C_OBJECT:C1216($ob_request;$ob_scripts;$ob_ExecutionDays)
C_TEXT:C284($t_request;$t_response;$t_dtsMod;$t_dtsCreate;$t_script;$err)
C_LONGINT:C283($l_idScript;$l_rnScript;$l_orden;$l_ProgressProcID)


READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
$countryCode:=Uppercase:C13([Colegio:31]Codigo_Pais:31)
$rolBD:=[Colegio:31]Rol Base Datos:9
  //$rolBD:="246999"

$ob_request:=OB_Create 
OB_SET ($ob_request;->$rolBD;"rolbd")
OB_SET ($ob_request;->$countryCode;"codpais")
$t_request:=OB_Object2Json ($ob_request;True:C214)

$vi_try:=0
While ($vi_try<2)
	$httpStatus_l:=Intranet3_LlamadoWS ("WS_Get_Corp_Scripts";$t_request;->$t_response)
	If ($httpStatus_l#200)
		$vi_try:=$vi_try+1
		$b_error:=True:C214
		DELAY PROCESS:C323(Current process:C322;300)
	Else 
		$vi_try:=2
		$ob_scripts:=JSON Parse:C1218($t_response;Is object:K8:27)
		OB_GET ($ob_scripts;->$b_error;"error")
	End if 
End while 

If (Not:C34($b_error))
	
	OB_GET ($ob_scripts;->$ao_scripts;"scripts")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando Scripts de Coorporación")
	
	For ($i;1;Size of array:C274($ao_scripts))
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($i/Size of array:C274($ao_scripts)))
		
		OB_GET ($ao_scripts{$i};->$l_idScript;"id")
		OB_GET ($ao_scripts{$i};->$l_orden;"orden")
		OB_GET ($ao_scripts{$i};->$at_fechasEjecucion;"fechas_ejecucion")
		OB_GET ($ao_scripts{$i};->$t_script;"script")
		OB_GET ($ao_scripts{$i};->$b_estado;"estado")
		OB_GET ($ao_scripts{$i};->$t_dtsCreate;"dts_creacion")
		OB_GET ($ao_scripts{$i};->$t_dtsMod;"dts_ultima_modificacion")
		
		$ob_ExecutionDays:=OB_Create 
		OB_SET ($ob_ExecutionDays;->$at_fechasEjecucion;"arrayDays")
		
		$l_rnScript:=Find in field:C653([CORP_Scripts:197]ID_Script:1;$l_idScript)
		If ($l_rnScript=-1)  //creamos
			
			READ WRITE:C146([CORP_Scripts:197])
			CREATE RECORD:C68([CORP_Scripts:197])
			[CORP_Scripts:197]ID_Script:1:=$l_idScript
			[CORP_Scripts:197]Script:2:=$t_script
			[CORP_Scripts:197]Orden_de_Ejecucion:7:=$l_orden
			[CORP_Scripts:197]DTS_ModificacionScript:6:=$t_dtsMod
			[CORP_Scripts:197]DTS_GeneracionArchivo:4:=$t_dtsCreate
			[CORP_Scripts:197]Activo:5:=$b_estado
			[CORP_Scripts:197]ExecutionDays:8:=$ob_ExecutionDays
			SAVE RECORD:C53([CORP_Scripts:197])
			
			LOG_RegisterEvt ("CORP script:  Script id: "+String:C10($l_idScript)+" registrado en la BD")
			
			KRL_UnloadReadOnly (->[CORP_Scripts:197])
			
		Else   //verificamos y modificamos 
			
			READ WRITE:C146([CORP_Scripts:197])
			GOTO RECORD:C242([CORP_Scripts:197];$l_rnScript)
			If ($t_dtsMod>[CORP_Scripts:197]DTS_ModificacionScript:6)
				If (Not:C34([CORP_Scripts:197]Activo:5))  //si esta desactivado, se vuelve a activar si está dentro de los id que obtuvimos del webservice y se borra el dts de ultima generación para que se ejecute ahora
					[CORP_Scripts:197]DTS_GeneracionArchivo:4:=""
					[CORP_Scripts:197]Activo:5:=True:C214
					LOG_RegisterEvt ("CORP script: Fue activado el script id: "+String:C10($l_idScript))
				End if 
				[CORP_Scripts:197]Orden_de_Ejecucion:7:=$l_orden
				[CORP_Scripts:197]DTS_ModificacionScript:6:=$t_dtsMod
				[CORP_Scripts:197]Script:2:=$t_script
				[CORP_Scripts:197]ExecutionDays:8:=$ob_ExecutionDays
				SAVE RECORD:C53([CORP_Scripts:197])
				LOG_RegisterEvt ("CORP script: Fue modificado el script id: "+String:C10($l_idScript))
			End if 
			
			KRL_UnloadReadOnly (->[CORP_Scripts:197])
		End if 
		
		APPEND TO ARRAY:C911($al_id;$l_idScript)
		
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	  //Se desactivan los script que existen en la bd local pero no vienen en el arreglo que entregó el webservice
	ARRAY LONGINT:C221($al_Id_existentes;0)
	
	ALL RECORDS:C47([CORP_Scripts:197])
	SELECTION TO ARRAY:C260([CORP_Scripts:197]ID_Script:1;$al_Id_existentes)
	
	$vt_msj:=""
	For ($i;1;Size of array:C274($al_Id_existentes))
		
		If (Find in array:C230($al_id;$al_Id_existentes{$i})=-1)
			READ WRITE:C146([CORP_Scripts:197])
			QUERY:C277([CORP_Scripts:197];[CORP_Scripts:197]ID_Script:1=$al_Id_existentes{$i})
			[CORP_Scripts:197]Activo:5:=False:C215
			SAVE RECORD:C53([CORP_Scripts:197])
			APPEND TO ARRAY:C911($at_msj;String:C10([CORP_Scripts:197]ID_Script:1))
			KRL_UnloadReadOnly (->[CORP_Scripts:197])
		End if 
		
	End for 
	
	If (Size of array:C274($at_msj)>0)
		LOG_RegisterEvt ("CORP script: Ha(n) sido desactivado(s) el o los script(s) ID ("+AT_array2text (->$at_msj;", ")+"), según la información obtenida desde la intranet.")
	End if 
	
Else 
	LOG_RegisterEvt ("CORP script: No pudo conectar al webservice para obtener el listado de scripts..."+$err)
End if 