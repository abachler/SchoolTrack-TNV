//%attributes = {}
  //SYNC_VerificaRegistrosMod

C_BOOLEAN:C305($b_reintentar)
C_LONGINT:C283($l_recsConUUIDDiferente;$l_bloqueados)
C_TEXT:C284($t_mensaje;$t_json)
C_TEXT:C284($t_versionBaseDeDatos;$t_rutaBD;$t_destinatario;$t_copiaA;$t_asunto;$t_cuerpo;$t_datos)

ARRAY TEXT:C222($at_uuid;0)
ARRAY TEXT:C222($at_uuidColegio;0)
ARRAY TEXT:C222($at_dts;0)
ARRAY TEXT:C222($at_stPkey;0)
ARRAY TEXT:C222($at_condorPkey;0)

$b_reintentar:=True:C214
If (Count parameters:C259>=1)
	$b_reintentar:=$1
End if 

MESSAGES OFF:C175

If (Records in table:C83([sync_Modificaciones:284])>0)
	If (<>bXS_esServidorOficial)
		If (Util_isValidUUID (<>gUUID))
			
			$t_mensaje:="UUID Colegio válido"
			READ WRITE:C146([sync_Modificaciones:284])
			QUERY:C277([sync_Modificaciones:284];[sync_Modificaciones:284]uuid_colegio:21#<>gUUID)
			$l_recsConUUIDDiferente:=Records in selection:C76([sync_Modificaciones:284])
			CREATE SET:C116([sync_Modificaciones:284];"$setModificados")
			
			REDUCE SELECTION:C351([sync_Modificaciones:284];50)  //Se guarda info antes de ser modificada
			SELECTION TO ARRAY:C260([sync_Modificaciones:284]autouuid:1;$at_uuid;[sync_Modificaciones:284]uuid_colegio:21;$at_uuidColegio;[sync_Modificaciones:284]dts:16;$at_dts;[sync_Modificaciones:284]st_pkey:17;$at_stPkey;[sync_Modificaciones:284]condor_pkey:18;$at_condorPkey)
			
			USE SET:C118("$setModificados")
			APPLY TO SELECTION:C70([sync_Modificaciones:284];[sync_Modificaciones:284]uuid_colegio:21:=<>gUUID)
			$l_bloqueados:=Records in set:C195("LockedSet")
			KRL_UnloadReadOnly (->[sync_Modificaciones:284])
			
			SET_ClearSets ("$setModificados")
		Else 
			
			  //Si el uuid no es válido, se intenta obtener y se hace la verificación nuevamente.
			$t_mensaje:="UUID Colegio no válido"
			If ($b_reintentar)  //Solo se intena una vez
				LICENCIA_ObtieneUUIDinstitucion (True:C214)
				If (Util_isValidUUID (<>gUUID))
					SYNC_VerificaRegistrosMod (False:C215)
				End if 
			End if 
			
		End if 
		
		If ($l_recsConUUIDDiferente>0)
			$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos 
			$t_rutaBD:=SYS_GetServerProperty (XS_DataFileFolder)+SYS_GetServerProperty (XS_DataFileName)
			$t_asunto:="Registros con uuid distinto en tabla sync_modificaciones colegio "+<>gCustom
			$t_cuerpo:="Durante la ejecución de las tareas de fin de día se detectaron registros con uuid distintos al uuid del colegio."
			$t_cuerpo:=$t_cuerpo+"\r"+"Colegio: "+<>gCustom
			$t_cuerpo:=$t_cuerpo+"\r"+"Cantidad de registros en la tabla: "+String:C10(Records in table:C83([sync_Modificaciones:284]))
			$t_cuerpo:=$t_cuerpo+"\r"+"Cantidad de registros con uuid diferente: "+String:C10($l_recsConUUIDDiferente)
			$t_cuerpo:=$t_cuerpo+"\r"+"Registros no reparados: "+String:C10($l_bloqueados)
			$t_cuerpo:=$t_cuerpo+"\r"+"Ruta base: "+$t_rutaBD
			$t_cuerpo:=$t_cuerpo+"\r"+"Servidor oficial: "+String:C10(Num:C11(<>bXS_esServidorOficial))
			$t_cuerpo:=$t_cuerpo+"\r"+"Mensaje: "+$t_mensaje
			$t_cuerpo:=$t_cuerpo+"\r"+"UUID colegio: "+<>gUUID
			$t_cuerpo:=$t_cuerpo+"\r"+"Máquina: "+Current machine:C483  //20170325 RCH
			$t_cuerpo:=$t_cuerpo+"\r"+"Usuario máquina: "+Current system user:C484
			$t_cuerpo:=$t_cuerpo+"\r"+"Versión: "+$t_versionBaseDeDatos
			
			$t_datos:="Autouuid"+"\t"+"uuid Colegio"+"\t"+"dts"+"\t"+"st_pkey"+"\t"+"conto_pkey"+"\r"
			$t_datos:=$t_datos+AT_Arrays2Text ("\r";"\t";->$at_uuid;->$at_uuidColegio;->$at_dts;->$at_stPkey;->$at_condorPkey)
			$t_cuerpo:=$t_cuerpo+"\r"+"Datos de la tabla (máximo 50 regitros):"+"\r"
			$t_cuerpo:=$t_cuerpo+$t_datos
			
			$t_copiaA:=""
			$t_destinatario:="rcatalan@colegium.com"
			Mail_EnviaNotificacion ($t_asunto;$t_cuerpo;$t_destinatario;$t_copiaA)
			
			LOG_RegisterEvt ("Corrección uuid colegio en registro de modificaciones. "+$t_cuerpo+".")
			
		End if 
	End if 
End if 