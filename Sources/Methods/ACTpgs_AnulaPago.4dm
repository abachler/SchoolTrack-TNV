//%attributes = {}
  //ACTpgs_AnulaPago

ACTcc_OpcionesCalculoCtaCte ("InitArrays")
ARRAY LONGINT:C221($aIDApdosPagos;0)
C_LONGINT:C283($vl_recNumPago;$1;$0)
ARRAY LONGINT:C221($al_recNumsAvisos;0)
ARRAY LONGINT:C221($al_idsCtasCtes;0)
C_BOOLEAN:C305($vb_pagoConProblema)
C_LONGINT:C283($tomadosTransacciones;$vl_idEstadoNulo)
C_BOOLEAN:C305($vb_confirmarTrans)
C_BOOLEAN:C305($vb_calculaCtaCte;$2)
C_BOOLEAN:C305($b_cargoNoEliminado)  //20130730 RCH Manejo krl_delete....

$vb_calculaCtaCte:=True:C214
$vl_recNumPago:=$1
If (Count parameters:C259>=2)
	$vb_calculaCtaCte:=$2
End if 


$Abort:=False:C215
$lockedDocdePago:=True:C214
$lockedDocenCartera:=False:C215
$lockedCargos:=False:C215
$lockedDocdeCargo:=False:C215
$lockedPago:=True:C214
$lockedAviso:=False:C215
$b_cargoNoEliminado:=False:C215

If (Not:C34(In transaction:C397))
	START TRANSACTION:C239
	$vb_confirmarTrans:=True:C214
