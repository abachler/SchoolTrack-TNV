//%attributes = {}
  //ACTbol_AnulaDcto

C_BOOLEAN:C305($vb_anularDctoAsoc)
C_BOOLEAN:C305(vbACT_MostrarMensaje)
$vb_mostrarThermo:=True:C214
If (Count parameters:C259=1)
	$vb_mostrarThermo:=$1
End if 

ARRAY LONGINT:C221($aRNBoletas;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$aRNBoletas)
GOTO RECORD:C242([ACT_Boletas:181];$aRNBoletas{1})
$tipo:=[ACT_Boletas:181]TipoDocumento:7
$numDoc:=String:C10([ACT_Boletas:181]Numero:11)
If ($vb_mostrarThermo)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Anulando documento ")+$tipo+__ (" Número ")+$numDoc)
End if 
For ($i;1;Size of array:C274($aRNBoletas))
	READ WRITE:C146([ACT_Boletas:181])
	GOTO RECORD:C242([ACT_Boletas:181];$aRNBoletas{$i})
	$tipo:=[ACT_Boletas:181]TipoDocumento:7
	$numDoc:=String:C10([ACT_Boletas:181]Numero:11)
	$vb_esNotaCredito:=[ACT_Boletas:181]ID_DctoAsociado:19>0
	$IsLocked:=KRL_ReadWrite (->[ACT_Boletas:181])
	$vl_idDcto:=[ACT_Boletas:181]ID:1
	$vl_idDctoAsociado:=[ACT_Boletas:181]ID_DctoAsociado:19
	$vl_idApdo:=[ACT_Boletas:181]ID_Apoderado:14
	$vl_idTercero:=[ACT_Boletas:181]ID_Tercero:21
	If ($isLocked)
		  //BM_CreateRequest ("ACT_AnulaDocs";String([ACT_Boletas]ID))
	Else 
		If (Not:C34([ACT_Boletas:181]Nula:15))
			  //If (Not([ACT_Boletas]DTE_estado_id ?? 2))  //si el documento fue enviado a dte no se puede anular
			If (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 2) | (([ACT_Boletas:181]DTE_estado_id:24 ?? 2) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 4)))  //si el documento fue enviado a dte no se puede anular
				
				If ([ACT_Boletas:181]AR_CAEcodigo:48="")  //para que no se anulen documentos con CAE
					
					READ WRITE:C146([ACT_Transacciones:178])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$vl_idDcto)
					ARRAY LONGINT:C221($aRecNumTransacciones;0)
					ARRAY LONGINT:C221($al_recNumsAvisos;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aRecNumTransacciones;"")
					$lockedCargos:=False:C215
					$vb_continuar:=True:C214
					If ($vb_esNotaCredito)
						  //anular boleta en uf dejada de pagar al anular nota de crédito
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"SetAvisosDesdeDocs")
						$vb_emitir:=ACTbol_ValidaEmisionDocs ("SetAvisosDesdeDocs")
						CLEAR SET:C117("SetAvisosDesdeDocs")
						If (Not:C34($vb_emitir))
							If (Not:C34(vbACT_MostrarMensaje))
								$resp:=CD_Dlog (0;__ ("Existen cargos asociados a moneda variable. El Documento Tributario asociado también será anulado. Si existen devoluciones asociadas, éstas también serán anuladas.\r\r¿Desea continuar?");"";__ ("Si");__ ("No"))
								If ($resp=2)
									$vb_continuar:=False:C215
								Else 
									$vb_anularDctoAsoc:=True:C214
								End if 
							Else 
								$vb_anularDctoAsoc:=True:C214
							End if 
						End if 
						If ($vb_continuar)
							CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$aRecNumTransacciones;"")
							  //asignar disponible al pago y eliminar cargo de devolución
							CREATE SET:C116([ACT_Transacciones:178];"setTransacciones1")
							KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
							ACTcfg_LoadCargosEspeciales (9)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vl_idIE)
							If (Records in selection:C76([ACT_Cargos:173])>0)
								ARRAY LONGINT:C221($al_idsCargos;0)
								KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
								QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
								CREATE SET:C116([ACT_Transacciones:178];"setTransacciones2")
								KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
								If (Not:C34(vbACT_MostrarMensaje))
									$format:="|Despliegue_ACT_Pagos"
									$resp:=CD_Dlog (0;__ ("Existía una devolución por ")+String:C10(Sum:C1([ACT_Pagos:172]Monto_Pagado:5);$format)+__ (", dicha devolución también será anulada.\r\r¿Desea continuar?");"";__ ("Si");__ ("No"))
								Else 
									$resp:=1
								End if 
								If ($resp=1)
									ARRAY LONGINT:C221($al_recNumPagos;0)
									LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$al_recNumPagos;"")
									INTERSECTION:C121("setTransacciones1";"setTransacciones2";"setTransacciones1")
									USE SET:C118("setTransacciones1")
									DISTINCT VALUES:C339([ACT_Transacciones:178]ID_Item:3;$al_idsCargos)
									$vb_salir:=ACTbol_AnulaDevolucion (->$al_recNumPagos;->$al_idsCargos)
									If (Not:C34($vb_salir))
									Else 
										$vb_continuar:=False:C215
									End if 
									
									For ($y;1;Size of array:C274($al_recNumPagos))
										READ ONLY:C145([ACT_Pagos:172])
										GOTO RECORD:C242([ACT_Pagos:172];$al_recNumPagos{$y})
										KRL_UnloadReadOnly (->[ACT_Pagos:172])
									End for 
								Else 
									$vb_continuar:=False:C215
								End if 
								CLEAR SET:C117("setTransacciones2")
							End if 
							CLEAR SET:C117("setTransacciones1")
							
							If ($vb_continuar)
								$lockedCargos:=ACTpgs_EliminaPagoEnTrans (->$aRecNumTransacciones;->$al_recNumsAvisos)
								If (Not:C34($lockedCargos))
									
									READ WRITE:C146([ACT_Transacciones:178])
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15=$vl_idDcto)
									APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=$vl_idDctoAsociado)
									KRL_UnloadReadOnly (->[ACT_Transacciones:178])
									
									
									ARRAY LONGINT:C221($al_recNums2Delete;0)
									For ($j;1;Size of array:C274($aRecNumTransacciones))
										GOTO RECORD:C242([ACT_Transacciones:178];$aRecNumTransacciones{$j})
										$index:=Find in field:C653([ACT_Cargos:173]ID:1;[ACT_Transacciones:178]ID_Item:3)
										If ($index#-1)
											READ WRITE:C146([ACT_Cargos:173])
											GOTO RECORD:C242([ACT_Cargos:173];$index)
											If (([ACT_Cargos:173]Ref_Item:16=-127) | ([ACT_Cargos:173]Ref_Item:16=-128))
												If (Not:C34(Locked:C147([ACT_Cargos:173])))
													APPEND TO ARRAY:C911($al_recNums2Delete;$aRecNumTransacciones{$j})
													DELETE RECORD:C58([ACT_Cargos:173])
												Else 
													BM_CreateRequest ("ACT_BorrarCargo";String:C10([ACT_Cargos:173]ID:1);String:C10([ACT_Cargos:173]ID:1))
												End if 
											End if 
											KRL_UnloadReadOnly (->[ACT_Cargos:173])
										Else 
											APPEND TO ARRAY:C911($al_recNums2Delete;$aRecNumTransacciones{$j})
										End if 
									End for 
									For ($j;1;Size of array:C274($al_recNums2Delete))
										$pos:=Find in array:C230($aRecNumTransacciones;$al_recNums2Delete{$j})
										If ($pos#-1)
											AT_Delete ($pos;1;->$aRecNumTransacciones)
										End if 
									End for 
									
									READ WRITE:C146([ACT_Transacciones:178])
									CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$aRecNumTransacciones;"")
									DELETE SELECTION:C66([ACT_Transacciones:178])
									KRL_UnloadReadOnly (->[ACT_Transacciones:178])
									
									READ WRITE:C146([ACT_Boletas:181])
									GOTO RECORD:C242([ACT_Boletas:181];$aRNBoletas{$i})
									READ WRITE:C146([ACT_Transacciones:178])
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15=$vl_idDcto)
									CREATE SET:C116([ACT_Transacciones:178];"T_Todas")
									QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
									READ WRITE:C146([ACT_Transacciones:178])
									USE SET:C118("T_Todas")
									APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15:=0)
									
									CLEAR SET:C117("T_Todas")
									KRL_UnloadReadOnly (->[ACT_Transacciones:178])
									For ($r;1;Size of array:C274($al_recNumsAvisos))
										ACTac_Recalcular ($al_recNumsAvisos{$r})
									End for 
								Else 
									$vb_continuar:=False:C215
								End if 
								ACTbol_EstadoBoleta ([ACT_Boletas:181]ID_DctoAsociado:19)
							End if 
						End if 
					Else 
						SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_numDctosAsoc)
						QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$vl_idDcto;*)
						QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If ($vl_numDctosAsoc>0)
							$vb_continuar:=False:C215
							CD_Dlog (0;__ ("El documento tributario tipo ")+[ACT_Boletas:181]TipoDocumento:7+__ (", número ")+String:C10([ACT_Boletas:181]Numero:11)+__ (" tiene otro Documento Tributario asociado. El documento no puede ser anulado."))
						End if 
					End if 
					If ($vb_continuar)
						READ WRITE:C146([ACT_Boletas:181])
						GOTO RECORD:C242([ACT_Boletas:181];$aRNBoletas{$i})
						[ACT_Boletas:181]ID_Estado:20:=4
						[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
						[ACT_Boletas:181]Monto_Afecto:4:=0
						[ACT_Boletas:181]Monto_IVA:5:=0
						[ACT_Boletas:181]Monto_Total:6:=0
						  //20130328 RCH
						[ACT_Boletas:181]Monto_Exento:30:=0
						[ACT_Boletas:181]Nula:15:=True:C214
						
						If (Not:C34(ACTcaf_DisminuyeFolioDisponible ([ACT_Boletas:181]ID_CAF:43)))
							BM_CreateRequest ("DisminuyeCAF";String:C10([ACT_Boletas:181]ID_CAF:43);String:C10([ACT_Boletas:181]ID:1))
						End if 
						
						SAVE RECORD:C53([ACT_Boletas:181])
						If (Not:C34($lockedCargos))
							READ WRITE:C146([ACT_Transacciones:178])
							CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$aRecNumTransacciones;"")
							APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=0)
							If (Records in set:C195("LockedSet")>0)
								BM_CreateRequest ("ACT_AnulaDocs";String:C10($vl_idDcto))
							End if 
							KRL_UnloadReadOnly (->[ACT_Transacciones:178])
						End if 
						If (Not:C34($lockedCargos))
							LOG_RegisterEvt ("Anulación de documento tributario "+[ACT_Boletas:181]TipoDocumento:7+" N° "+String:C10([ACT_Boletas:181]Numero:11))
						End if 
						KRL_UnloadReadOnly (->[ACT_Transacciones:178])
						If ($vb_anularDctoAsoc)
							vbACT_MostrarMensaje:=True:C214
							  //anula notas de crédito
							If ($vl_idDctoAsociado>0)
								QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$vl_idDctoAsociado;*)
								QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
								If (Records in selection:C76([ACT_Boletas:181])>0)
									ACTbol_AnulaDcto (False:C215)
								End if 
							End if 
							vbACT_MostrarMensaje:=False:C215
							
							  //anula doc tributario
							If ($vl_idDctoAsociado>0)
								QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$vl_idDctoAsociado;*)
								QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
								If (Records in selection:C76([ACT_Boletas:181])>0)
									ACTbol_AnulaDcto (False:C215)
								End if 
							End if 
						End if 
						
						  //recalculo de ctas, apdos y terceros si es NC...
						If ($vb_esNotaCredito)
							ACTbol_OpcionesGenerales ("RecalculoAvisosNC";->$vl_idApdo;->$vl_idTercero)
						End if 
					Else 
						$vl_existe:=Find in array:C230(alACT_WDTEliminar;$aRNBoletas{$i})
						If ($vl_existe>0)
							AT_Delete ($vl_existe;1;->alACT_WDTEliminar)
						End if 
					End if 
					
				Else 
					CD_Dlog (0;__ ("El documento tributario electrónico tipo ")+[ACT_Boletas:181]TipoDocumento:7+__ (", número ")+String:C10([ACT_Boletas:181]Numero:11)+__ (" tiene Código de Autorización Electrónico asignado. El documento no puede ser anulado."))
				End if 
			Else 
				CD_Dlog (0;__ ("El documento tributario electrónico tipo ")+[ACT_Boletas:181]TipoDocumento:7+__ (", número ")+String:C10([ACT_Boletas:181]Numero:11)+__ (" ya tiene folio asignado. El documento no puede ser anulado."))
			End if 
		End if 
	End if 
	If ($vb_mostrarThermo)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRNBoletas);__ ("Anulando documento ")+$tipo+__ (" Número ")+$numDoc)
	End if 
End for 
KRL_UnloadReadOnly (->[ACT_Boletas:181])
If ($vb_mostrarThermo)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 