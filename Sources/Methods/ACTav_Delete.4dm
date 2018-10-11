//%attributes = {}
  //ACTav_Delete

_O_C_INTEGER:C282($r;$0)

If (USR_checkRights ("D";->[ACT_Avisos_de_Cobranza:124]))
	$recNumAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ ONLY:C145([ACT_Cargos:173])
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	ARRAY REAL:C219(arACT_MontoPagado;0)
	SELECTION TO ARRAY:C260([ACT_Cargos:173]MontosPagados:8;arACT_MontoPagado)
	$montoPagado:=(AT_GetSumArray (->arACT_MontoPagado))*-1
	SET QUERY LIMIT:C395(1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$trans)
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;*)
	QUERY:C277([ACT_Transacciones:178]; & [ACT_Transacciones:178]No_Boleta:9#0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY LIMIT:C395(0)
	UNLOAD RECORD:C212([ACT_Cargos:173])
	UNLOAD RECORD:C212([ACT_Documentos_de_Cargo:174])
	
	  // 20111025 RCH Cuando no habia pagare asociado no se podian eliminar los avisos.
	  //$vl_idEstadoPagare:=KRL_GetNumericFieldData (->[ACT_Pagares]ID;->[ACT_Avisos_de_Cobranza]ID_Pagare;->[ACT_Pagares]ID_Estado)
	
	  //If ([ACT_Pagares]ID_Estado#0)
	If ([ACT_Avisos_de_Cobranza:124]ID_Pagare:30#0)  //20170725 RCH Se cambia campo ya que nunca se buscaba el registro de pagare
		$vl_idEstadoPagare:=KRL_GetNumericFieldData (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]ID_Estado:6)
	Else 
		$vl_idEstadoPagare:=-102
	End if 
	If (($montoPagado=0) & ($trans=0) & ($vl_idEstadoPagare=-102))
		$abort:=False:C215
		$r:=CD_Dlog (0;__ ("El registro será eliminado definitivamente sin ninguna verificación adicional.\r¿Desea realmente eliminar el registro?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			START TRANSACTION:C239
			vb_CondonaAviso:=True:C214
			$continue:=ACTcfg_OpcionesCondonacion ("Interfaz")
			ACTcc_OpcionesCalculoCtaCte ("InitArrays")
			If ($continue)
				
				$abort:=ACTac_Delete ($recNumAviso)
				
				If ($abort)
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("En este momento existen registros en uso. El aviso no puede ser eliminado."))
				Else 
					VALIDATE TRANSACTION:C240
					$0:=1
					ACTac_RecalculaAvisos ("RecalculaAviso")
					<>vb_refresh:=True:C214
				End if 
			Else 
				CANCEL TRANSACTION:C241
				$vt_dlog:=""
				ACTcfg_OpcionesCondonacion ("RetornaDlogNoContinuar";->$vt_dlog)
				CD_Dlog (0;$vt_dlog)
			End if 
			$vb_mostrarTermo:=True:C214
			ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrarTermo)
			ACTcfg_OpcionesCondonacion ("InitVars")
		End if 
		KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
		KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])
	Else 
		If ([ACT_Avisos_de_Cobranza:124]ID_Pagare:30=0)
			If ($montoPagado>0)
				CD_Dlog (0;__ ("El aviso ya ha sido pagado. Para eliminarlo debe primero eliminar los pagos correspondientes."))
			Else 
				CD_Dlog (0;__ ("El aviso está incluido en un Documento Tributario. Para eliminar el aviso debe primero anular el Documento Tributario asociado."))
			End if 
		Else 
			CD_Dlog (0;__ ("El aviso está asociado a un pagaré vigente. Para eliminar el aviso debe primero anular el pagaré número: ")+String:C10(KRL_GetNumericFieldData (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]Numero_Pagare:11))+".")
		End if 
	End if 
	KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$recNumAviso;True:C214)
Else 
	USR_ALERT_UserHasNoRights (3)
End if 