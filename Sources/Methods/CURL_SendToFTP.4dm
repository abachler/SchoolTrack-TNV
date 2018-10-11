//%attributes = {}
  // CURL_SendToFTP()
  //
  //
  // creado por: Alberto Bachler Klein: 09/02/17, 18:22:01
  // -----------------------------------------------------------

If (False:C215)
	  //C_TEXT($0)
	  //C_TEXT($1)
	  //C_TEXT($2)
	  //C_TEXT($3)
	  //C_TEXT($4)
	
	  //C_BLOB($x_in;$x_out)
	  //C_LONGINT($l_error;$l_tamañoDocumento)
	  //C_TEXT($t_error;$t_password;$t_rutaDestino;$t_rutaOrigen;$t_usuario)
	
	  //ARRAY LONGINT($al_nombreValores;0)
	  //ARRAY TEXT($at_valores;0)
	
	
	
	  //If (False)
	  //C_TEXT(CURL_SendToFTP ;$0)
	  //C_TEXT(CURL_SendToFTP ;$1)
	  //C_TEXT(CURL_SendToFTP ;$2)
	  //C_TEXT(CURL_SendToFTP ;$3)
	  //C_TEXT(CURL_SendToFTP ;$4)
	  //End if 
	
	
	
	  //$t_rutaOrigen:=$1
	  //$t_rutaDestino:=$2
	  //$t_usuario:=$3
	  //$t_password:=$4
	
	  //$l_tamañoDocumento:=Get document size($t_rutaOrigen)
	
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_USERNAME)
	  //APPEND TO ARRAY($at_valores;$t_usuario)
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_PASSWORD)
	  //APPEND TO ARRAY($at_valores;$t_password)
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_READDATA)
	  //APPEND TO ARRAY($at_valores;$t_rutaOrigen)
	  //  //APPEND TO ARRAY($al_nombreValores;CURLOPT_XFERINFOFUNCTION)
	  //APPEND TO ARRAY($at_valores;"Upload_CALLBACK")
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_XFERINFODATA)
	  //APPEND TO ARRAY($at_valores;String($l_tamañoDocumento))
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_UPLOAD)
	  //APPEND TO ARRAY($at_valores;"1")
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_USE_SSL)
	  //APPEND TO ARRAY($at_valores;"1")
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_SSL_VERIFYPEER)
	  //APPEND TO ARRAY($at_valores;"0")
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_SSL_VERIFYHOST)
	  //APPEND TO ARRAY($at_valores;"0")
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_FTP_CREATE_MISSING_DIR)
	  //APPEND TO ARRAY($at_valores;"1")
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_FTP_RESPONSE_TIMEOUT)
	  //APPEND TO ARRAY($at_valores;"127")
	  //APPEND TO ARRAY($al_nombreValores;CURLOPT_FTP_SKIP_PASV_IP)
	  //APPEND TO ARRAY($at_valores;Choose(<>ftp_UsePassive=1;"0";"1"))
	
	
	  //$l_error:=cURL ($t_rutaDestino;$al_nombreValores;$at_valores;$x_in;$x_out)
	
	  //If ($l_error#0)
	  //$t_error:="Error CURL Nº"+String($l_error)
	  //End if 
	
	  //$0:=$t_error
End if 


  // CURL_SendToFTP()
  //
  //
  // creado por: Alberto Bachler Klein: 09/02/17, 18:22:01
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_BLOB:C604($x_in;$x_out)
C_LONGINT:C283($l_error;$l_tamañoDocumento)
C_TEXT:C284($t_error;$t_password;$t_rutaDestino;$t_rutaOrigen;$t_usuario)

ARRAY LONGINT:C221($al_nombreValores;0)
ARRAY TEXT:C222($at_valores;0)



If (False:C215)
	C_TEXT:C284(CURL_SendToFTP ;$0)
	C_TEXT:C284(CURL_SendToFTP ;$1)
	C_TEXT:C284(CURL_SendToFTP ;$2)
	C_TEXT:C284(CURL_SendToFTP ;$3)
	C_TEXT:C284(CURL_SendToFTP ;$4)
End if 


$t_rutaOrigen:=$1
$t_rutaDestino:=$2
$t_usuario:=$3
$t_password:=$4



$l_progress:=Progress New 
Progress SET BUTTON ENABLED ($l_progress;True:C214)
Progress SET ON STOP METHOD ($l_progress;"CURL_Stop")


APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_USERNAME)
APPEND TO ARRAY:C911($at_valores;$t_usuario)
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_PASSWORD)
APPEND TO ARRAY:C911($at_valores;$t_password)
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_READDATA)
APPEND TO ARRAY:C911($at_valores;$t_rutaOrigen)
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_XFERINFOFUNCTION)
APPEND TO ARRAY:C911($at_valores;"CURL_Callback")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_XFERINFODATA)
APPEND TO ARRAY:C911($at_valores;String:C10($l_progress))
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
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_FTP_RESPONSE_TIMEOUT)
APPEND TO ARRAY:C911($at_valores;"127")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_FTP_SKIP_PASV_IP)
APPEND TO ARRAY:C911($at_valores;Choose:C955(<>ftp_UsePassive=1;"0";"1"))


$l_error:=cURL ($t_rutaDestino;$al_nombreValores;$at_valores;$x_in;$x_out)

If ($l_error#0)
	$t_error:="Error CURL Nº"+String:C10($l_error)
Else 
	If (Not:C34(Progress Stopped ($progressId)))
		Progress QUIT ($progressId)
	End if 
End if 

$0:=$t_error