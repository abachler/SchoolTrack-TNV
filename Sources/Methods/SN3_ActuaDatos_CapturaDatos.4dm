//%attributes = {}
  //descarga los datos desde SN3, REVISAR Y PROCESAR
C_BOOLEAN:C305($enviar_datos)

While (Semaphore:C143("SN3_ActuaDatos_Captura"))
	DELAY PROCESS:C323(Current process:C322;30)
End while 

SN3_LoadDataReceptionSettings 
SN3_ActuaDatos_GetFTPFiles 

$vt_carpeta_local:=SN3_GetFilesPath +"actuadatos"+Folder separator:K24:12
ARRAY TEXT:C222(at_archivos_descargados;0)
DOCUMENT LIST:C474($vt_carpeta_local;at_archivos_descargados)

  //Lectura de los xml descargados y carga temporal de actualizaciones...
For ($i;1;Size of array:C274(at_archivos_descargados))
	C_BOOLEAN:C305(vb_revisar)
	SN3_ActuaDatos_LeeXML ($vt_carpeta_local+at_archivos_descargados{$i})
	SN3_ActuaDatos_TempSave 
	DELETE DOCUMENT:C159($vt_carpeta_local+at_archivos_descargados{$i})
End for 

ARRAY TEXT:C222(at_tipo_id_usr;0)  //tipo.id
ARRAY DATE:C224(ad_last_actuadatos;0)
$settingsBlob:=PREF_fGetBlob (0;"SN3_ActuaDatos_Actualizaciones";$settingsBlob)
$ot:=OT BLOBToObject ($settingsBlob)
OT GetArray ($ot;"tipo_id";at_tipo_id_usr)
OT GetArray ($ot;"fecha_actua";ad_last_actuadatos)
OT Clear ($ot)

ARRAY LONGINT:C221($al_rn_fo_per;0)
READ ONLY:C145([XShell_FatObjects:86])
QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_ActuaDatos_Per@")
LONGINT ARRAY FROM SELECTION:C647([XShell_FatObjects:86];$al_rn_fo_per;"")
KRL_UnloadReadOnly (->[XShell_FatObjects:86])

ARRAY LONGINT:C221($al_id_personas_actualizadas;0)  //para enviar archivo 40001

For ($i;1;Size of array:C274($al_rn_fo_per))
	C_BOOLEAN:C305($vb_datos_sensibles)
	ARRAY LONGINT:C221($al_id_alu;0)
	GOTO RECORD:C242([XShell_FatObjects:86];$al_rn_fo_per{$i})
	$vl_id_apo:=[XShell_FatObjects:86]RecordID:6
	  //KRL_UnloadReadOnly (->[XShell_FatObjects])
	
	If (SN3_ActuaDatosReqVerif=1)  // ACTUALIZACION CON REVISION, ahora es al revés
		$vb_datos_revisar:=False:C215
		$vb_datos_revisar:=SN3_ActuaDatos_DatosSensibles ($vl_id_apo;->$al_id_alu)
	Else 
		$vb_datos_revisar:=True:C214
		$vb_datos_revisar:=SN3_ActuaDatos_SoloConfirma ($vl_id_apo;->$al_id_alu)
	End if 
	
	If (Not:C34($vb_datos_revisar))
		If (SN3_ActuaDatos_Uptade ($vl_id_apo;->$al_id_alu))
			APPEND TO ARRAY:C911($al_id_personas_actualizadas;$vl_id_apo)
		End if 
	End if 
	
End for 

SN3_ActuaDatos_resultadoproceso 

If (Size of array:C274($al_id_personas_actualizadas)>0)  //archivo 40001
	SN3_SendData2SchoolNet (True:C214;False:C215)
	
	C_TEXT:C284($vt_FileName;$xmlRef)
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";40001;"dom";->$xmlRef)
	$xmlRef:=DOM Create XML Ref:C861("colegium")
	DOM SET XML DECLARATION:C859($xmlRef;"UTF-8")
	For ($i;1;Size of array:C274($al_id_personas_actualizadas))
		DOM_SetElementValueAndAttr ($xmlRef;"id";String:C10($al_id_personas_actualizadas{$i});True:C214)
	End for 
	SN3_CloseXMLCompress ($xmlRef;$vt_FileName;"dom")
	SN3_FTP_SendFiles 
End if 

CLEAR SEMAPHORE:C144("SN3_ActuaDatos_Captura")