End if 
READ WRITE:C146([ACT_Pagos:172])
READ WRITE:C146([ACT_Documentos_de_Pago:176])
GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
SELECTION TO ARRAY:C260([ACT_Pagos:172]ID_Apoderado:3;$aIDApdosPagos)
LOAD RECORD:C52([ACT_Pagos:172])
$go:=ACTpgs_ValidaEliminacion 
If ($go)
	QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
	$vl_idEstadoNulo:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNulo";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
	If ($vl_idEstadoNulo#0)
		$lockedDocdePago:=Locked:C147([ACT_Documentos_de_Pago:176])
		$vlACT_recNumDocPago:=Record number:C243([ACT_Documentos_de_Pago:176])
		If (Not:C34([ACT_Documentos_de_Pago:176]Depositado:35))
			$idPago:=[ACT_Pagos:172]ID:1
			$vb_pagoConProblema:=ACTcar_ValidaMontos ("ValidaCargosDelPago";->$idPago)
			READ WRITE:C146([ACT_Pagos:172])
			GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
			$b_cargoNoEliminado:=(ACTcar_OpcionesGenerales ("PGS_eliminaDsctosCargosAsociados";->[ACT_Pagos:172]ID:1)="0")
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$idPago)
			AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->$al_idsCtasCtes)
			ARRAY LONGINT:C221($aRecNumTransacciones;0)
			ARRAY LONGINT:C221(aEnBoleta;0)
			SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aRecNumTransacciones;[ACT_Transacciones:178]No_Boleta:9;aEnBoleta)
			$lockedCargos:=ACTpgs_EliminaPagoEnTrans (->$aRecNumTransacciones;->$al_recNumsAvisos)
			READ WRITE:C146([ACT_Documentos_en_Cartera:182])
			If ($vlACT_recNumDocPago#-1)
				GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$vlACT_recNumDocPago)
			End if 
			$DocenCartera:=Find in field:C653([ACT_Documentos_en_Cartera:182]ID_DocdePago:3;[ACT_Documentos_de_Pago:176]ID:1)
			If ($DocenCartera#-1)
				GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$DocenCartera)
				$lockedDocenCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
				  //[ACT_Documentos_en_Cartera]Estado:="Nulo"
				  //20120430 RCH Se estaba asignando mal el campo al anular
				  //[ACT_Documentos_en_Cartera]id_forma_de_pago:=$vl_idEstadoNulo
				[ACT_Documentos_en_Cartera:182]id_estado:21:=$vl_idEstadoNulo
				[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
				SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
			End if 
			$tomadosTransacciones:=ACTpgs_DesasignaIdTransaccion (->$aRecNumTransacciones)
			If ($vlACT_recNumDocPago#-1)
				GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$vlACT_recNumDocPago)
			End if 
			GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
			[ACT_Documentos_de_Pago:176]Nulo:37:=True:C214
			ACTcfg_OpcionesCambioEstadoPago ("AsignaNuevoEstado";->$vl_idEstadoNulo)
			  //[ACT_Documentos_de_Pago]Estado:="Nulo"
			  //[ACT_Documentos_de_Pago]id_estado:=$vl_idEstadoNulo
			  //[ACT_Documentos_de_Pago]Estado:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago]id_forma_de_pago;->[ACT_Documentos_de_Pago]id_estado)
			  //SAVE RECORD([ACT_Documentos_de_Pago])
			ACTdp_fSave 
			[ACT_Pagos:172]Nulo:14:=True:C214
			[ACT_Pagos:172]Saldo:15:=0
			SAVE RECORD:C53([ACT_Pagos:172])
			$lockedPago:=Locked:C147([ACT_Pagos:172])
			
			  //20180801 RCH Ticket 213280
			$lockedAviso:=ACTac_OpcionesGenerales ("ACTac_Recalcular";->$al_recNumsAvisos)
			
			If (Not:C34($lockedPago) & (Not:C34($lockedDocdePago)) & (Not:C34($lockedCargos)) & (Not:C34($lockedDocdeCargo)) & (Not:C34($lockedDocenCartera)) & Not:C34($lockedAviso) & ($tomadosTransacciones=0) & (Not:C34($b_cargoNoEliminado)))
			Else 
				$Abort:=True:C214
			End if 
			LOG_RegisterEvt ("Anulación del pago N° "+String:C10([ACT_Pagos:172]ID:1))
		End if 
	Else 
		$Abort:=True:C214
	End if 
Else 
	$Abort:=True:C214
End if 
ACTpgs_DeleteRecargoXA 
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Transacciones:178])
KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
KRL_UnloadReadOnly (->[ACT_Cargos:173])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
If (Not:C34($Abort))
	
	If ($vb_confirmarTrans)
		VALIDATE TRANSACTION:C240
	End if 
	
	READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
	QUERY WITH ARRAY:C644([ACT_Transacciones:178]ID_Apoderado:11;$aIDApdosPagos)
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10#0)
	KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
	ARRAY LONGINT:C221($aAvisos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aAvisos)
	For ($v;1;Size of array:C274($aAvisos))
		READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aAvisos{$v})
		If (Not:C34(Locked:C147([ACT_Avisos_de_Cobranza:124])))
			ACTac_Prepagar (Record number:C243([ACT_Avisos_de_Cobranza:124]))
		Else 
			BM_CreateRequest ("ACT_PrepagaAviso";String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1))
		End if 
		KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
	End for 
	ACTcfg_ItemsMatricula ("EliminaPago";->$al_idsCtasCtes)
	
	If ($vb_pagoConProblema)
		ACTcar_ValidaMontos ("VerificaCargosDePagoConProblema")
	End if 
	ACTac_OpcionesGenerales ("RecalculaAvisos";->$al_recNumsAvisos)
	KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
	
	$vb_mostrarTermo:=True:C214
	If ($vb_calculaCtaCte)
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrarTermo)
	Else 
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
	End if 
	
Else 
	ACTcc_OpcionesCalculoCtaCte ("InitArrays")
	vbACTcc_AgregarElementos:=False:C215
	If ($vb_confirmarTrans)
		CANCEL TRANSACTION:C241
	End if 
	CD_Dlog (0;__ ("En este momento existen pagos en uso o no está permitida la anulación de pagos asociados a Documentos Tributarios o existen cargos en moneda variable en documento(s) asociado(s). La selección no puede ser anulada."))
End if 
$0:=Num:C11(Not:C34($Abort))

