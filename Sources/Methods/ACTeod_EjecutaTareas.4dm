//%attributes = {}
  //ACTeod_EjecutaTareas

C_TEXT:C284($1;$vt_accion;$0;$vt_retorno)
C_POINTER:C301($vy_pointer1;$vy_pointer2)
C_POINTER:C301(${2})

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="")
		If (ACT_AccountTrackInicializado )
			ACTeod_EjecutaTareas ("InicioTareas")
			
			ACTmon_ValidaTablaUF 
			ACTbw_EstadoDocsenCartera 
			LOG_RegisterEvt ("Recálculo de estado de documentos en cartera terminado.")
			FLUSH CACHE:C297
			ACTbw_OrderCtasCtes 
			LOG_RegisterEvt ("Ordenamiento de cuentas corrientes terminado.")
			FLUSH CACHE:C297
			ACTbw_CalculaCargas 
			LOG_RegisterEvt ("Cálculo de cargas por apoderado terminado.")
			FLUSH CACHE:C297
			
			$vd_fecha:=Current date:C33(*)
			  //ACTcfg_OpcionesRecargosAut ("RecalculoMultasFinDeDia";->$vd_fecha)
			  //LOG_RegisterEvt ("Verificación de recargos automáticos para avisos morosos terminado.")
			  //FLUSH BUFFERS
			
			ACTitems_OpcionesRecalculoTramo ("CalculaMontosTareasFinDeDia";->$vd_fecha)
			LOG_RegisterEvt ("Verificación de tramos de ítems terminada.")
			FLUSH CACHE:C297
			
			  //ACTcfg_OpcionesRecargosAut ("RecalculoMultasFinDeDia";->$vd_fecha)
			  //LOG_RegisterEvt ("Verificación de recargos automáticos para avisos morosos terminado.")
			  //FLUSH BUFFERS
			
			If (Num:C11(PREF_fGet (0;"ACT_EOD_Dctos";"1"))=1)
				ACTcfg_OpcionesEliminacionDctos ("VerificaEliminacionDctosFinDeDia";->$vd_fecha)
				LOG_RegisterEvt ("Verificación de eliminación de Descuentos por cuenta y/o cargas terminada.")
				FLUSH CACHE:C297
			End if 
			
			  //20140317 RCH Se calculan los recargos automaticos despues de eliminar descuentos
			ACTcfg_OpcionesRecargosAut ("RecalculoMultasFinDeDia";->$vd_fecha)
			LOG_RegisterEvt ("Verificación de recargos automáticos para avisos morosos terminado.")
			FLUSH CACHE:C297
			
			  //20140510 Recargos automaticos por tabla
			ACTrat_OpcionesCalculos ("RecalculoMultasFinDeDia";->$vd_fecha)
			LOG_RegisterEvt ("Verificación de recargos automáticos por tramo para avisos morosos terminado.")
			FLUSH CACHE:C297
			
			ACTcfg_OpcionesTareasFinDia ("EjecutaTareasInicioDia")
			LOG_RegisterEvt ("Tareas de inicio de día AccountTrack (opciones) terminada.")
			FLUSH CACHE:C297
			dbuACT_VerificaAvisosPagados 
			LOG_RegisterEvt ("Verificación de Avisos de Cobranza terminada.")
			FLUSH CACHE:C297
			  //20120327 RCH No se estaban recalculando los avisos...
			ACTeod_RecalculaSaldoAnteriorAC 
			LOG_RegisterEvt ("Recálculo de Avisos de Cobranza terminado.")
			FLUSH CACHE:C297
			
			  //20131022 RCH Verifica nombre en AC
			ACTac_ActualizaNombre ("NombreRelacionadoVacio")
			LOG_RegisterEvt ("Validación de nombre relacionado en Avisos de Cobranza.")
			FLUSH CACHE:C297
			
			  //20131129 RCH Alertas
			ACTdte_Alertas 
			LOG_RegisterEvt ("Verificaciones DTE realizadas.")
			FLUSH CACHE:C297
			
			  //verifica pagos WP
			If (ACTwp_RevisaPagos )
				LOG_RegisterEvt ("Verificacion pagos Webpay realizada.")
				FLUSH CACHE:C297
			End if 
			
			If (ACTwp_EnviaResumen )
				LOG_RegisterEvt ("Envío resumen pagos Webpay realizado.")
				FLUSH CACHE:C297
			End if 
			
			  //20150320 RCH
			If (ACTpw_RevisaPagos (False:C215))
				LOG_RegisterEvt ("PAGOSWEB: Solicitud de proceso de pagos pendientes realizada.")
			Else 
				LOG_RegisterEvt ("PAGOSWEB: Error en solicitud de proceso de pagos pendientes.")
			End if 
			FLUSH CACHE:C297
			
			ACTeod_EjecutaTareas ("FinTareas")
			
		End if 
		
	: ($vt_accion="InicioTareas")
		ARRAY LONGINT:C221(alACTeod_idsApdos;0)
		ARRAY LONGINT:C221(alACTeod_idsTerceros;0)
		ACTeod_EjecutaTareas ("DeclaraVar")
		<>vbACTeod_Ejecutando:=True:C214
		LOG_RegisterEvt ("Inicio tareas AccountTrack.")
		FLUSH CACHE:C297
		
	: ($vt_accion="DeclaraVar")
		C_BOOLEAN:C305(<>vbACTeod_Ejecutando)
		
	: ($vt_accion="FinTareas")
		C_BOOLEAN:C305($vb_mostrar)
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		$vb_mostrar:=True:C214
		COPY ARRAY:C226(alACTeod_idsApdos;alACTpp_idsPersonas)
		COPY ARRAY:C226(alACTeod_idsTerceros;alACTter_idsTerceros)
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrar)
		
		<>vbACTeod_Ejecutando:=False:C215
		AT_Initialize (->alACTeod_idsApdos;->alACTeod_idsTerceros)
		
		LOG_RegisterEvt ("Fin tareas AccountTrack.")
		FLUSH CACHE:C297
		
	: ($vt_accion="TareasEjecutando")
		ACTeod_EjecutaTareas ("DeclaraVar")
		If (<>vbACTeod_Ejecutando)
			$vt_retorno:="1"
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="AgregaElemento")
		If (Num:C11(ACTeod_EjecutaTareas ("TareasEjecutando"))=1)
			If ($vy_pointer1->#0)
				If (Find in array:C230(alACTeod_idsApdos;$vy_pointer1->)=-1)
					APPEND TO ARRAY:C911(alACTeod_idsApdos;$vy_pointer1->)
				End if 
			End if 
			If ($vy_pointer2->#0)
				If (Find in array:C230(alACTeod_idsTerceros;$vy_pointer2->)=-1)
					APPEND TO ARRAY:C911(alACTeod_idsTerceros;$vy_pointer2->)
				End if 
			End if 
		End if 
		
End case 

$0:=$vt_retorno