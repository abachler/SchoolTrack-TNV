//%attributes = {}
  //ACTcar_Delete

C_LONGINT:C283($1;$recNumCargo)
ARRAY LONGINT:C221($al_idsCtasCtes;0)
Case of 
	: (Count parameters:C259=1)
		$recNumCargo:=$1
End case 

  //20120710  RCH para evitar que cargos eliminados en la ventana de ingreso de pagos sean vueltos a generar.
ACTpgs_OpcionesCargosEliminados ("LlenaArreglos";->$recNumCargo)

ACTcc_OpcionesCalculoCtaCte ("InitArrays")

$vlACT_recNumApdo:=Record number:C243([Personas:7])
KRL_GotoRecord (->[ACT_Cargos:173];$recNumCargo;True:C214)
$l_idCargo:=[ACT_Cargos:173]ID:1
ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos:173]ID_Apoderado:18)
START TRANSACTION:C239
vb_CondonaCargo:=True:C214
$continue:=ACTcfg_OpcionesCondonacion ("Interfaz")
If ($continue)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$boleta)
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
	QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($boleta#0)
		CANCEL TRANSACTION:C241
		$0:=1
		CD_Dlog (0;__ ("Este cargo ya figura en un documento tributario. No puede ser eliminado."))
	Else 
		$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]No_Comprobante:10)
		$vl_idPagare:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30)
		If ($vl_idPagare=0)
			KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			
			
			  //Verifica cargo con id responsable asociado
			C_LONGINT:C283($l_recResp)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recResp)
			QUERY BY ATTRIBUTE:C1331([ACT_Cargos:173];[ACT_Cargos:173]OB_Responsable:70;"id_cargo_asociado";"=";$l_idCargo)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($l_recResp#0)
				$0:=5
				CANCEL TRANSACTION:C241
				ARRAY REAL:C219($ar_monto;0)
				ARRAY DATE:C224($ad_fechaG;0)
				ARRAY LONGINT:C221($al_idDC;0)
				QUERY BY ATTRIBUTE:C1331([ACT_Cargos:173];[ACT_Cargos:173]OB_Responsable:70;"id_cargo_asociado";"=";$l_idCargo)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Neto:5;$ar_monto;[ACT_Cargos:173]Fecha_de_generacion:4;$ad_fechaG;[ACT_Cargos:173]ID_Documento_de_Cargo:3;$al_idDC)
				$t_texto:="Fecha, monto, id AC\r"
				For ($l_indiceC;1;Size of array:C274($ar_monto))
					$t_texto:=$t_texto+String:C10($ad_fechaG{$l_indiceC})+", "+String:C10($ar_monto{$l_indiceC};"|Despliegue_ACT_Pagos")+", "+String:C10(KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$al_idDC{$l_indiceC};->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15))+"\r"
				End for 
				
				CD_Dlog (0;__ ("Este cargo está asociado a otros cargos generados según los porcentajes asignados en las cuentas corrientes. Antes de intentar eliminar este cargo, se deben eliminar los cargos asociados.\r\r"+$t_texto+"\rEl cargo no puede ser eliminado."))
			Else 
				
				If (Not:C34(OB Is defined:C1231([ACT_Cargos:173]OB_Responsable:70;"relacionados")))
					$l_recResp:=CD_Dlog (0;"Este cargo fue generado a partir de otro. No podrá ser generado automáticamente de la misma forma a no ser que se emita el cargo original nuevamente.\n\n¿Desea continuar?";"";"Si";"No")
				Else 
					$l_recResp:=1
				End if 
				
				If ($l_recResp#1)
					$0:=6
					CANCEL TRANSACTION:C241
				Else 
					
					  //20120301 RCH Cuando habia una aviso con saldo anterior y se eliminaba un cargo, el aviso perdia el saldo anterior hasta que era recalculado. Esto pasaba en la ficha del aviso.
					$vl_idApdo:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
					$vb_tieneSaldo:=(KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12)#0)
					
					$iddocCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
					$id_CtaCte:=[ACT_Cargos:173]ID_CuentaCorriente:2  //agregado porque cuando habian pagos por el mismo monto para distintas cuentas habia problema al eliminar descuentos
					READ WRITE:C146([ACT_Pagos:172])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
					AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->$al_idsCtasCtes)
					$lockedP:=False:C215
					$lockedTrans:=False:C215
					
					ARRAY LONGINT:C221($al_recNum;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum)
					For ($i;1;Size of array:C274($al_recNum))
						READ WRITE:C146([ACT_Transacciones:178])
						GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$i})
						If ([ACT_Cargos:173]Monto_Neto:5>=0)
							KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;True:C214)
							If (ok=0)
								$lockedP:=True:C214
							Else 
								If ([ACT_Transacciones:178]Glosa:8#"Pago con descuento")
									[ACT_Pagos:172]Saldo:15:=[ACT_Pagos:172]Saldo:15+ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
								End if 
								SAVE RECORD:C53([ACT_Pagos:172])
							End if 
						Else 
							$monto:=[ACT_Transacciones:178]Debito:6
							$vt_moneda:=ST_Boolean2Str ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
							$monto2:=ACTut_retornaMontoEnMoneda ([ACT_Transacciones:178]Debito:6;$vt_moneda;[ACT_Transacciones:178]Fecha:5;ST_GetWord (ACT_DivisaPais ;1;";"))
							PUSH RECORD:C176([ACT_Cargos:173])
							QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$iddocCargo)
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;*)
							QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_CuentaCorriente:2=$id_CtaCte;*)
							QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8="Pago con Descuento";*)
							QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6=$monto)
							If (Records in selection:C76([ACT_Transacciones:178])=0)
								QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$iddocCargo)
								QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;*)
								QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_CuentaCorriente:2=$id_CtaCte;*)
								QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8="Pago con Descuento";*)
								QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]MontoMonedaPago:14=$monto2)
							End if 
							KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;True:C214)
							$vt_monedaConv:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]Moneda:28)
							$vr_valorMonedaConv:=[ACT_Transacciones:178]ValorMoneda:13
							If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
								If ($vr_valorMonedaConv=0)
									$vr_montoMonedaPago:=[ACT_Transacciones:178]Debito:6
									$vr_montoMonedaCargo:=$vr_montoMonedaPago
								Else 
									$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaConv))
									$vr_montoMonedaPago:=[ACT_Transacciones:178]MontoMonedaPago:14
									$vr_montoMonedaCargo:=Round:C94([ACT_Transacciones:178]MontoMonedaPago:14/$vr_valorMonedaConv;$vl_decimales)
								End if 
								[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8-$vr_montoMonedaCargo
								[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52-$vr_montoMonedaPago
							Else 
								[ACT_Cargos:173]MontosPagados:8:=Abs:C99([ACT_Cargos:173]MontosPagados:8)-[ACT_Transacciones:178]Debito:6
								[ACT_Cargos:173]MontosPagadosMPago:52:=Abs:C99([ACT_Cargos:173]MontosPagadosMPago:52)-[ACT_Transacciones:178]Debito:6
							End if 
							If ([ACT_Cargos:173]MontosPagadosMPago:52=0)
								[ACT_Cargos:173]MontosPagados:8:=0
							End if 
							[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
							If (Abs:C99([ACT_Cargos:173]Saldo:23)>Abs:C99([ACT_Cargos:173]Monto_Neto:5))
								TRACE:C157
							End if 
							$vl_idCargoConDscto:=[ACT_Cargos:173]ID:1
							DELETE SELECTION:C66([ACT_Transacciones:178])
							If (Records in set:C195("LockedSet")>0)
								$lockedTrans:=True:C214
							End if 
							SAVE RECORD:C53([ACT_Cargos:173])
							QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
							If (Records in selection:C76([ACT_Documentos_de_Cargo:174])>0)
								ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
							End if 
							If ($lockedTrans)
								$i:=Size of array:C274($al_recNum)
							End if 
							POP RECORD:C177([ACT_Cargos:173])
						End if 
						KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					End for 
					READ WRITE:C146([ACT_Cargos:173])
					GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
					  //KRL_ReloadInReadWriteMode (->[ACT_Cargos])
					$lockedCargo:=Locked:C147([ACT_Cargos:173])
					$idCargo:=[ACT_Cargos:173]ID:1
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					READ ONLY:C145([Alumnos:2])
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
					  //20130129 RCH Para registrar mas detalles del cargo eliminado.
					  //If (Records in selection([Alumnos])>0)
					  //LOG_RegisterEvt ("Eliminación de cargo emitido "+[ACT_Cargos]Glosa+" para "+[Alumnos]Apellidos_y_Nombres+".")
					  //Else 
					  //If ([ACT_Cargos]Venta_Directa)
					  //LOG_RegisterEvt ("Eliminación de cargo emitido de Venta Directa: "+[ACT_Cargos]Glosa+".")
					  //Else 
					  //LOG_RegisterEvt ("Eliminación de cargo emitido: "+[ACT_Cargos]Glosa+".")
					  //End if 
					  //End if 
					If (Records in selection:C76([Alumnos:2])>0)
						$vt_log:="Eliminación de cargo emitido. Id cargo: "+String:C10([ACT_Cargos:173]ID:1)+", glosa: "+[ACT_Cargos:173]Glosa:12+" para "+[Alumnos:2]apellidos_y_nombres:40+", para el período: "+String:C10([ACT_Cargos:173]Año:14)+String:C10([ACT_Cargos:173]Mes:13;"00")+"."
					Else 
						If ([ACT_Cargos:173]Venta_Directa:59)
							$vt_log:="Eliminación de cargo emitido de Venta Directa. Id cargo: "+String:C10([ACT_Cargos:173]ID:1)+", glosa: "+[ACT_Cargos:173]Glosa:12+", para el período: "+String:C10([ACT_Cargos:173]Año:14)+String:C10([ACT_Cargos:173]Mes:13;"00")+"."
						Else 
							$vt_log:="Eliminación de cargo emitido. Id cargo: "+String:C10([ACT_Cargos:173]ID:1)+", glosa: "+[ACT_Cargos:173]Glosa:12+", para el período: "+String:C10([ACT_Cargos:173]Año:14)+String:C10([ACT_Cargos:173]Mes:13;"00")+"."
						End if 
					End if 
					  //20130405 RCH No se estaba guardando en el log el cambio...
					LOG_RegisterEvt ($vt_log)
					DELETE RECORD:C58([ACT_Cargos:173])
					READ WRITE:C146([ACT_Documentos_de_Cargo:174])
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$iddocCargo)
					$lockedDC:=Locked:C147([ACT_Documentos_de_Cargo:174])
					$avisoID:=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15
					SET QUERY DESTINATION:C396(Into variable:K19:4;$cargosEnDoc)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=$iddocCargo)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($cargosEnDoc>0)
						ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
					Else 
						DELETE RECORD:C58([ACT_Documentos_de_Cargo:174])
					End if 
					
					ARRAY LONGINT:C221($alACT_recNumAC;0)
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$avisoID)
					$avisoRN:=Record number:C243([ACT_Avisos_de_Cobranza:124])
					APPEND TO ARRAY:C911($alACT_recNumAC;$avisoRN)
					  //ACTac_Recalcular ($avisoRN)
					If (Not:C34($lockedCargo))  //para no sobreescribir si la varible ya venia en true
						  //$lockedCargo:=ACTcar_EliminaCargosRelacionado ($idCargo;->$alACT_recNumAC;$iddocCargo)
						
						  // Modificado por: Saúl Ponce (22-03-2017) Ticket 177887, ya no se usará el id del documento de cargo, se determina dentro del método
						$lockedCargo:=ACTcar_EliminaCargosRelacionado ($idCargo;->$alACT_recNumAC)
					End if 
					
					AT_DistinctsArrayValues (->$alACT_recNumAC)
					For ($r;1;Size of array:C274($alACT_recNumAC))
						ACTac_Recalcular ($alACT_recNumAC{$r})
					End for 
					
					
					  //  //20121222 RCH Cuando se eliminaan cargos para el primer aviso, no se consideraba que hubiera saldo anterior en los avisos.
					  //C_LONGINT($vl_ACConSaldo)
					  //SET QUERY LIMIT(1)
					  //SET QUERY DESTINATION(Into variable;$vl_ACConSaldo)
					  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado=$vl_idApdo;*)
					  //QUERY([ACT_Avisos_de_Cobranza]; & ;[ACT_Avisos_de_Cobranza]Saldo_anterior#0;*)
					  //QUERY([ACT_Avisos_de_Cobranza]; & ;[ACT_Avisos_de_Cobranza]Monto_a_Pagar#0)
					  //SET QUERY DESTINATION(Into current selection)
					  //SET QUERY LIMIT(0)
					  //  //20120301 RCH Cuando habia una aviso con saldo anterior y se eliminaba un cargo, el aviso perdia el saldo anterior hasta que era recalculado. Esto pasaba en la ficha del aviso.
					  //If (($vb_tieneSaldo) | ($vl_ACConSaldo=1))
					  //$vl_proc:=IT_UThermometer (1;0;"Recalculando avisos...")
					  //READ ONLY([ACT_Avisos_de_Cobranza])
					  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado=$vl_idApdo;*)
					  //QUERY([ACT_Avisos_de_Cobranza]; & ;[ACT_Avisos_de_Cobranza]Monto_a_Pagar#0)
					  //ARRAY LONGINT(alACT_RecNumsAvisos;0)
					  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];alACT_RecNumsAvisos)
					  //ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos)
					  //AT_Initialize (->alACT_RecNumsAvisos)
					  //IT_UThermometer (-2;$vl_proc)
					  //End if 
					
					KRL_UnloadReadOnly (->[ACT_Cargos:173])
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
					KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
					KRL_UnloadReadOnly (->[ACT_Pagos:172])
					If (($lockedCargo) | ($lockedDC) | ($lockedP) | ($lockedTrans))
						CANCEL TRANSACTION:C241
						$0:=2
						  //CD_Dlog (0;__ ("En este momento existen registros en uso. Por favor intente eliminar el cargo más tarde."))
						CD_Dlog (0;__ ("En este momento existen registros en uso o el cargo relacionado no puede ser eliminado. Por favor intente eliminar el cargo más tarde o revise si hay cargos relacionados en pagarés o en Documentos Tributarios."))  //20170426 RCH
					Else 
						ACTcfg_ItemsMatricula ("EliminaPago";->$al_idsCtasCtes)
						VALIDATE TRANSACTION:C240
						
						  //20160607 RCH Se recalculaba todavía en transacción y el cálculo se hacía en otro proceso. Ahora se recalcula cuando se valida la transacción.
						  //20121222 RCH Cuando se eliminaan cargos para el primer aviso, no se consideraba que hubiera saldo anterior en los avisos.
						C_LONGINT:C283($vl_ACConSaldo)
						SET QUERY LIMIT:C395(1)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_ACConSaldo)
						QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$vl_idApdo;*)
						QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12#0;*)
						QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						SET QUERY LIMIT:C395(0)
						  //20120301 RCH Cuando habia una aviso con saldo anterior y se eliminaba un cargo, el aviso perdia el saldo anterior hasta que era recalculado. Esto pasaba en la ficha del aviso.
						If (($vb_tieneSaldo) | ($vl_ACConSaldo=1))
							$vl_proc:=IT_UThermometer (1;0;"Recalculando avisos...")
							READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$vl_idApdo;*)
							QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
							ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos)
							ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos)
							AT_Initialize (->alACT_RecNumsAvisos)
							IT_UThermometer (-2;$vl_proc)
						End if 
						
						ACTac_RecalculaAvisos ("CargoBorrado")
						$0:=0
					End if 
				End if 
			End if 
		Else 
			$0:=4
			CANCEL TRANSACTION:C241
			CD_Dlog (0;__ ("Este cargo está asociado a un Pagaré a través de un Aviso de Cobranza. El cargo no puede ser eliminado."))
		End if 
	End if 
Else 
	$0:=3
	CANCEL TRANSACTION:C241
	$vt_dlog:=""
	ACTcfg_OpcionesCondonacion ("RetornaDlogNoContinuar";->$vt_dlog)
	CD_Dlog (0;$vt_dlog)
End if 
If ($0=0)  //20170629 RCH
	ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
End if 
ACTcfg_OpcionesCondonacion ("InitVars")
KRL_GotoRecord (->[Personas:7];$vlACT_recNumApdo)