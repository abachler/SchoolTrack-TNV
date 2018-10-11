//%attributes = {}
  //DASHwa_OnWebConnection

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

If (($url="dashboard@") | ($url="/dashboard@"))
	If ($url[[1]]="/")
		$action:=ST_GetWord ($url;3;"/")
	Else 
		$action:=ST_GetWord ($url;2;"/")
	End if 
	LOG_RegisterEvt ("Llamado servicio REST dashboard "+$action+".")
	
	ARRAY TEXT:C222($aParameterNames;0)
	ARRAY TEXT:C222($aParameterValues;0)
	$b_done:=WEB_GetVariables ($url;->$aParameterNames;->$aParameterValues)
	
	If ($b_done)
		
		  //20170407 RCH
		C_TEXT:C284($t_llave;$t_fecha;$t_uuid)
		$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
		$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
		$t_uuid:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"uuid")
		
		If (DASHwa_VerificaLlave ($t_fecha;$t_uuid;$t_llave))
			SYS_SetFormatResources 
			Case of 
				: ($action="detallexforma")
					$year:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"year"))
					$mes:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"mes"))
					$orden:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"orden"))
					$forma:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"forma")
					  //$mes:=$mes+1
					If (($year#0) & ($mes#0))
						$json:=DASH_GeneraJSON ($action;->$year;->$mes;->$orden;->$forma)
					Else 
						$json:=DASHwa_RespuestaError (-4)
					End if 
					
				: ($action="observacionesapdo")
					$idapdo:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"id"))
					If ($idapdo#0)
						$json:=DASH_GeneraJSON ($action;->$idapdo)
					Else 
						$json:=DASHwa_RespuestaError (-4)
					End if 
					
				: ($action="saldoxmes")
					$year:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"year"))
					$mes:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"mes"))
					$orden:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"orden"))
					  //$mes:=$mes+1
					If (($year#0) & ($mes#0))
						$json:=DASH_GeneraJSON ($action;->$year;->$mes;->$orden)
					Else 
						$json:=DASHwa_RespuestaError (-4)
					End if 
					
				: ($action="formadepagoxmes")
					$year:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"year"))
					$mes:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"mes"))
					  //$mes:=$mes+1
					If (($year#0) & ($mes#0))
						$json:=DASH_GeneraJSON ($action;->$year;->$mes)
					Else 
						$json:=DASHwa_RespuestaError (-4)
					End if 
					
				: ($action="dashboard")
					$year:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"year"))
					If ($year#0)
						$json:=DASH_GeneraJSON ($action;->$year)
					Else 
						$json:=DASHwa_RespuestaError (-4)
					End if 
					
				: ($action="calificacionesdashboard")  //20170314 RCH
					$json:=STWA2_Dash_Calificaciones (->$aParameterNames;->$aParameterValues)
					
				: ($action="calificacionespromediosnivel")  //20170314 RCH
					$json:=STWA2_Dash_Calificaciones (->$aParameterNames;->$aParameterValues)
					
				: ($action="calificacionespromedioscurso")  //20170314 RCH
					$json:=STWA2_Dash_Calificaciones (->$aParameterNames;->$aParameterValues)
					
				: ($action="calificacionespromediosasignaturasxalumno")  //20170314 RCH
					$json:=STWA2_Dash_Calificaciones (->$aParameterNames;->$aParameterValues)
					
				: ($action="calificacionespromediosasignatura")  //20170314 RCH
					$json:=STWA2_Dash_Calificaciones (->$aParameterNames;->$aParameterValues)
					
				: ($action="calificacionespromediosalumnosxasignatura")  //20170314 RCH
					$json:=STWA2_Dash_Calificaciones (->$aParameterNames;->$aParameterValues)
					
				Else 
					$json:=DASHwa_RespuestaError (-3)
			End case 
			
		Else 
			$json:=DASHwa_RespuestaError (-2)
		End if 
	Else 
		$json:=DASHwa_RespuestaError (-1)
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