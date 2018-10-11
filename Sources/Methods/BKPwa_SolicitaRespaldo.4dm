//%attributes = {}
  //BKPwa_SolicitaRespaldo
C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_TEXT:C284($url;$http;$ipAddressClient;$ipAddressServer;$userName;$password)
C_TEXT:C284($json)

$url:=$1
$http:=$2

$ipAddressClient:=$3
$ipAddressServer:=$4
$userName:=$5
$password:=$6

$vtWEB_Host:=WEB_GetHTTPHeaderField ("Host")
$vtWEB_HTTPHost:="http://"+$vtWEB_Host

If (($url="bkpwa@") | ($url="/bkpwa@"))
	If ($url[[1]]="/")
		$action:=ST_GetWord ($url;3;"/")
	Else 
		$action:=ST_GetWord ($url;2;"/")
	End if 
	LOG_RegisterEvt ("Llamado servicio REST "+$action+".")
	
	ARRAY TEXT:C222($aParameterNames;0)
	ARRAY TEXT:C222($aParameterValues;0)
	$b_done:=WEB_GetVariables ($url;->$aParameterNames;->$aParameterValues;->$action)
	
	$b_permiteEnvioAut:=(Num:C11(PREF_fGet (0;"PermitirEnvioRespaldosFTP";"1"))=1)
	
	If ($b_done)
		Case of 
			: ($action="solicitaultimobkp")
				If ($b_permiteEnvioAut)
					$json:=BKP_SubeRespaldo 
				Else 
					$json:=BKPwa_GeneraRespuesta (-7)
				End if 
				
			: ($action="solicitabkp")
				If ($b_permiteEnvioAut)
					C_TEXT:C284($t_respaldo)
					$t_respaldo:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"nombrearchivo")
					$json:=BKP_SubeRespaldo ($t_respaldo)
				Else 
					$json:=BKPwa_GeneraRespuesta (-7)
				End if 
				
			: ($action="solicitasiguientebkp")
				If ($b_permiteEnvioAut)
					$json:=BKP_SubeSiguienteRespaldo 
				Else 
					$json:=BKPwa_GeneraRespuesta (-7)
				End if 
				
			: ($action="listabkp")
				$json:=BKP_ListaRespaldos 
				
			: ($action="consultalog")
				$json:=BKP_ConsultaEstadoSolicSubida 
				
			: ($action="consultalogs3")
				$json:=BKPs3_ConsultaLog 
				
			Else 
				$json:=BKPwa_GeneraRespuesta (-2)
		End case 
	Else 
		$json:=BKPwa_GeneraRespuesta (-1)  // Error al obtener parámetros
	End if 
	
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