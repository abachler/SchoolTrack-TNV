//%attributes = {}
  // ACT_TareasInicioDiario()
  // Por: Alberto Bachler K.: 29-08-14, 09:39:37
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_BOOLEAN:C305($vb_mostrar)
C_DATE:C307($d_fechaHoy)
C_LONGINT:C283($l_ms)
C_POINTER:C301($y_accion;$y_parametro;$y_parametro1;$y_parametro2)
C_TEXT:C284($t_accion;$t_entradaLog;$t_retorno)


If (False:C215)
	C_TEXT:C284(ACT_TareasInicioDiario ;$0)
	C_TEXT:C284(ACT_TareasInicioDiario ;$1)
	C_POINTER:C301(ACT_TareasInicioDiario ;${2})
End if 

If (Count parameters:C259>=1)
	$t_accion:=$1
End if 
If (Count parameters:C259>=2)
	$y_parametro1:=$2
End if 
If (Count parameters:C259>=3)
	$y_parametro2:=$3
End if 

Case of 
	: ($t_accion="")
		If (ACT_AccountTrackInicializado )
			
			$d_fechaHoy:=Current date:C33(*)
			$y_parametro:=->$d_fechaHoy
			
			$t_accion:="InicioTareas"
			dhBM_EjecutaTarea ("ACT_TareasInicioDiario";"AccountTrack: Inicializaciones de tareas de inicio diario";->$t_accion)
			
			dhBM_EjecutaTarea ("ACTmon_ValidaTablaUF";"AccountTrack: Validación tabla UF")
			
			dhBM_EjecutaTarea ("ACTbw_EstadoDocsenCartera";"AccountTrack: Recálculo de estado de documentos en cartera")
			
			dhBM_EjecutaTarea ("ACTbw_OrderCtasCtes";"AccountTrack: Ordenamiento de cuentas corrientes")
			
			dhBM_EjecutaTarea ("ACTbw_CalculaCargas";"AccountTrack: Cálculo de cargas por apoderado terminado")
			
			
			  //ACTcfg_OpcionesRecargosAut ("RecalculoMultasFinDeDia";->$vd_fecha)
			  //LOG_RegisterEvt ("Verificación de recargos automáticos para avisos morosos terminado.")
			  //FLUSH BUFFERS
			
			$t_accion:="CalculaMontosTareasFinDeDia"
			$y_accion:=->$t_accion
			dhBM_EjecutaTarea ("ACTitems_OpcionesRecalculoTramo";"AccountTrack: Verificación de tramos de ítems";$y_accion;->$y_parametro)
			
			
			  //ACTcfg_OpcionesRecargosAut ("RecalculoMultasFinDeDia";->$vd_fecha)
			  //LOG_RegisterEvt ("Verificación de recargos automáticos para avisos morosos terminado.")
			  //FLUSH BUFFERS
			
			If (Num:C11(PREF_fGet (0;"ACT_EOD_Dctos";"1"))=1)
				$t_accion:="VerificaEliminacionDctosFinDeDia"
				dhBM_EjecutaTarea ("ACTcfg_OpcionesEliminacionDctos";"AccountTrack: Verificación de eliminación de Descuentos por cuenta y/o cargas";$y_accion;->$y_parametro)
			End if 
			
			  //20140317 RCH Se calculan los recargos automaticos despues de eliminar descuentos
			$t_accion:="RecalculoMultasFinDeDia"
			dhBM_EjecutaTarea ("ACTcfg_OpcionesRecargosAut";"AccountTrack: Verificación de recargos automáticos para avisos morosos";$y_accion;->$y_parametro)
			
			  //20140510 Recargos automaticos por tabla
			$t_accion:="RecalculoMultasFinDeDia"
			dhBM_EjecutaTarea ("ACTrat_OpcionesCalculos";"AccountTrack: Verificación de recargos automáticos por tramo para avisos morosos";$y_accion;->$y_parametro)
			
			
			$t_accion:="EjecutaTareasInicioDia"
			dhBM_EjecutaTarea ("ACTcfg_OpcionesTareasFinDia";"AccountTrack: Tareas de inicio de día para opciones AccountTrack";$y_accion)
			
			dhBM_EjecutaTarea ("dbuACT_VerificaAvisosPagados";"AccountTrack: Verificación de Avisos de Cobranza")
			
			
			  //20120327 RCH No se estaban recalculando los avisos...
			dhBM_EjecutaTarea ("ACTeod_RecalculaSaldoAnteriorAC";"AccountTrack: Recálculo de Avisos de Cobranza")
			
			
			  //20131022 RCH Verifica nombre en AC
			$t_Accion:="NombreRelacionadoVacio"
			dhBM_EjecutaTarea ("ACTac_ActualizaNombre";"AccountTrack: Validación de nombre relacionado en Avisos de Cobranza";$y_accion)
			
			
			  //20131129 RCH Alertas
			dhBM_EjecutaTarea ("ACTdte_Alertas";"AccountTrack: Verificaciones DTE")
			
			  //verifica pagos WP
			$l_ms:=Milliseconds:C459
			$t_entradaLog:=String:C10(Current time:C178(*);HH MM SS:K7:1)+"\t"+"AccountTrack: Verificacion pagos Webpay"
			If (ACTwp_RevisaPagos )
				$t_entradaLog:=$t_entradaLog+": "+String:C10(Milliseconds:C459-$l_ms)+"ms"
				SEND PACKET:C103(vh_refLog;$t_entradaLog+"\r\n")
			End if 
			
			
			$t_entradaLog:=String:C10(Current time:C178(*);HH MM SS:K7:1)+"\t"+"AccountTrack: Envío resumen pagos Webpay"
			If (ACTwp_EnviaResumen )
				$t_entradaLog:=$t_entradaLog+": "+String:C10(Milliseconds:C459-$l_ms)+"ms"
				SEND PACKET:C103(vh_refLog;$t_entradaLog+"\r\n")
			End if 
			
			  //20161207 RCH Asignacion automática matrices de cargo
			dhBM_EjecutaTarea ("ACTtid_AsignacionAutMatrices";"AccountTrack: Verificación asignación automática de Matrices de Cargo ejecutada.")
			
			  // Añadido por: Saúl Ponce (03-01-2017) - Ticket N° 172266
			dhBM_EjecutaTarea ("ACT_ValidaYAsignaFechaMatricula";"AccountTrack: Validación de cargos configurados para matrícula")
			
			$t_accion:="FinTareas"
			dhBM_EjecutaTarea ("ACT_TareasInicioDiario";"AccountTrack: Recalculo de cuentas corrientes";$y_accion)
			
		End if 
		
	: ($t_accion="InicioTareas")
		ARRAY LONGINT:C221(alACTeod_idsApdos;0)
		ARRAY LONGINT:C221(alACTeod_idsTerceros;0)
		ACT_TareasInicioDiario ("DeclaraVar")
		<>vbACTeod_Ejecutando:=True:C214
		
	: ($t_accion="DeclaraVar")
		C_BOOLEAN:C305(<>vbACTeod_Ejecutando)
		
	: ($t_accion="FinTareas")
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		$vb_mostrar:=True:C214
		COPY ARRAY:C226(alACTeod_idsApdos;alACTpp_idsPersonas)
		COPY ARRAY:C226(alACTeod_idsTerceros;alACTter_idsTerceros)
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrar)
		
		<>vbACTeod_Ejecutando:=False:C215
		AT_Initialize (->alACTeod_idsApdos;->alACTeod_idsTerceros)
		
		
	: ($t_accion="TareasEjecutando")
		ACT_TareasInicioDiario ("DeclaraVar")
		If (<>vbACTeod_Ejecutando)
			$t_retorno:="1"
		Else 
			$t_retorno:="0"
		End if 
		
	: ($t_accion="AgregaElemento")
		If (Num:C11(ACT_TareasInicioDiario ("TareasEjecutando"))=1)
			If ($y_parametro1->#0)
				If (Find in array:C230(alACTeod_idsApdos;$y_parametro1->)=-1)
					APPEND TO ARRAY:C911(alACTeod_idsApdos;$y_parametro1->)
				End if 
			End if 
			If ($y_parametro2->#0)
				If (Find in array:C230(alACTeod_idsTerceros;$y_parametro2->)=-1)
					APPEND TO ARRAY:C911(alACTeod_idsTerceros;$y_parametro2->)
				End if 
			End if 
		End if 
End case 

$0:=$t_retorno

