//%attributes = {}
  // Licencia_Descarga()
  // Por: Alberto Bachler K.: 27-08-14, 16:25:14
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)

C_BLOB:C604($x_blob;$x_Licencia;$x_llavePublica)
C_LONGINT:C283($l_codigoError)
C_TEXT:C284($t_Error;$t_errorWS;$t_json;$t_jsonLicencia;$t_Licencia;$t_llave;$t_refjson;$t_refJsonError;$t_refJsonLicencia;$t_refJsonLlave)

  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_licencias;$t_LicenciaEncriptadaB64)
C_LONGINT:C283($httpStatus_l;$l_errorJson)

If (False:C215)
	C_TEXT:C284(LICENCIA_Descarga ;$0)
End if 

STR_ReadGlobals 

  //MONO ticket 144984
$ob_request:=OB_Create 
OB_SET ($ob_request;-><>gUUID;"uuidColegio")
OB_SET ($ob_request;-><>GROLBD;"rolBD")
OB_SET ($ob_request;-><>GCOUNTRYCODE;"codigoPais")

$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
$httpStatus_l:=Intranet3_LlamadoWS ("WS_obtieneLicenciaColegio";$t_jsonRequest;->$t_json)  //MONO TICKET 183850

If ($httpStatus_l=200)
	
	$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
	If ((OB Is defined:C1231($ob_response;"error.codigoError")))
		OB_GET ($ob_response;->$l_errorJson;"error.codigoError")
	End if 
	
	If ($l_errorJson=0)
		  //MONO TICKET 183850
		  //OB_GET ($ob_response;->$t_licencias;"licencia.datosLicencia")
		  //$l_HLcrypt:=Load list("Crypt")
		  //GET LIST ITEM PARAMETER($l_HLcrypt;1;"priv";$t_llavePrivada)
		  //TEXT TO BLOB($t_llavePrivada;$x_llavePrivada;UTF8 text without length)
		  //  // pongo el json (texto) en un blob (en 4D solo se puede encriptar un blob)
		  //TEXT TO BLOB($t_licencias;$x_blob;UTF8 text without length)
		  //  // encripto el blob utilizando la llave privada (en 4D tambien almacenada en un blob)
		  //ENCRYPT BLOB($x_blob;$x_llavePrivada)
		  //  // convierto el blob que contiene la licencia encriptada en texto base64
		  //BASE64 ENCODE($x_blob;$t_LicenciaEncriptadaB64)
		
		  //  //20170613 RCH Se encripta datos licencia no el json completo
		  //OB_SET ($ob_response;->$t_LicenciaEncriptadaB64;"licencia.datosLicencia")
		  //MONO TICKET 183850
		
		ALL RECORDS:C47([xShell_ApplicationData:45])
		READ WRITE:C146([xShell_ApplicationData:45])
		If (Records in selection:C76([xShell_ApplicationData:45])=0)
			CREATE RECORD:C68([xShell_ApplicationData:45])
			[xShell_ApplicationData:45]ProductName:16:="Main"
		Else 
			FIRST RECORD:C50([xShell_ApplicationData:45])
		End if 
		
		  //20170613 RCH Se encripta datos licencia no el json completo
		  //[xShell_ApplicationData]Licencia:=$t_LicenciaEncriptadaB64
		[xShell_ApplicationData:45]Licencia:23:=JSON Stringify:C1217($ob_response)
		
		SAVE RECORD:C53([xShell_ApplicationData:45])
		  //KRL_UnloadReadOnly (->[xShell_ApplicationData])
		KRL_ReloadAsReadOnly (->[xShell_ApplicationData:45])  //20160314 RCH
	Else 
		OB_GET ($ob_response;->$t_ErrorWS;"error.textoError")
	End if 
	
End if 

$0:=$t_ErrorWS
