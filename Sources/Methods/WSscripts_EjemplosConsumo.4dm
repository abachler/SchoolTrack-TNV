//%attributes = {}
  //WSscripts_EjemplosConsumo 

C_TEXT:C284(vtWS_ResultString)

$t_accion:="cargar"
$t_accion:="listar"
$t_accion:="borrar"
$t_accion:="modificar"
$t_accion:="ejecutar"
$t_accion:="obtener"
$t_accion:="ejecuta"

$t_ip:="http://172.16.0.16:8025/4DSOAP/"  //RCH
$t_ip:="http://172.16.0.16:8081/4DSOAP/"  //RCH
$t_ip:="http://200.54.168.84:8025/4DSOAP/"  //Mayflower
$t_country:="cl"
$t_rol:="117765"

$t_ip:="http://schooltrack.ssccmanquehue.cl/4DSOAP/"  //Manquehue
$t_country:="cl"
$t_rol:="88773"

$t_ip:="http://201.238.253.118/4DSOAP/"  //Padre hurtado
$t_country:="cl"
$t_rol:="89915"

$t_ip:="http://190.196.208.28/4DSOAP/"  //Scuola
$t_country:="cl"
$t_rol:="88633"

  //If (False)




  //Monjas Inglesas
$t_ip:="http://152.231.83.35/4DSOAP/"
$t_country:="cl"
$t_rol:="88781"

  //Padre Hurtado
$t_ip:="http://201.238.253.118/4DSOAP/"
$t_country:="cl"
$t_rol:="89915"

  //Condor
$t_ip:="http://condor.colegium.com/4DSOAP/"
$t_country:="cl"
$t_rol:="89915"

  //Monjas Inglesas
$t_ip:="http://152.231.83.35/4DSOAP/"
$t_country:="cl"
$t_rol:="88781"

  //If (True)
  //  //Scuola
$t_ip:="http://190.196.208.28/4DSOAP/"  //Scuola
$t_country:="cl"
$t_rol:="88633"


$t_ip:="http://schooltrack.ssccmanquehue.cl/4DSOAP/"  //Manquehue
$t_country:="cl"
$t_rol:="88773"

  //Pto varas
$t_ip:="http://puertovaras.schooltrack.cl/4DSOAP/"
$t_country:="cl"
$t_rol:="221449"
  //End if 


$t_ip:="http://190.196.208.28/4DSOAP/"  //Scuola
$t_country:="cl"
$t_rol:="88633"

$t_ip:="http://190.196.67.69/4DSOAP/"  //San José de Chicureo
$t_country:="cl"
$t_rol:="253480"


$t_ip:="http://200.72.32.174:8081/4DSOAP/"  //Mackay
$t_country:="cl"
$t_rol:="17884"

  //t_ip:="http://186.67.167.140:8080/4DSOAP/"  //Altazor
  //$t_country:="cl"
  //$t_rol:="14866"

  //San Gabriel
  //$t_accion:="ejecuta"
$t_ip:="http://190.82.116.10/4DSOAP/"  //San Gabriel
$t_country:="cl"
$t_rol:="89664"


  //  //Local host
  //$t_ip:="http://localhost/4DSOAP/"
  //$t_country:="cl"
  //$t_rol:="88633"

  //Padre Hurtado
  //$t_ip:="http://201.238.253.118/4DSOAP/"
  //$t_country:="cl"
  //$t_rol:="89915"

  //Morus
$t_ip:="http://186.67.110.82/4DSOAP/"
$t_country:="cl"
$t_rol:="89923"


$t_ip:="http://186.67.167.140:8080/4DSOAP/"  //Altazor
$t_country:="cl"
$t_rol:="14866"

$t_ip:="http://189.211.79.251/4DSOAP/"  //Cedros
  //$t_ip:="http://localhost/4DSOAP/"  //Cedros
$t_country:="mx"
$t_rol:="FEC970515N38"

TRACE:C157
  //EM_ErrorManager ("Install")
  //EM_ErrorManager ("SetMode";"")
