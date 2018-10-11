//%attributes = {}
  //ACTpgs_Delete

  //REGISTRO DE CAMBIOS
  //20080325 RCH If ([ACT_Pagos]ID>0) `cuando se elimina un pago desde dentro de la ficha del pago y hay un registro tomado, la transacción se cancela, si luego se presiona eliminar de nuevo, se buscan las transaciones con id de pago 0. Se agrega este if por seguridad.
  //20100223 RCH Se valida que el pago este correctamente asociado a los cargos. Si no es asi, se validan los montos netos y saldos de los cargos que no tienen pago asociado...

_O_C_INTEGER:C282($r;$0)
C_BOOLEAN:C305($lockedDocdePago;$lockedCargos;$lockedDocdeCargo;$lockedDocenCartera;$lockedPago;$lockedAviso)
ARRAY LONGINT:C221($al_recNumsAvisos;0)
C_BOOLEAN:C305($vb_pagoConProblema)
C_LONGINT:C283($tomadosTransacciones)
C_BOOLEAN:C305($b_cargoNoEliminado)  //20130730 RCH Manejo krl_delete....

$abort:=False:C215
$lockedDocdeCargo:=False:C215
$lockedDocenCartera:=False:C215  //Por si no hay doc en cartera (efectivo)
$lockedCargos:=False:C215
$lockedDocdePago:=False:C215
$lockedPago:=True:C214
$lockedAviso:=False:C215
$vb_mostrarThermo:=True:C214
$b_cargoNoEliminado:=False:C215
If ([ACT_Pagos:172]ID:1>0)  //cuando se elimina un pago desde dentro de la ficha del pago y hay un registro tomado, la transacción se cancela, si luego se presiona eliminar de nuevo, se buscan las transaciones con id de pago 0.
	If (USR_checkRights ("D";->[ACT_Pagos:172]))
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
		$lockedDocdePago:=Locked:C147([ACT_Documentos_de_Pago:176])
		$vl_recNumPago:=Record number:C243([ACT_Pagos:172])
		$vlACT_recNumDocPago:=Record number:C243([ACT_Documentos_de_Pago:176])
		If (Not:C34([ACT_Documentos_de_Pago:176]Depositado:35))
			If ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51#-8)
				$go:=ACTpgs_ValidaEliminacion 
				If ($go)
					$r:=CD_Dlog (0;__ ("¿Desea realmente eliminar el pago?");__ ("");__ ("No");__ ("Eliminar"))
					If ($r=2)
						ACTcc_OpcionesCalculoCtaCte ("InitArrays")
						START TRANSACTION:C239
						READ WRITE:C146([ACT_Pagos:172])
						GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
						$idPago:=[ACT_Pagos:172]ID:1
						$montoPago:=[ACT_Pagos:172]Monto_Pagado:5
						$formaPago:=[ACT_Pagos:172]forma_de_pago_new:31
						$idApdoPago:=[ACT_Pagos:172]ID_Apoderado:3
						$idTercero:=[ACT_Pagos:172]ID_Tercero:26
						$vb_pagoConProblema:=ACTcar_ValidaMontos ("ValidaCargosDelPago";->$idPago;->$vb_mostrarThermo)
						READ WRITE:C146([ACT_Pagos:172])
						GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
						READ ONLY:C145([Personas:7])
						READ ONLY:C145([ACT_Terceros:138])
						QUERY:C277([Personas:7];[Personas:7]No:1=$idApdoPago)
						QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=$idTercero)
						If ($idTercero=0)
							$ApdoNombre:=[Personas:7]Apellidos_y_nombres:30
						Else 
							$ApdoNombre:=[ACT_Terceros:138]Nombre_Completo:9
						End if 
						UNLOAD RECORD:C212([Personas:7])
						If (Not:C34([ACT_Pagos:172]Nulo:14))
							$b_cargoNoEliminado:=(ACTcar_OpcionesGenerales ("PGS_eliminaDsctosCargosAsociados";->[ACT_Pagos:172]ID:1)="0")
							GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
							ARRAY LONGINT:C221($al_idsCtas;0)
							AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->$al_idsCtas)
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
								DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
							End if 
							$tomadosTransacciones:=ACTpgs_DesasignaIdTransaccion (->$aRecNumTransacciones)
							If ($vlACT_recNumDocPago#-1)
								GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$vlACT_recNumDocPago)
							End if 
							GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
							DELETE RECORD:C58([ACT_Documentos_de_Pago:176])
							DELETE RECORD:C58([ACT_Pagos:172])
							$lockedPago:=Locked:C147([ACT_Pagos:172])
							
							  //20180801 RCH Ticket 213280
							$lockedAviso:=ACTac_OpcionesGenerales ("ACTac_Recalcular";->$al_recNumsAvisos)
							
							If (Not:C34($lockedPago) & (Not:C34($lockedDocdePago)) & (Not:C34($lockedCargos)) & (Not:C34($lockedDocdeCargo)) & (Not:C34($lockedDocenCartera)) & Not:C34($lockedAviso) & ($tomadosTransacciones=0) & (Not:C34($b_cargoNoEliminado)))
								$abort:=False:C215
							Else 
								$abort:=True:C214
							End if 
							ACTpgs_DeleteRecargoXA 
							READ ONLY:C145([ACT_Pagos:172])
							READ ONLY:C145([ACT_Transacciones:178])
							READ ONLY:C145([ACT_Documentos_en_Cartera:182])
							KRL_UnloadReadOnly (->[ACT_Cargos:173])
							KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
							KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
						Else 
							KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;True:C214)
							DELETE RECORD:C58([ACT_Documentos_de_Pago:176])
							DELETE RECORD:C58([ACT_Pagos:172])
							DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
							$lockedPago:=Locked:C147([ACT_Pagos:172])
							$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
							If ((Not:C34($lockedPago)) & (Not:C34($lockedDocdePago)) & (Not:C34($lockedCartera)))
								$abort:=False:C215
							Else 
								$abort:=True:C214
							End if 
						End if 
						READ ONLY:C145([ACT_Documentos_de_Pago:176])
						If (Not:C34($abort))
							READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
							If ($idApdoPago#0)
								QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Apoderado:11=$idApdoPago;*)
								QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0)
							Else 
								QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Tercero:16=$idTercero;*)
								QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0)
							End if 
							KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
							QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
							ARRAY LONGINT:C221($RecNumsAvisosPre;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$RecNumsAvisosPre;"")
							For ($i;1;Size of array:C274($RecNumsAvisosPre))
								READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
								GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$RecNumsAvisosPre{$i})
								If (Not:C34(Locked:C147([ACT_Avisos_de_Cobranza:124])))
									ACTac_Prepagar ($RecNumsAvisosPre{$i})
								Else 
									BM_CreateRequest ("ACT_PrepagaAviso";String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1))
								End if 
							End for 
							KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
							LOG_RegisterEvt ("Eliminación de pago N° "+String:C10($idPago)+", "+$formaPago+", "+String:C10($montoPago;"|Despliegue_ACT")+", "+$ApdoNombre)
							VALIDATE TRANSACTION:C240
							$0:=1
						Else 
							CANCEL TRANSACTION:C241
							CD_Dlog (0;__ ("En este momento existen registros en uso. El pago no puede ser eliminado."))
						End if 
						If (Not:C34($abort))
							$vb_mostrarTermo:=True:C214
							ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrarTermo)
							ACTcfg_ItemsMatricula ("EliminaPago";->$al_idsCtas)
							If ($vb_pagoConProblema)
								ACTcar_ValidaMontos ("VerificaCargosDePagoConProblema")
							End if 
							ACTac_OpcionesGenerales ("RecalculaAvisos";->$al_recNumsAvisos)
						Else 
							ACTcc_OpcionesCalculoCtaCte ("InitArrays")
							vbACTcc_AgregarElementos:=False:C215
						End if 
						KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->$idPago)
						KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6)
						KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3)
						KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Pagos:172]ID_Tercero:26)
					End if 
				Else 
					CD_Dlog (0;__ ("Este pago está total o parcialmente relacionado con uno o varios documentos tributarios o existen cargos en moneda variable en documento(s) asociado(s). El pago no puede ser eliminado."))
				End if 
			Else 
				CD_Dlog (0;__ ("El documento no puede ser eliminado."))
			End if 
		Else 
			CD_Dlog (0;__ ("El documento de pago ya fue depositado. El pago no puede ser eliminado."))
		End if 
	Else 
		USR_ALERT_UserHasNoRights (3)
	End if 
End if 