//%attributes = {"invisible":true}
  // Upload_WITH_PROGRESS()
  //
  //
  // creado por: Alberto Bachler Klein: 01-08-16, 12:48:05
  // codigo original de Miyako
  // -----------------------------------------------------------
C_OBJECT:C1216($1)
C_LONGINT:C283($2)

C_BLOB:C604($x_in;$x_out)
C_LONGINT:C283($l_error;$l_parametros;$l_procesoLlamante;$l_tamañoDocumento;$l_proceso)
C_TEXT:C284($dstTimestampPath;$srcTimestampPath;$t_password;$t_rutaDestino;$t_rutaOrigen;$t_usuario)

ARRAY LONGINT:C221($al_nombreValores;0)
ARRAY TEXT:C222($at_valores;0)


If (False:C215)
	C_OBJECT:C1216(Upload_WITH_PROGRESS ;$1)
	C_LONGINT:C283(Upload_WITH_PROGRESS ;$2)
End if 

C_LONGINT:C283(vl_UploadCallingProcess)
C_OBJECT:C1216(ob_upload_Context)
$l_parametros:=Count parameters:C259

Case of 
	: ($l_parametros=1)
		$l_proceso:=New process:C317(Current method name:C684;0;"$"+Current method name:C684;$1;Current process:C322;*)
		
	: ($l_parametros=2)
		<>UPLOAD_ABORT:=False:C215
		<>UPLOAD_STATUS:=0
		
		ob_upload_Context:=$1
		$l_procesoLlamante:=$2
		vl_UploadCallingProcess:=$l_procesoLlamante
		
		$t_rutaOrigen:=OB Get:C1224(ob_upload_Context;"srcPath")
		$t_rutaDestino:=OB Get:C1224(ob_upload_Context;"dstPath")
		$t_usuario:=OB Get:C1224(ob_upload_Context;"user")
		$t_password:=OB Get:C1224(ob_upload_Context;"pass")
		
		$l_tamañoDocumento:=Get document size:C479($t_rutaOrigen)
		
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_USERNAME)
		APPEND TO ARRAY:C911($at_valores;$t_usuario)
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_PASSWORD)
		APPEND TO ARRAY:C911($at_valores;$t_password)
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_READDATA)
		APPEND TO ARRAY:C911($at_valores;$t_rutaOrigen)
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_XFERINFOFUNCTION)
		APPEND TO ARRAY:C911($at_valores;"Upload_CALLBACK")
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_XFERINFODATA)
		APPEND TO ARRAY:C911($at_valores;String:C10($l_tamañoDocumento))
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_UPLOAD)
		APPEND TO ARRAY:C911($at_valores;"1")
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_USE_SSL)
		APPEND TO ARRAY:C911($at_valores;"1")
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_SSL_VERIFYPEER)
		APPEND TO ARRAY:C911($at_valores;"0")
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_SSL_VERIFYHOST)
		APPEND TO ARRAY:C911($at_valores;"0")
		APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_FTP_CREATE_MISSING_DIR)
		APPEND TO ARRAY:C911($at_valores;"1")
		
		$l_error:=cURL ($t_rutaDestino;$al_nombreValores;$at_valores;$x_in;$x_out)
		
		If ($l_error=0)
			EXECUTE METHOD:C1007(OB Get:C1224(ob_upload_Context;"onSuccess");*;$l_procesoLlamante)
		Else 
			EXECUTE METHOD:C1007(OB Get:C1224(ob_upload_Context;"onError");*;$l_procesoLlamante)
		End if 
		
End case 