Case of 
	: ($t_accion="ejecuta")
		C_BLOB:C604($xBlob)
		C_TEXT:C284($t_script;vtWS_respuesta)
		
		  //ALERT(PREF_fGet (0;"ADT_ScriptImportaDatos"))
		  //$t_script:="PREF_Set (0;"+ST_Qte ("ADT_ScriptImportaDatos")+";"+ST_Qte ("ALGO")+")"
		$t_script:="PREF_Set (0;"+ST_Qte ("ADT_ScriptImportaDatos")+";"+ST_Qte ("11C2FCF1736846C2996617CAA191A8A1")+")"
		$t_script:="EXECUTE FORMULA(PREF_Set (0;"+ST_Qte ("ADT_ScriptImportaDatos")+";"+ST_Qte ("884D37236F2E1545BB1B4DDA5A386F46")+"))"  //20140620 RCH Base Mayflower
		$t_script:="PREF_Set (0;"+ST_Qte ("ADT_ScriptImportaDatos")+";"+ST_Qte ("884D37236F2E1545BB1B4DDA5A386F46")+")"  //20140620 RCH Base Mayflower
		$t_script:=4D_GetMethodText ("WSscript_EjemploScriptAEjecutar")
		CONVERT FROM TEXT:C1011($t_script;"UTF-8";$xBlob)
		
		$dts:=DTS_MakeFromDateTime (Current date:C33(*))
		
		C_TEXT:C284($t_versionBaseDeDatos)
		$t_versionConFormato:=SYS_LeeVersionBaseDeDatos 
		TRACE:C157
		If ($t_versionConFormato<"11.10.13778")
			$t_llave:=ACTwp_GeneraKey ($dts;$t_country;$t_rol)
		Else 
			$t_llave:=WSscript_GeneraLlave ($dts;$xBlob;$t_country;$t_rol)
		End if 
		
		WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
		WEB SERVICE SET PARAMETER:C777("script";$xBlob)
		WEB SERVICE SET PARAMETER:C777("dts";$dts)
		WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
		WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_Ejecuta";"WSscripts_Ejecuta";"schooltrack";Web Service dynamic:K48:1)
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_respuesta;"json")
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result";*)
			TRACE:C157
			
			  //20170125 RCH Se cambia por objetos
			If (vtWS_respuesta#"")
				$ob:=JSON Parse:C1218(vtWS_respuesta)
				$t_retorno:=JSON Stringify:C1217($ob;*)
				SET TEXT TO PASTEBOARD:C523($t_retorno)
			Else 
				SET TEXT TO PASTEBOARD:C523(vtWS_ResultString)
			End if 
			
			If (False:C215)  //para obtener el contenido de archivos en base 64
				C_BLOB:C604($targetBlob)
				C_TEXT:C284($t_texto)
				$t_texto:=""
				$t_nodo:=OB Get:C1224($ob;$t_texto;Is text:K8:3)
				BASE64 DECODE:C896($t_nodo;$targetBlob)
				SET TEXT TO PASTEBOARD:C523(Convert to text:C1012($targetBlob;"UTF-8"))
			End if 
			
		End if 
		
	: ($t_accion="obtener")
		C_BLOB:C604($xBlob)
		
		$dts:=DTS_MakeFromDateTime (Current date:C33(*))
		$t_llave:=ACTwp_GeneraKey ($dts;"cl";"117765")
		$t_uuid:="11C2FCF1736846C2996617CAA191A8A1"
		  //$t_uuid:="E71022F9E3F4452592BD7457D81DB357"
		WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
		WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
		WEB SERVICE SET PARAMETER:C777("dts";$dts)
		WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
		WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_ObtieneScript";"WSscripts_ObtieneScript";"schooltrack";Web Service dynamic:K48:1)
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result")
			If (vtWS_ResultString="")
				WEB SERVICE GET RESULT:C779($xBlob;"script";*)
				SET TEXT TO PASTEBOARD:C523(Convert to text:C1012($xBlob;"UTF-8"))
			End if 
		End if 
		
	: ($t_accion="ejecutar")
		$dts:=DTS_MakeFromDateTime (Current date:C33(*))
		$t_llave:=ACTwp_GeneraKey ($dts;"cl";"117765")
		$t_uuid:="11C2FCF1736846C2996617CAA191A8A1"
		  //$t_uuid:="E71022F9E3F4452592BD7457D81DB357"
		WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
		WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
		WEB SERVICE SET PARAMETER:C777("dts";$dts)
		WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
		WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_EjecutaScript";"WSscripts_EjecutaScript";"schooltrack";Web Service dynamic:K48:1)
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result";*)
		End if 
		
	: ($t_accion="modificar")
		$dts:=DTS_MakeFromDateTime (Current date:C33(*))
		$t_llave:=ACTwp_GeneraKey ($dts;"cl";"117765")
		$t_uuid:="11C2FCF1736846C2996617CAA191A8A1"
		  //$t_uuid:="E71022F9E3F4452592BD7457D81DB357"
		$t_text:=4D_GetMethodText ("ADTwa_scriptMayflower")
		CONVERT FROM TEXT:C1011($t_text;"UTF-8";$xBlob)
		
		WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
		WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
		WEB SERVICE SET PARAMETER:C777("dts";$dts)
		WEB SERVICE SET PARAMETER:C777("script";$xBlob)
		WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
		WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_ModificaScript";"WSscripts_ModificaScript";"schooltrack";Web Service dynamic:K48:1)
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result";*)
		End if 
		
	: ($t_accion="borrar")
		$dts:=DTS_MakeFromDateTime (Current date:C33(*))
		$t_llave:=ACTwp_GeneraKey ($dts;"cl";"117765")
		$t_uuid:="E71022F9E3F4452592BD7457D81DB357"
		TRACE:C157
		  //****CUERPO****
		error:=0
		  //EM_ErrorManager ("Install")
		  //EM_ErrorManager ("SetMode";"")
		
		WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
		WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
		WEB SERVICE SET PARAMETER:C777("dts";$dts)
		WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
		
		
		WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_EliminaScript";"WSscripts_EliminaScript";"schooltrack";Web Service dynamic:K48:1)
		
		  //EM_ErrorManager ("Clear")
		
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result";*)
		End if 
		
	: ($t_accion="listar")
		
		C_TEXT:C284(json)
		
		$dts:=DTS_MakeFromDateTime (Current date:C33(*))
		$t_llave:=ACTwp_GeneraKey ($dts;"cl";"117765")
		TRACE:C157
		  //****CUERPO****
		error:=0
		  //EM_ErrorManager ("Install")
		  //EM_ErrorManager ("SetMode";"")
		
		WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
		WEB SERVICE SET PARAMETER:C777("dts";$dts)
		WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
		
		WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_ListaScript";"WSscripts_ListaScript";"schooltrack";Web Service dynamic:K48:1)
		  //EM_ErrorManager ("Clear")
		
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result")
			If (vtWS_ResultString="")
				WEB SERVICE GET RESULT:C779(json;"json";*)
				
				ARRAY REAL:C219($ar_ids;0)
				ARRAY TEXT:C222($at_des;0)
				ARRAY TEXT:C222($at_uuids;0)
				
				ARRAY TEXT:C222($at_nodos;0)
				ARRAY LONGINT:C221($al_tipos;0)
				ARRAY TEXT:C222($at_nombres;0)
				
				ARRAY TEXT:C222($at_nodos2;0)
				ARRAY LONGINT:C221($al_tipos2;0)
				ARRAY TEXT:C222($at_nombres2;0)
				
				ARRAY TEXT:C222($at_nodos3;0)
				ARRAY LONGINT:C221($al_tipos3;0)
				ARRAY TEXT:C222($at_nombres3;0)
				
				C_REAL:C285($r_procesado;$r_idscript)
				C_TEXT:C284($root;$nodeErr;$nodeErrCod;$t_descripcion;$tuuid)
				
				
				C_OBJECT:C1216($ob;$ob_estado)
				
				
				
				$ob:=OB_Create 
				
				OB_GET ($ob;->$ob_estado;"estado")
				OB_GET ($ob_estado;->$r_procesado;"codigo")
				
				  //$root:=JSON Parse text (json)
				  //$nodeErr:=JSON Get child by name ($root;"estado")
				  //$nodeErrCod:=JSON Get child by name ($nodeErr;"codigo")
				  //$r_procesado:=JSON Get real ($nodeErrCod)
				
				If ($r_procesado=0)
					
					ARRAY OBJECT:C1221($ao_object;0)
					  //$node:=JSON Get child by name ($root;"scripts")
					OB_GET ($ob;->$ao_object;"scripts")
					For ($i;1;Size of array:C274($ao_object))
						OB_GET ($ao_object{$i};->$r_idscript;"idscript")
						OB_GET ($ao_object{$i};->$t_descripcion;"descripcion")
						OB_GET ($ao_object{$i};->$tuuid;"uuid")
						APPEND TO ARRAY:C911($ar_ids;$r_idscript)
						APPEND TO ARRAY:C911($at_des;$t_descripcion)
						APPEND TO ARRAY:C911($at_uuids;$tuuid)
					End for 
					  //$node:=JSON Get child by name ($root;"scripts")
					  //JSON GET CHILD NODES ($root;$at_nodos;$al_tipos;$at_nombres)
					  //JSON GET CHILD NODES ($at_nodos{2};$at_nodos2;$al_tipos2;$at_nombres2)
					  //For ($j;1;Size of array($at_nodos2))
					  //JSON GET CHILD NODES ($at_nodos2{$j};$at_nodos3;$al_tipos3;$at_nombres3)
					  //For ($i;1;Size of array($at_nodos3))
					  //$t_nombre:=$at_nombres3{$i}
					  //Case of 
					  //: ($t_nombre="idscript")
					  //APPEND TO ARRAY($ar_ids;JSON Get real ($at_nodos3{$i}))
					  //: ($t_nombre="descripcion")
					  //APPEND TO ARRAY($at_des;JSON Get text ($at_nodos3{$i}))
					  //: ($t_nombre="uuid")
					  //APPEND TO ARRAY($at_uuids;JSON Get text ($at_nodos3{$i}))
					  //End case 
					  //End for 
					  //End for 
				End if 
				JSON CLOSE ($root)
				
			End if 
		End if 
		
		
	: ($t_accion="cargar")
		C_BLOB:C604($xBlob)
		$dts:=DTS_MakeFromDateTime (Current date:C33(*))
		$t_llave:=ACTwp_GeneraKey ($dts;"cl";"117765")
		TRACE:C157
		$t_text:=4D_GetMethodText ("ADTwa_scriptMayflower")
		CONVERT FROM TEXT:C1011($t_text;"UTF-8";$xBlob)
		$t_desc:="Importa datos Mayflower"
		
		
		  //****CUERPO****
		error:=0
		  //EM_ErrorManager ("Install")
		  //EM_ErrorManager ("SetMode";"")
		
		WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
		WEB SERVICE SET PARAMETER:C777("script";$xBlob)
		WEB SERVICE SET PARAMETER:C777("dts";$dts)
		WEB SERVICE SET PARAMETER:C777("descripcion";$t_desc)
		WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
		
		
		  //CALL WEB SERVICE($t_ip+"";"SchoolNetII_WebServices";"WSscripts_CargaScript";"http://127.0.0.1:8025"+"/namespace_SchoolNetII";Web Service Dynamic)
		WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_CargaScript";"WSscripts_CargaScript";"schooltrack";Web Service dynamic:K48:1)
		  //CALL WEB SERVICE("http://www.colegium.com/4DSOAP/";"SchoolNet_WebServices#WSout_SchoolNetUsers";"WSout_SchoolNetUsers";"http://www.colegium.com/namespace_colegium";Web Service Dynamic)
		
		  //EM_ErrorManager ("Clear")
		
		If (OK=1)
			WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result";*)
		End if 
		
End case 

  //EM_ErrorManager ("Clear")