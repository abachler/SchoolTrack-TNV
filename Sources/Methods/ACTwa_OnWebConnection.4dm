//%attributes = {}
  //ACTwa_OnWebConnection

C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_TEXT:C284($url;$http;$ipAddressClient;$ipAddressServer;$userName;$password)
C_LONGINT:C283(vl_STWAloginResult)
  //MONO 14-06-18 Ticket 209441 
  //<>lUSR_CurrentUserID:=0//20181008 RCH Ticket 217734
  //<>tUSR_CurrentUser:=""

  //para log
C_TEXT:C284($vsBWR_CurrentModule;vsBWR_CurrentModule)
$vsBWR_CurrentModule:=vsBWR_CurrentModule
vsBWR_CurrentModule:="AccountTrack"

  //localhost/actwa/ajax/deudaApdo
$url:=$1
$http:=$2
$ipAddressClient:=$3
$ipAddressServer:=$4
$userName:=$5
$password:=$6

$vtWEB_Host:=WEB_GetHTTPHeaderField ("Host")
$vtWEB_HTTPHost:="http://"+$vtWEB_Host

If (($url="actwa@") | ($url="/actwa@"))
	If (($url="/actwa/ajax/@") | ($url="actwa/ajax/@"))  //ajax solicitando datos...
		If ($url[[1]]="/")
			$action:=ST_GetWord ($url;4;"/")
		Else 
			$action:=ST_GetWord ($url;3;"/")
		End if 
		
		C_LONGINT:C283($l_dia;$l_mes;$l_year)
		C_REAL:C285($r_fdp)
		
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
		  //$uuid:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"UUID")
		Case of 
			: ($action="deudaApdo")
				C_TEXT:C284($t_tipo;$t_fecha)
				C_LONGINT:C283($l_id)
				
				$t_tipo:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"tipo")
				$l_id:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"id"))
				$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$r_fdp:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"formadepago"))  //20151224 RCH
				
				$d_fecha:=ACTwp_ObtieneFechaDesdeString ($t_fecha)
				
				  //log de consulta para tracear...
				  //LOG_RegisterEvt ("Solicitud de deuda Webpay. Datos de consulta: ID Apoderado: "+String($l_id)+", fecha: "+String($d_fecha)+".")
				ACTwa_RegistraLog ("Solicitud de deuda Webpay. Datos de consulta: ID Apoderado: "+String:C10($l_id)+", fecha: "+String:C10($d_fecha)+".")  //20181008 RCH Ticket 217734
				FLUSH CACHE:C297
				
				$json:=ACTwa_RetornaDeudaApdo ($t_tipo;$l_id;$d_fecha;$r_fdp)
				
			: ($action="pago")
				
				C_TEXT:C284($t_ids;$t_fecha;$t_llave;$t_Ordencompra)
				C_DATE:C307($d_fechaPago)
				C_REAL:C285($r_montoPago)
				$t_ids:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"ids")
				$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
				$r_montoPago:=Num:C11(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"monto"))
				$t_jsonConDatos:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"json")
				  //orden de compra ticket 160026 
				$t_Ordencompra:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"oc")
				
				$d_fecha:=ACTwp_ObtieneFechaDesdeString ($t_fecha)
				
				  //log de consulta para tracear...
				  //LOG_RegisterEvt ("Solicitud de ingreso de pago Webpay. Datos: "+$t_ids+"; "+String($d_fecha)+", "+$t_llave+", "+String($r_montoPago)+".")
				  //LOG_RegisterEvt ("Solicitud de ingreso de pago Webpay. Datos: "+$t_ids+"; "+String($d_fecha)+", "+$t_llave+", "+String($r_montoPago)+", json: "+$t_jsonConDatos+".")  //20180612 RCH Ticket 207562
				ACTwa_RegistraLog ("Solicitud de ingreso de pago Webpay. Datos: "+$t_ids+"; "+String:C10($d_fecha)+", "+$t_llave+", "+String:C10($r_montoPago)+", json: "+$t_jsonConDatos+".")  //20181008 RCH Ticket 217734
				FLUSH CACHE:C297
				
				  //$json:=ACTwa_IngresaPago ($r_montoPago;$t_ids;$d_fecha;$t_llave)
				  //$json:=ACTwa_IngresaPago ($r_montoPago;$t_ids;$d_fecha;$t_llave;True;"";$t_jsonConDatos)
				  //orden de compra ticket 160026 JVP
				$json:=ACTwa_IngresaPago ($r_montoPago;$t_ids;$d_fecha;$t_llave;True:C214;"";$t_jsonConDatos;0;$t_Ordencompra)
				
			: ($action="revisaPagos")  //revisa pagos para fecha
				C_DATE:C307($d_fechaPago)
				C_TEXT:C284($t_fecha;$t_llave)
				C_BOOLEAN:C305($b_ejecutado)
				
				$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
				$d_fecha:=ACTwp_ObtieneFechaDesdeString ($t_fecha)
				
				If ($t_llave=ACTwp_GeneraKey ($t_fecha))
					$b_ejecutado:=ACTwp_RevisaPagosXDia ($d_fecha;False:C215)
					If ($b_ejecutado)
						$json:=ACTwa_RespuestaError (0)
					Else 
						$json:=ACTwa_RespuestaError (-11)
					End if 
				Else 
					$json:=ACTwa_RespuestaError (-13)
				End if 
				
			: ($action="enviaMail")  //envia mail resumen
				C_DATE:C307($d_fechaPago)
				C_TEXT:C284($t_fecha;$t_llave)
				C_BOOLEAN:C305($b_ejecutado)
				
				$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
				$d_fecha:=ACTwp_ObtieneFechaDesdeString ($t_fecha)
				
				If ($t_llave=ACTwp_GeneraKey ($t_fecha))
					$b_ejecutado:=ACTwp_EnviaResumenXDia ($d_fecha)
					If ($b_ejecutado)
						$json:=ACTwa_RespuestaError (0)
					Else 
						$json:=ACTwa_RespuestaError (-12)
					End if 
				Else 
					$json:=ACTwa_RespuestaError (-13)
				End if 
				
			: ($action="retornaInfo1")  //retorna json con pagos webpay
				C_DATE:C307($d_fechaPago1;$d_fechaPago2)
				C_TEXT:C284($t_fecha1;$t_llave;$t_fecha2)
				C_BOOLEAN:C305($b_ejecutado)
				
				$t_fecha1:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha1")
				$t_fecha2:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha2")
				$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
				$d_fecha1:=ACTwp_ObtieneFechaDesdeString ($t_fecha1)
				$d_fecha2:=ACTwp_ObtieneFechaDesdeString ($t_fecha2)
				
				If ($t_llave=ACTwp_GeneraKey ($t_fecha1))
					$json:=ACTwp_GeneraJSONPagos ($d_fecha1;$d_fecha2)
				Else 
					$json:=ACTwa_RespuestaError (-13)
				End if 
				
			: ($action="deudaAlumnos")
				C_TEXT:C284($t_uuids)
				C_TEXT:C284($t_fecha)
				C_DATE:C307($d_fecha)
				
				$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$t_uuids:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"uuids")
				$d_fecha:=ACTwp_ObtieneFechaDesdeString ($t_fecha)
				
				$json:=ACTwa_ConsultaDeudaUUIDAl ($t_uuids;$d_fecha)
				
			: ($action="pagoBancomer")  //20141006
				TRACE:C157
				C_TEXT:C284($t_ids;$t_fecha;$t_llave;$t_monto2)
				C_DATE:C307($d_fechaPago)
				C_REAL:C285($r_montoPago;$r_fdp)
				C_TEXT:C284($t_referencia;$t_jsonConDatos;$t_ordenCompra;$t_monto)
				$t_ids:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"ids")
				$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
				$t_monto:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"monto")
				$t_monto2:=Replace string:C233($t_monto;".";"")
				$t_monto2:=Replace string:C233($t_monto2;",";"")
				$r_montoPago:=Num:C11(Substring:C12($t_monto2;1;Length:C16($t_monto2)-2)+<>tXS_RS_DecimalSeparator+Substring:C12($t_monto2;Length:C16($t_monto2)-1;Length:C16($t_monto)))
				$t_referencia:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"referencia")
				$t_jsonConDatos:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"json")
				$t_ordenCompra:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"ordencompra")
				
				$d_fecha:=ACTwp_ObtieneFechaDesdeString ($t_fecha)
				$r_fdp:=-19  //Pago web
				
				$json:=ACTwa_IngresaPago ($r_montoPago;$t_ids;$d_fecha;$t_llave;True:C214;$t_referencia;$t_jsonConDatos;$r_fdp;$t_ordenCompra;$t_monto)
				
			: ($action="resumenPagosBancomer")  //20141006
				  //: ($action="pagoBanorte")  //20150119 ASM
				C_DATE:C307($d_fecha1;$d_fecha2)
				C_TEXT:C284($t_fecha1;$t_fecha2)
				
				$t_fecha1:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$t_fecha2:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha2")
				
				$d_fecha1:=ACTwp_ObtieneFechaDesdeString ($t_fecha1)
				If ($t_fecha2#"")
					$d_fecha2:=ACTwp_ObtieneFechaDesdeString ($t_fecha2)
				End if 
				
				$json:=ACTpw_BancomerResumen ($d_fecha1;$d_fecha2)
				
			: ($action="pagoBanorte")  //20150119 ASM
				
				C_TEXT:C284($t_ids;$t_fecha;$t_llave;$t_monto2)
				C_DATE:C307($d_fechaPago)
				C_REAL:C285($r_montoPago;$r_fdp)
				C_TEXT:C284($t_referencia;$t_jsonConDatos;$t_ordenCompra;$t_monto)
				$t_ids:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"ids")
				$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
				$t_monto:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"monto")
				$t_monto2:=Replace string:C233($t_monto;".";"")
				$t_monto2:=Replace string:C233($t_monto2;",";"")
				$r_montoPago:=Num:C11(Substring:C12($t_monto2;1;Length:C16($t_monto2)-2)+<>tXS_RS_DecimalSeparator+Substring:C12($t_monto2;Length:C16($t_monto2)-1;Length:C16($t_monto)))
				$t_referencia:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"referencia")
				$t_jsonConDatos:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"json")
				$t_ordenCompra:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"ordencompra")
				
				$d_fecha:=ACTwp_ObtieneFechaDesdeString ($t_fecha)
				$r_fdp:=-20  //Pago web
				
				$json:=ACTwa_IngresaPago ($r_montoPago;$t_ids;$d_fecha;$t_llave;True:C214;$t_referencia;$t_jsonConDatos;$r_fdp;$t_ordenCompra;$t_monto)
				
			: ($action="pagoservipag")  ///20170608 RCH
				
				C_TEXT:C284($t_ids;$t_fecha;$t_llave;$t_Ordencompra;$t_jsonConDatos)
				C_DATE:C307($d_fechaPago)
				C_REAL:C285($r_montoPago)
				$t_ids:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"ids")
				$t_fecha:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"fecha")
				$t_llave:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
				$t_monto:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"monto")
				$t_monto2:=Replace string:C233($t_monto;".";"")
				$t_monto2:=Replace string:C233($t_monto2;",";"")
				$r_montoPago:=Num:C11(Substring:C12($t_monto2;1;Length:C16($t_monto2)-2)+<>tXS_RS_DecimalSeparator+Substring:C12($t_monto2;Length:C16($t_monto2)-1;Length:C16($t_monto)))
				$t_jsonConDatos:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"json")
				$t_Ordencompra:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"ordencompra")
				
				$d_fecha:=ACTwp_ObtieneFechaDesdeString ($t_fecha)
				
				  //log de consulta para tracear...
				  //LOG_RegisterEvt ("Solicitud de ingreso de pago Servipag. Datos: "+$t_ids+"; "+String($d_fecha)+", "+$t_llave+", "+String($r_montoPago)+", "+$t_Ordencompra+".")
				ACTwa_RegistraLog ("Solicitud de ingreso de pago Servipag. Datos: "+$t_ids+"; "+String:C10($d_fecha)+", "+$t_llave+", "+String:C10($r_montoPago)+", "+$t_Ordencompra+".")  //20181008 RCH Ticket 217734
				FLUSH CACHE:C297
				$r_fdp:=-21  //Servipag
				$json:=ACTwa_IngresaPago ($r_montoPago;$t_ids;$d_fecha;$t_llave;True:C214;$t_referencia;$t_jsonConDatos;$r_fdp;$t_ordenCompra;$t_monto)
				
				
				
			Else 
				  //devolver json con error... Pagina no procesada
				
				  //log de consulta para tracear...
				  //LOG_RegisterEvt ("Solicitud de página WEB no existe")
				ACTwa_RegistraLog ("Solicitud de página WEB no existe")  //20181008 RCH Ticket 217734
				FLUSH CACHE:C297
				
				$json:=ACTwa_RespuestaError (-1)
		End case 
		
		C_BLOB:C604($blob)
		TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
		WEB SEND RAW DATA:C815($blob;*)
		
	End if 
End if 

vsBWR_CurrentModule:=$vsBWR_CurrentModule