//%attributes = {}
  //ACTpw_RevisaPagos
  //20150209 RCH Webpay

  //metodo para que sea ejecutado en las tareas de fin de dia. es el encargado de revisar que los pagos ingresados sean los que tiene SN.
C_BOOLEAN:C305($0;$vb_ejecutado;$b_mostrarMensaje)
C_TEXT:C284($t_mensaje;$t_msj)
C_TEXT:C284($t_json;$t_node;$t_name)
C_LONGINT:C283($i)

If (<>bXS_esServidorOficial)
	If (ACT_AccountTrackInicializado )
		
		$b_mostrarMensaje:=True:C214
		If (Count parameters:C259>=1)
			$b_mostrarMensaje:=$1
		End if 
		
		$t_json:=ACTpw_RetreivePagosBC 
		
		If ($t_json#"")
			
			C_OBJECT:C1216($ob)
			C_TEXT:C284($t_eror;$t_descripcion)
			
			$ob:=JSON Parse:C1218($t_json)
			$t_eror:=OB Get:C1224($ob;"error";Is text:K8:3)
			$t_descripcion:=OB Get:C1224($ob;"descripcion")
			
			If ($t_eror="0")
				$t_msj:="PAGOSWEB: Solicitud de proceso de pagos pendientes ralizada. "+"\r\r"+$t_descripcion
				If ($b_mostrarMensaje)
					CD_Dlog (0;$t_msj)
				End if 
				LOG_RegisterEvt ($t_msj)
				
				$vb_ejecutado:=True:C214
			Else 
				$t_msj:="PAGOSWEB: Error al solicitar el proceso de pagos pendientes. Error: "+$t_descripcion+"."
				If ($b_mostrarMensaje)
					CD_Dlog (0;$t_msj)
				End if 
				LOG_RegisterEvt ($t_msj)
			End if 
			  //End if   //
		Else 
			$t_msj:="PAGOSWEB: Error al consumir servicio que valida los pagos pendientes. Intente nuevamente más tarde. Si el problema persiste, consulta a soporte."
			If ($b_mostrarMensaje)
				CD_Dlog (0;$t_msj)
			End if 
			LOG_RegisterEvt ($t_msj)
		End if 
		
	End if 
End if 
$0:=$vb_ejecutado
