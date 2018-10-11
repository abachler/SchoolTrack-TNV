//%attributes = {}
  //XCRwa_OnWebConnection

C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_TEXT:C284($url;$http;$ipAddressClient;$ipAddressServer;$userName;$password)
C_LONGINT:C283(vl_STWAloginResult)
C_TEXT:C284(t_respuestaJSON;t_script;$json)

  //localhost/xcrwa/ajax/crea_cargo_xcr
$url:=$1
$http:=$2

  //SET TEXT TO PASTEBOARD($http)

$ipAddressClient:=$3
$ipAddressServer:=$4
$userName:=$5
$password:=$6

$vtWEB_Host:=WEB_GetHTTPHeaderField ("Host")
$vtWEB_HTTPHost:="http://"+$vtWEB_Host

If (($url="xcrwa@") | ($url="/xcrwa@"))
	If (($url="/xcrwa/ajax/@") | ($url="xcrwa/ajax/@"))  //ajax solicitando datos...
		If ($url[[1]]="/")
			$action:=ST_GetWord ($url;4;"/")
		Else 
			$action:=ST_GetWord ($url;3;"/")
		End if 
		
		LOG_RegisterEvt ("Llamado XCRwa"+$action+".")
		
		ARRAY TEXT:C222($aParameterNames;0)
		ARRAY TEXT:C222($aParameterValues;0)
		$b_done:=WEB_GetVariables ($url;->$aParameterNames;->$aParameterValues)
		
		If ($b_done)
			Case of 
				: ($action="crea_pago_xcr")
					If (Size of array:C274($aParameterNames)>0)
						t_respuestaJSON:=""
						$json:=XCRwa_CreaPago ($aParameterNames{1})
					Else 
						$json:=XCRwa_RespuestaError (-4)
					End if 
				Else 
					$json:=XCRwa_RespuestaError (-2)
			End case 
		Else 
			$json:=XCRwa_RespuestaError (-1)
		End if 
		
		C_BLOB:C604($blob)
		TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
		  //WEB SEND RAW DATA($blob;*)
		  //
		ARRAY TEXT:C222($hNames;0)
		ARRAY TEXT:C222($hValues;0)
		APPEND TO ARRAY:C911($hNames;"Content-Type")
		APPEND TO ARRAY:C911($hValues;"application/json;charset=utf-8")
		APPEND TO ARRAY:C911($hNames;"Accept")
		APPEND TO ARRAY:C911($hValues;"application/json")
		WEB SET HTTP HEADER:C660($hNames;$hValues)
		WEB SEND RAW DATA:C815($blob;*)
		  //WEB SEND BLOB($blob;"application/json")
		
	End if 
End if 
