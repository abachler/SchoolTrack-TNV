//%attributes = {}
  //ADTwa_OnWebConnection

C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_TEXT:C284($url;$http;$ipAddressClient;$ipAddressServer;$userName;$password)
C_LONGINT:C283(vl_STWAloginResult)

  //localhost/adtwa/ajax/matricula_tms
$url:=$1
$http:=$2
$ipAddressClient:=$3
$ipAddressServer:=$4
$userName:=$5
$password:=$6

$vtWEB_Host:=WEB_GetHTTPHeaderField ("Host")
$vtWEB_HTTPHost:="http://"+$vtWEB_Host

If (($url="adtwa@") | ($url="/adtwa@"))
	If (($url="/adtwa/ajax/@") | ($url="adtwa/ajax/@"))  //ajax solicitando datos...
		If ($url[[1]]="/")
			$action:=ST_GetWord ($url;4;"/")
		Else 
			$action:=ST_GetWord ($url;3;"/")
		End if 
		
		C_LONGINT:C283($l_dia;$l_mes;$l_year)
		
		ARRAY TEXT:C222($aHeaderNames;0)
		ARRAY TEXT:C222($aHeaderValues;0)
		WEB GET HTTP HEADER:C697($aHeaderNames;$aHeaderValues)
		
		$method:=NV_GetValueFromPairedArrays (->$aHeaderNames;->$aHeaderValues;"X-METHOD")
		ARRAY TEXT:C222($aParameterNames;0)
		ARRAY TEXT:C222($aParameterValues;0)
		Case of 
			: ($method="GET")
				$parameters:=ST_GetWord ($url;2;"?")
				If ($parameters#"")
					$action:=Substring:C12($action;1;Position:C15("?";$action)-1)
					$countParameters:=ST_CountWords ($parameters;0;"&")
					ARRAY TEXT:C222($aParameterNames;$countParameters)
					ARRAY TEXT:C222($aParameterValues;$countParameters)
					For ($i;1;$countParameters)
						$parameterPair:=ST_GetWord ($parameters;$i;"&")
						$aParameterNames{$i}:=ST_GetWord ($parameterPair;1;"=")
						$aParameterValues{$i}:=ST_GetWord ($parameterPair;2;"=")
					End for 
				End if 
			: ($method="POST")
				WEB GET VARIABLES:C683($aParameterNames;$aParameterValues)
		End case 
		
		C_TEXT:C284(t_respuestaJSON;t_script;$json)
		t_respuestaJSON:=""
		LOG_RegisterEvt ("Llamado ADTwa"+$action+".")
		Case of 
			: ($action="matricula_tms")
				C_TEXT:C284($t_llave;$t_rutsAlumnos;$t_timeStamp;$t_montoPagado)
				$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
				$t_rutsAlumnos:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"cuentas")
				$t_timeStamp:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"timestamp")
				$t_montoPagado:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"monto_total")
				
				If ($t_llave=ADTwa_GeneraLlave ($t_rutsAlumnos;$t_timeStamp;$t_montoPagado))
					ARRAY TEXT:C222(aParameterNames;0)
					ARRAY TEXT:C222(aParameterValues;0)
					COPY ARRAY:C226($aParameterNames;aParameterNames)
					COPY ARRAY:C226($aParameterValues;aParameterValues)
					
					C_TEXT:C284($t_uuidScript2Ejecutar)
					$t_uuidScript2Ejecutar:=PREF_fGet (0;"ADT_ScriptImportaDatos";$t_uuidScript2Ejecutar)
					If ($t_uuidScript2Ejecutar="")
						
					Else 
						READ ONLY:C145([CORP_Scripts:197])
						QUERY:C277([CORP_Scripts:197];[CORP_Scripts:197]Auto_UUID:9=$t_uuidScript2Ejecutar)
						If (Records in selection:C76([CORP_Scripts:197])=1)
							If (False:C215)
								  //_0000_TestsRCH2
							Else 
								t_script:=[CORP_Scripts:197]Script:2
								EXE_Execute ([CORP_Scripts:197]Script:2)
								
								If (False:C215)  //FOOTRUNNER OUT !
									  //FRAppendChecksum (t_script)
									  //$err:=FRRunText (t_script;0)
								End if 
								
								
								  //$err:=EXE_Execute ([CORP_Scripts]Script;False)
								If ($err=0)
									$json:=t_respuestaJSON
								Else 
									$json:=ADTwa_RespuestaError (-18)
								End if 
							End if 
							t_respuestaJSON:=""
						End if 
					End if 
					
				Else 
					$json:=ADTwa_RespuestaError (-2)
				End if 
				
				AT_Initialize (->aParameterNames;->aParameterValues)
				
			: ($action="ejecutaScript")
				TRACE:C157
				C_TEXT:C284($t_uuidScript2Ejecutar)
				$t_uuidScript2Ejecutar:=PREF_fGet (0;"Script_ScriptAEjecutar";$t_uuidScript2Ejecutar)  //20140624 RCH Cambio nombre de preferencia a buscar
				If ($t_uuidScript2Ejecutar="")
					$json:=ADTwa_RespuestaError (-21)
				Else 
					READ ONLY:C145([CORP_Scripts:197])
					QUERY:C277([CORP_Scripts:197];[CORP_Scripts:197]Auto_UUID:9=$t_uuidScript2Ejecutar)
					If (Records in selection:C76([CORP_Scripts:197])=1)
						t_script:=[CORP_Scripts:197]Script:2
						If (False:C215)
							  //_0000_TestsRCH2
						Else 
							
							If (False:C215)  //FOOTRUNNER OUT !
								  //FRAppendChecksum (t_script)
								  //$err:=FRRunText (t_script;0)
							End if 
							EXE_Execute (t_script)
							
							
							
							If ($err=0)
								$json:=t_respuestaJSON
							Else 
								$json:=ADTwa_RespuestaError (-18)
							End if 
							
						End if 
						t_respuestaJSON:=""
					Else 
						$json:=ADTwa_RespuestaError (-19)
					End if 
				End if 
				
			: ($action="admisiones")
				
				If (Size of array:C274($aParameterNames)>0)
					t_respuestaJSON:=""
					$json:=ADTwa_ProcesaSolicitud ($aParameterNames{1})
				Else 
					$json:=ADTwa_RespuestaError (-24)
				End if 
				
			: ($action="importacionAlumnos")
				$json:=ADTwa_PostProcesaSolicitud (->$aParameterNames;->$aParameterValues)
				
			Else 
				$json:=ADTwa_RespuestaError (-1)
		End case 
		
		C_BLOB:C604($blob)
		TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
		WEB SEND RAW DATA:C815($blob;*)
		
	End if 
End if 
