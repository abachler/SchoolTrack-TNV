//%attributes = {}
  //ACTpgs_DeleteSelection

$0:=0
$Abort:=False:C215
$b_msjNoEliminado:=False:C215
If (USR_checkRights ("D";->[ACT_Pagos:172]))
	If (Records in selection:C76([ACT_Pagos:172])>0)
		$r:=CD_Dlog (0;__ ("Los registros serán eliminados definitivamente sin ninguna verificación adicional.\r¿Desea realmente eliminar los registros seleccionados?\r\rRecuerde que los pagos realizados con cheques que ya han sido depositados no serán eliminados.");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			ACTcc_OpcionesCalculoCtaCte ("InitArrays")
			ARRAY LONGINT:C221($aRecNumPagos;0)
			ARRAY LONGINT:C221($aIDApdosPagos;0)
			ARRAY LONGINT:C221($al_recNumsAvisos;0)
			C_BOOLEAN:C305($vb_pagoConProblema)
			C_BOOLEAN:C305($b_cargoNoEliminado)  //20130730 RCH Manejo krl_delete....
			SELECTION TO ARRAY:C260([ACT_Pagos:172];$aRecNumPagos;[ACT_Pagos:172]ID_Apoderado:3;$aIDApdosPagos)
			$lockedDocdePago:=False:C215
			$lockedDocenCartera:=False:C215
			$lockedCargos:=False:C215
			$lockedDocdeCargo:=False:C215
			$lockedPago:=True:C214
			$lockedAviso:=False:C215
			$b_cargoNoEliminado:=False:C215
			START TRANSACTION:C239
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Eliminando Pagos..."))
			$iterations:=Size of array:C274($aRecNumPagos)
			ARRAY LONGINT:C221($al_idsCtasTotal;0)
			For ($i;1;Size of array:C274($aRecNumPagos))
				READ WRITE:C146([ACT_Pagos:172])
				READ WRITE:C146([ACT_Documentos_de_Pago:176])
				GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
				$go:=ACTpgs_ValidaEliminacion 
				If ($go)
					$idPago:=[ACT_Pagos:172]ID:1
					$montoPago:=[ACT_Pagos:172]Monto_Pagado:5
					$formaPago:=[ACT_Pagos:172]forma_de_pago_new:31
					$idApdoPago:=[ACT_Pagos:172]ID_Apoderado:3
					$idTercero:=[ACT_Pagos:172]ID_Tercero:26
					$vb_pagoConProblema:=ACTcar_ValidaMontos ("ValidaCargosDelPago";->$idPago)
					READ WRITE:C146([ACT_Pagos:172])
					GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
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
					QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
					$lockedDocdePago:=Locked:C147([ACT_Documentos_de_Pago:176])
					$vl_recNumDocPago:=Record number:C243([ACT_Documentos_de_Pago:176])
					If (Not:C34([ACT_Documentos_de_Pago:176]Depositado:35))
						If ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51#-8)
							GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
							If (Not:C34([ACT_Pagos:172]Nulo:14))
								$b_cargoNoEliminado:=(ACTcar_OpcionesGenerales ("PGS_eliminaDsctosCargosAsociados";->[ACT_Pagos:172]ID:1)="0")
								GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
								QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
								ARRAY LONGINT:C221($al_idsCtas;0)
								ARRAY LONGINT:C221($al_idsCtas2;0)
								COPY ARRAY:C226($al_idsCtasTotal;$al_idsCtas2)
								AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->$al_idsCtas)
								AT_Union (->$al_idsCtas2;->$al_idsCtas;->$al_idsCtasTotal)
								ARRAY LONGINT:C221($aRecNumTransacciones;0)
								ARRAY LONGINT:C221(aEnBoleta;0)
								SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aRecNumTransacciones;[ACT_Transacciones:178]No_Boleta:9;aEnBoleta)
								$lockedCargos:=ACTpgs_EliminaPagoEnTrans (->$aRecNumTransacciones;->$al_recNumsAvisos)
								If ($vl_recNumDocPago#-1)
									GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$vl_recNumDocPago)
								End if 
								READ WRITE:C146([ACT_Documentos_en_Cartera:182])
								$DocenCartera:=Find in field:C653([ACT_Documentos_en_Cartera:182]ID_DocdePago:3;[ACT_Documentos_de_Pago:176]ID:1)
								If ($DocenCartera#-1)
									GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$DocenCartera)
									$lockedDocenCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
									DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
								End if 
								$tomadosTransacciones:=ACTpgs_DesasignaIdTransaccion (->$aRecNumTransacciones)
								GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
								DELETE RECORD:C58([ACT_Documentos_de_Pago:176])
								DELETE RECORD:C58([ACT_Pagos:172])
								$lockedPago:=Locked:C147([ACT_Pagos:172])
								
								  //20180801 RCH Ticket 213280
								$lockedAviso:=ACTac_OpcionesGenerales ("ACTac_Recalcular";->$al_recNumsAvisos)
								
								If (Not:C34($lockedPago) & (Not:C34($lockedDocdePago)) & (Not:C34($lockedCargos)) & (Not:C34($lockedDocdeCargo)) & (Not:C34($lockedDocenCartera)) & Not:C34($lockedAviso) & ($tomadosTransacciones=0) & (Not:C34($b_cargoNoEliminado)))
								Else 
									$Abort:=True:C214
									$i:=Size of array:C274($aRecNumPagos)+1
								End if 
							Else 
								KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;True:C214)
								DELETE RECORD:C58([ACT_Documentos_de_Pago:176])
								DELETE RECORD:C58([ACT_Pagos:172])
								DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
								$lockedPago:=Locked:C147([ACT_Pagos:172])
								$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
								If ((Not:C34($lockedPago)) & (Not:C34($lockedDocdePago)) & (Not:C34($lockedCartera)))
								Else 
									$abort:=True:C214
									$i:=Size of array:C274($aRecNumPagos)+1
								End if 
							End if 
							LOG_RegisterEvt ("Eliminación del pago N° "+String:C10($idPago)+", "+$formaPago+", "+String:C10($montoPago;"|Despliegue_ACT")+", "+$ApdoNombre)
						Else 
							CD_Dlog (0;__ ("El documento no puede ser eliminado."))
						End if 
					End if 
				Else 
					$b_msjNoEliminado:=True:C214
				End if 
				
				READ ONLY:C145([ACT_Pagos:172])
				READ ONLY:C145([ACT_Transacciones:178])
				READ ONLY:C145([ACT_Documentos_en_Cartera:182])
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
				KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
				KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
				KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$iterations;__ ("Eliminando Pagos..."))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			ACTpgs_DeleteRecargoXA 
			If (Not:C34($Abort))
				READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
				AT_DistinctsArrayValues (->$aIDApdosPagos)
				If (Find in array:C230($aIDApdosPagos;0)#-1)
					AT_Delete (Find in array:C230($aIDApdosPagos;0);1;->$aIDApdosPagos)
				End if 
				  //QUERY WITH ARRAY([ACT_Transacciones]ID_Apoderado;$aIDApdosPagos)
				  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Comprobante#0)
				  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Transacciones]No_Comprobante;"")
				  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Monto_a_Pagar>0)
				  ///15102015 JVP ticket 146075 anteriormente buscaba todos los avisos del apoderado, pero deberia
				  //filtrar por lo pagos con saldo, debido a que se va a efectuar el prepago de los avisos
				
				QUERY WITH ARRAY:C644([ACT_Pagos:172]ID_Apoderado:3;$aIDApdosPagos)
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Saldo:15>0)
				SELECTION TO ARRAY:C260([ACT_Pagos:172]ID_Apoderado:3;$aIDApdosConSaldo)
				QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;$aIDApdosPagos)
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
				QUERY SELECTION WITH ARRAY:C1050([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;$aIDApdosConSaldo)
				ARRAY LONGINT:C221($RecNumsAvisosPre;0)
				  //cuando la seleccion esta vacia da problemas 
				  //167608 JVP 20160906
				  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];$RecNumsAvisosPre;"")
				SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$RecNumsAvisosPre)
				If (Size of array:C274($RecNumsAvisosPre)>0)
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando Avisos de Cobranza..."))
					$iterations:=Size of array:C274($RecNumsAvisosPre)
					For ($i;1;Size of array:C274($RecNumsAvisosPre))
						READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
						GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$RecNumsAvisosPre{$i})
						If (Not:C34(Locked:C147([ACT_Avisos_de_Cobranza:124])))
							ACTac_Prepagar ($RecNumsAvisosPre{$i})
						Else 
							BM_CreateRequest ("ACT_PrepagaAviso";String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1))
						End if 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($RecNumsAvisosPre);__ ("Prepagando Avisos de Cobranza..."))
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
				End if 
				  //fin codigo nuevo, valido con un if para mostrar un termometro
				
				ACTcfg_ItemsMatricula ("EliminaPago";->$al_idsCtasTotal)
				VALIDATE TRANSACTION:C240
				$0:=1
				If ($vb_pagoConProblema)
					ACTcar_ValidaMontos ("VerificaCargosDePagoConProblema")
				End if 
				ACTac_OpcionesGenerales ("RecalculaAvisos";->$al_recNumsAvisos)
				$vb_mostrarTermo:=True:C214
				ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrarTermo)
			Else 
				ACTcc_OpcionesCalculoCtaCte ("InitArrays")
				vbACTcc_AgregarElementos:=False:C215
				CANCEL TRANSACTION:C241
				CD_Dlog (0;__ ("En este momento existen registros en uso o existen cargos en moneda variable en documento(s) asociado(s). La selección no puede ser eliminada."))
			End if 
		End if 
		If ($b_msjNoEliminado)
			CD_Dlog (0;__ ("Algunos pagos no fueron eliminados, ya que se encuentran asociados a un Documento Tributario."))
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 