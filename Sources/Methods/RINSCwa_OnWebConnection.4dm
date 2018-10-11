//%attributes = {}
  //RINSCwa_OnWebConnection

C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_TEXT:C284($url;$http;$ipAddressClient;$ipAddressServer;$userName;$password)
C_LONGINT:C283(vl_STWAloginResult)
C_TEXT:C284(t_script;$json)

  //http://172.16.0.35:8081/rinscwa/ajax/consulta_items
$url:=$1
$http:=$2

$ipAddressClient:=$3
$ipAddressServer:=$4
$userName:=$5
$password:=$6

$vtWEB_Host:=WEB_GetHTTPHeaderField ("Host")
$vtWEB_HTTPHost:="http://"+$vtWEB_Host

If (($url="rinscwa@") | ($url="/rinscwa@"))
	If (($url="/rinscwa/ajax/@") | ($url="rinscwa/ajax/@"))  //ajax solicitando datos...
		If ($url[[1]]="/")
			$action:=ST_GetWord ($url;4;"/")
		Else 
			$action:=ST_GetWord ($url;3;"/")
		End if 
		<>tUSR_CurrentUser:="Reinscripciones"  //20151209 RCH Para que no quede en Log cualquier usuario.
		LOG_RegisterEvt ("Llamado RINSCwa"+$action+".")
		
		ARRAY TEXT:C222($aParameterNames;0)
		ARRAY TEXT:C222($aParameterValues;0)
		$b_done:=WEB_GetVariables ($url;->$aParameterNames;->$aParameterValues)
		
		If ($b_done)
			Case of 
				: ($action="consulta_items")
					  //http://172.16.0.35:8081/rinscwa/ajax/consulta_items
					If (Size of array:C274($aParameterNames)>0)
						$json:=RINSCwa_EnviaCargos ($aParameterNames{1})
					Else 
						$json:=RINSCwa_RespuestaError (-14)
					End if 
					
				: ($action="consulta_cargos")
					  //http://172.16.0.35:8081/rinscwa/ajax/consulta_cargos
					If (Size of array:C274($aParameterNames)>0)
						$json:=RINSCwa_ProcesaSolititud ($aParameterNames{1})
					Else 
						$json:=RINSCwa_RespuestaError (-14)
					End if 
					
				: ($action="genera_avisos")
					  //http://172.16.0.35:8081/rinscwa/ajax/genera_avisos
					If (Size of array:C274($aParameterNames)>0)
						$json:=RINSCwa_GeneraAvisos ($aParameterNames{1})
					Else 
						$json:=RINSCwa_RespuestaError (-14)
					End if 
					
				Else 
					$json:=RINSCwa_RespuestaError (-13)
			End case 
		Else 
			$json:=RINSCwa_RespuestaError (-12)
		End if 
		
		<>tUSR_CurrentUser:=""  //20151209 RCH Para limpiar
		
		C_BLOB:C604($blob)
		TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
		ARRAY TEXT:C222($hNames;0)
		ARRAY TEXT:C222($hValues;0)
		APPEND TO ARRAY:C911($hNames;"Content-Type")
		APPEND TO ARRAY:C911($hValues;"application/json;charset=utf-8")
		APPEND TO ARRAY:C911($hNames;"Accept")
		APPEND TO ARRAY:C911($hValues;"application/json")
		WEB SET HTTP HEADER:C660($hNames;$hValues)
		WEB SEND RAW DATA:C815($blob;*)
	End if 
End if 
