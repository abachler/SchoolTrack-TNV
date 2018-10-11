//%attributes = {}
  //ACTdte_EmiteND
TRACE:C157
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Cargos:173])

READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([ACT_Transacciones:178])

C_LONGINT:C283($l_idAviso;$l_idNuevoAC;$l_proc)
C_LONGINT:C283($l_idDC;$l_idDC2)
C_LONGINT:C283($l_id_boleta;$l_id_boleta2)
C_LONGINT:C283($l_indice;$l_pos;$l_locked;$l_indice2;$l_indice3)
C_LONGINT:C283($l_idApdo;$CatApdo;$l_numDoc)
C_BOOLEAN:C305($allow;$b_hayError)
C_REAL:C285(vrACT_MontoAdeudado;$r_montoOrg;$r_mmontoDoc)

C_BOOLEAN:C305($b_existeEnBD)
C_LONGINT:C283($vl_idBoleta;$l_folioDocRef;$l_RefCod;lACTbol_DiaVencimientoSel;$l_idBol)
C_TEXT:C284($t_tipoDocAsoc;$t_RefRazon;$t_moneda)
C_DATE:C307($d_refFecha)

ARRAY LONGINT:C221(aQR_Longint1;0)  //recnum cargos a duplicar
ARRAY LONGINT:C221(aQR_Longint2;0)  //ids Nuevos AC
ARRAY LONGINT:C221(aQR_Longint3;0)  //recnum cargos
ARRAY LONGINT:C221(aQR_Longint4;0)  //ids items
ARRAY REAL:C219(aQR_Real1;0)  //monto
ARRAY LONGINT:C221(aQR_Longint5;0)  //rec num cargos
ARRAY LONGINT:C221(aQR_Longint6;0)  //ids cargos

ARRAY LONGINT:C221(alACT_idsCategorias;0)

If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181]))
	
	$CatApdo:=-5
	
	ACTcfg_LoadConfigData (8)
	ACTcfg_LoadConfigData (1)
	ACTpgs_OpcionesVR ("ACT_initArrays")
	
	$allow:=ACTbol_ValidaInicioEmision (1;$CatApdo;True:C214)  //20150706 RCH
	If ($allow)
		
		C_LONGINT:C283($l_recs;$l_resp)
		
		$l_recs:=BWR_SearchRecords 
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33="61";*)
		QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Apoderado:14#0)
		
		If (Records in selection:C76([ACT_Boletas:181])=1)
			$l_resp:=CD_Dlog (0;"Se emitirá una Nota de Débito que anule el documento de referencia, asociada al documento seleccionado.\r\r¿Desea continuar?";"";"Si";"No")
			If ($l_resp=1)
				
				  //$t_tipoDocAsoc:="61"
				  //$l_folioDocRef:=$l_numDoc
				  //$l_refCod:=1
				  //$t_refRazon:="Anula documento."
				  //$d_refFecha:=!07-09-2016!
				  //$l_idAviso:=75936
				
				$l_idBol:=[ACT_Boletas:181]ID:1
				$t_tipoDocAsoc:=[ACT_Boletas:181]codigo_SII:33
				$l_folioDocRef:=[ACT_Boletas:181]Numero:11
				$r_mmontoDoc:=[ACT_Boletas:181]Monto_Total:6
				$l_refCod:=1
				$t_refRazon:="Anula documento."
				$d_refFecha:=[ACT_Boletas:181]FechaEmision:3
				$l_numDoc:=$l_folioDocRef
				
				  //KRL_RelateSelection (->[ACT_Transacciones]No_Boleta;->[ACT_Boletas]ID;"")
				  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Transacciones]No_Comprobante;"")
				  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]No_ComprobanteInterno;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
				  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
				
				  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-127)
				  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-128)
				  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-129)
				ACTbol_BuscaCargosCargaSet ("$Transacciones";[ACT_Boletas:181]ID:1)
				
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint5;"")
				For ($l_indice;1;Size of array:C274(aQR_Longint5))
					GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint5{$l_indice})
					APPEND TO ARRAY:C911(aQR_Longint6;[ACT_Cargos:173]ID:1)
					APPEND TO ARRAY:C911(aQR_Real1;ACTbol_GetMontoLinea ("$transacciones"))
				End for 
				SET_ClearSets ("$transacciones")
				
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
				KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
				SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];aQR_Longint4)
				
				START TRANSACTION:C239
				$l_proc:=IT_UThermometer (1;0;"Emitiendo documento...")
				For ($l_indice;1;Size of array:C274(aQR_Longint4))
					GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint4{$l_indice})
					$l_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
					
					DUPLICATE RECORD:C225([ACT_Avisos_de_Cobranza:124])
					[ACT_Avisos_de_Cobranza:124]ID_Aviso:1:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					$l_idNuevoAC:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
					SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
					
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$l_idAviso)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];aQR_Longint1;"")
					For ($l_indice2;1;Size of array:C274(aQR_Longint1))
						GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];aQR_Longint1{$l_indice2})
						
						DUPLICATE RECORD:C225([ACT_Documentos_de_Cargo:174])
						$l_idDC:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
						[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
						$l_idDC2:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
						[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=$l_idNuevoAC
						SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
						
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=$l_idDC)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint3;"")
						
						For ($l_indice3;1;Size of array:C274(aQR_Longint3))
							GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint3{$l_indice3})
							
							If (([ACT_Cargos:173]Ref_Item:16#-127) & ([ACT_Cargos:173]Ref_Item:16#-128) & ([ACT_Cargos:173]Ref_Item:16#-129))
								If (Find in array:C230(aQR_Longint6;[ACT_Cargos:173]ID:1)>0)
									DUPLICATE RECORD:C225([ACT_Cargos:173])
									[ACT_Cargos:173]ID_Documento_de_Cargo:3:=$l_idDC2
									[ACT_Cargos:173]Monto_Neto:5:=aQR_Real1{Find in array:C230(aQR_Longint6;[ACT_Cargos:173]ID:1)}
									[ACT_Cargos:173]MontosPagados:8:=0
									[ACT_Cargos:173]MontosPagadosMPago:52:=0
									[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
									SAVE RECORD:C53([ACT_Cargos:173])
								End if 
							End if 
						End for 
					End for 
					
					  //recalcular DC
					READ ONLY:C145([ACT_Cargos:173])
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=$l_idDC2)
					If (Records in selection:C76([ACT_Cargos:173])>0)
						ACTcc_CalculaDocumentoCargo (Find in field:C653([ACT_Documentos_de_Cargo:174]ID_Documento:1;$l_idDC2))
					Else 
						If (Not:C34(ACTcc_BorrarDocdeCargo (String:C10($l_idDC2))))
							BM_CreateRequest ("ACT_BorrarDocdeCargo";String:C10($l_idDC2))
						End if 
					End if 
					
					
					  //recalculo de AC
					READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$l_idNuevoAC)
					ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]))
					
					APPEND TO ARRAY:C911(aQR_Longint2;$l_idNuevoAC)
				End for 
				
				
				  //emisión ND
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33=$t_tipoDocAsoc;*)
				QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11=$l_numDoc)
				If (Records in selection:C76([ACT_Boletas:181])=1)
					$l_idApdo:=[ACT_Boletas:181]ID_Apoderado:14
					
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$l_idBol;*)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
					If (Records in selection:C76([ACT_Boletas:181])=0)
						C_LONGINT:C283($l_idItem;$r;$vl_folioDT;$vl_tipoDoc)
						C_REAL:C285(RNApdo)
						C_LONGINT:C283(RNTercero)
						C_REAL:C285($r_monto)
						C_LONGINT:C283($vl_idRecord)
						C_TEXT:C284($vt_glosa;$vt_obs)
						C_BOOLEAN:C305($vb_continua;$vb_mostrarThermo;$b_generaMonto0)
						C_DATE:C307($vd_fechaDT;vdACT_FechaPago;vdACT_FechaE)
						C_REAL:C285($vr_montoEnCargos;$r_montoBoleta)
						
						RNApdo:=-1
						RNTercero:=-1
						
						If ([ACT_Boletas:181]ID_Apoderado:14#0)
							ptrACTpgs_Table:=->[Personas:7]
							ptrACTpgs_FieldID:=->[Personas:7]No:1
							ptrACTpgs_VarRecNum:=->RNApdo
							ptrACTpgs_FieldDT:=->[Personas:7]ACT_DocumentoTributario:45
						Else 
							ptrACTpgs_Table:=->[ACT_Terceros:138]
							ptrACTpgs_FieldID:=->[ACT_Terceros:138]Id:1
							ptrACTpgs_VarRecNum:=->RNTercero
							ptrACTpgs_FieldDT:=->[ACT_Terceros:138]id_CatDocTrib:55
						End if 
						
						$vd_fechaDT:=Current date:C33(*)
						$vl_folioDT:=1
						
						  //emision de documentos tributarios
						READ ONLY:C145([ACT_Cargos:173])
						READ ONLY:C145([ACT_Documentos_de_Cargo:174])
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						
						
						
						QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aQR_Longint2)
						KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
						$vr_montoEnCargos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						
						If ($r_mmontoDoc=$vr_montoEnCargos)
							VALIDATE TRANSACTION:C240
							
							  //retorna el id de la categoria que tenia
							RNApdo:=KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo;True:C214)
							If (ok=1)
								$vl_tipoDoc:=[Personas:7]ACT_DocumentoTributario:45
								[Personas:7]ACT_DocumentoTributario:45:=$CatApdo
								SAVE RECORD:C53([Personas:7])
								KRL_UnloadReadOnly (->[Personas:7])
								
								
								CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
								vdACT_FechaE:=Current date:C33(*)
								vdACT_FEmisionBol:=vdACT_FechaE
								vtACT_FEmisionBol:=String:C10(vdACT_FEmisionBol)
								f1:=1
								f2:=0
								
								i1:=0
								i2:=1
								  //para quien
								e1:=Num:C11($l_idApdo#0)  //apoderados
								e2:=0
								e3:=Num:C11(e1=0)  //terceros
								e4:=0  //terceros
								
								  //periodos
								h1:=0
								  // month year
								s1:=1
								s2:=0
								  // month year?
								h2:=1
								h3:=0  // se emite una boleta por aviso
								
								vbACT_noGuardarNum:=True:C214
								
								ARRAY LONGINT:C221(alACT_idsBoletasEmitidas;0)
								vbACT_RegistrarIDSBoletas:=True:C214
								ACTbol_EMasivaDocTribs (False:C215)
								
								For ($r;1;Size of array:C274(alACT_idsBoletasEmitidas))
									READ WRITE:C146([ACT_Boletas:181])
									  //USE SET(aSetsDT{$r})
									  //LOAD RECORD([ACT_Boletas])
									KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->alACT_idsBoletasEmitidas{$r};True:C214)
									If (Records in selection:C76([ACT_Boletas:181])=1)
										[ACT_Boletas:181]orden_interno:36:=$vl_folioDT
										SAVE RECORD:C53([ACT_Boletas:181])
										KRL_UnloadReadOnly (->[ACT_Boletas:181])
										
										READ ONLY:C145([ACT_Boletas:181])
										QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33=$t_tipoDocAsoc;*)
										QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11=$l_folioDocRef)
										If (Records in selection:C76([ACT_Boletas:181])=1)
											$b_existeEnBD:=True:C214
											$vl_idBoleta:=[ACT_Boletas:181]ID:1
										Else 
											$b_existeEnBD:=False:C215
										End if 
										READ WRITE:C146([ACT_Boletas:181])
										KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->alACT_idsBoletasEmitidas{$r};True:C214)
										If ($b_existeEnBD)
											[ACT_Boletas:181]ID_DctoAsociado:19:=$vl_idBoleta
										Else 
											[ACT_Boletas:181]Referencia_TipoDocumento:37:=$t_tipoDocAsoc
											[ACT_Boletas:181]Referencia_FolioDocumento:38:=String:C10($l_folioDocRef)
											[ACT_Boletas:181]Referencia_FechaDocumento:39:=$d_refFecha
										End if 
										[ACT_Boletas:181]codigo_referencia:31:=$l_refCod
										[ACT_Boletas:181]Referencia_Razon:40:=$t_refRazon
										
										$r_montoBoleta:=[ACT_Boletas:181]Monto_Total:6
										
										SAVE RECORD:C53([ACT_Boletas:181])
										
										  //SET_ClearSets (aSetsDT{$r})
									End if 
									KRL_UnloadReadOnly (->[ACT_Boletas:181])
									
								End for 
								AT_Initialize (->alACT_idsBoletasEmitidas)
								vbACT_RegistrarIDSBoletas:=False:C215
								
								If ($vr_montoEnCargos=$r_montoBoleta)
									
								Else 
									
								End if 
								
								  //retorna el id de la categoria que tenia
								RNApdo:=KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo;True:C214)
								[Personas:7]ACT_DocumentoTributario:45:=$vl_tipoDoc
								SAVE RECORD:C53([Personas:7])
								KRL_UnloadReadOnly (->[Personas:7])
								
								SET_ClearSets ("Selection")
							Else 
								CD_Dlog (0;"Registro en uso. El scrit no pudo ser ejecutado.")
							End if 
						Else 
							CANCEL TRANSACTION:C241
							CD_Dlog (0;"Montos no corresponden.")
						End if 
						
						CD_Dlog (0;"Script ejecutado.")
					Else 
						CANCEL TRANSACTION:C241
						CD_Dlog (0;"Error al ejecutar el script.")
					End if 
					
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;"Debe seleccionar 1 documento tributario tipo nota de crédito para ser anulado.")
				End if 
				
				IT_UThermometer (-2;$l_proc)
			End if 
			
			
			
		End if 
	Else 
		CD_Dlog (0;"Antes de ejecutar el script se debe configurar la categoría Nota de Débito con todas sus definiciones.")
	End if 
	
Else 
	CD_Dlog (0;"Ejecute el script desde la pestaña Documentos Tributarios, seleccionando el documento para el cual desea emitir la Nota de Débito.")
End if 
  //TRACE
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Cargos])

  //READ ONLY([ACT_Boletas])
  //READ ONLY([ACT_Transacciones])

  //C_LONGINT($l_idAviso;$l_idNuevoAC;$l_proc)
  //C_LONGINT($l_idDC;$l_idDC2)
  //C_LONGINT($l_id_boleta;$l_id_boleta2)
  //C_LONGINT($l_indice;$l_pos;$l_locked;$l_indice2;$l_indice3)
  //C_LONGINT($l_idApdo;$CatApdo;$l_numDoc)
  //C_BOOLEAN($allow;$b_hayError)
  //C_REAL(vrACT_MontoAdeudado;$r_montoOrg;$r_mmontoDoc)

  //C_BOOLEAN($b_existeEnBD)
  //C_LONGINT($vl_idBoleta;$l_folioDocRef;$l_RefCod;lACTbol_DiaVencimientoSel;$l_idBol)
  //C_TEXT($t_tipoDocAsoc;$t_RefRazon;$t_moneda)
  //C_DATE($d_refFecha)

  //ARRAY LONGINT(aQR_Longint1;0)  //recnum cargos a duplicar
  //ARRAY LONGINT(aQR_Longint2;0)  //ids Nuevos AC
  //ARRAY LONGINT(aQR_Longint3;0)  //recnum cargos
  //ARRAY LONGINT(aQR_Longint4;0)  //ids items
  //ARRAY REAL(aQR_Real1;0)  //monto

  //ARRAY LONGINT(alACT_idsCategorias;0)

  //If (Table(yBWR_currentTable)=Table(->[ACT_Boletas]))

  //$CatApdo:=-5
  //$l_numDoc:=83

  //ACTcfg_LoadConfigData (8)
  //ACTcfg_LoadConfigData (1)
  //ACTpgs_OpcionesVR ("ACT_initArrays")

  //$allow:=ACTbol_ValidaInicioEmision (1;$CatApdo;True)  //20150706 RCH
  //If ($allow)

  //C_LONGINT($l_recs;$l_resp)

  //$l_recs:=BWR_SearchRecords 
  //QUERY SELECTION([ACT_Boletas];[ACT_Boletas]codigo_SII="61";*)
  //QUERY SELECTION([ACT_Boletas]; & ;[ACT_Boletas]ID_Apoderado#0)

  //If (Records in selection([ACT_Boletas])=1)
  //$l_resp:=CD_Dlog (0;"Se emitirá una Nota de Débito asociada al documento seleccioando."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
  //If ($l_resp=1)

  //  //$t_tipoDocAsoc:="61"
  //  //$l_folioDocRef:=$l_numDoc
  //  //$l_refCod:=1
  //  //$t_refRazon:="Anula documento."
  //  //$d_refFecha:=!07-09-2016!
  //  //$l_idAviso:=75936

  //$l_idBol:=[ACT_Boletas]ID
  //$t_tipoDocAsoc:=[ACT_Boletas]codigo_SII
  //$l_folioDocRef:=[ACT_Boletas]Numero
  //$r_mmontoDoc:=[ACT_Boletas]Monto_Total
  //$l_refCod:=1
  //$t_refRazon:="Anula documento."
  //$d_refFecha:=[ACT_Boletas]FechaEmision
  //$l_numDoc:=$l_folioDocRef

  //KRL_RelateSelection (->[ACT_Transacciones]No_Boleta;->[ACT_Boletas]ID;"")
  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Transacciones]No_Comprobante;"")
  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]No_ComprobanteInterno;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")

  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-127)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-128)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-129)

  //SELECTION TO ARRAY([ACT_Cargos]Ref_Item;aQR_Longint4;[ACT_Cargos]Monto_Neto;aQR_Real1)
  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;"")
  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Documentos_de_Cargo]No_ComprobanteInterno;"")
  //SELECTION TO ARRAY([ACT_Avisos_de_Cobranza];aQR_Longint4)

  //START TRANSACTION
  //$l_proc:=IT_UThermometer (1;0;"Emitiendo documento...")
  //For ($l_indice;1;Size of array(aQR_Longint4))

  //GOTO RECORD([ACT_Avisos_de_Cobranza];aQR_Longint4{$l_indice})
  //$l_idAviso:=[ACT_Avisos_de_Cobranza]ID_Aviso

  //DUPLICATE RECORD([ACT_Avisos_de_Cobranza])
  //[ACT_Avisos_de_Cobranza]ID_Aviso:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza]ID_Aviso)
  //$l_idNuevoAC:=[ACT_Avisos_de_Cobranza]ID_Aviso
  //SAVE RECORD([ACT_Avisos_de_Cobranza])

  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=$l_idAviso)
  //LONGINT ARRAY FROM SELECTION([ACT_Documentos_de_Cargo];aQR_Longint1;"")
  //For ($l_indice2;1;Size of array(aQR_Longint1))
  //GOTO RECORD([ACT_Documentos_de_Cargo];aQR_Longint1{$l_indice2})

  //DUPLICATE RECORD([ACT_Documentos_de_Cargo])
  //$l_idDC:=[ACT_Documentos_de_Cargo]ID_Documento
  //[ACT_Documentos_de_Cargo]ID_Documento:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo]ID_Documento)
  //$l_idDC2:=[ACT_Documentos_de_Cargo]ID_Documento
  //[ACT_Documentos_de_Cargo]No_ComprobanteInterno:=$l_idNuevoAC
  //SAVE RECORD([ACT_Documentos_de_Cargo])

  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Documento_de_Cargo=$l_idDC)
  //LONGINT ARRAY FROM SELECTION([ACT_Cargos];aQR_Longint3;"")

  //For ($l_indice3;1;Size of array(aQR_Longint3))
  //GOTO RECORD([ACT_Cargos];aQR_Longint3{$l_indice3})

  //If (([ACT_Cargos]Ref_Item#-127) & ([ACT_Cargos]Ref_Item#-128) & ([ACT_Cargos]Ref_Item#-129))

  //DUPLICATE RECORD([ACT_Cargos])
  //[ACT_Cargos]ID_Documento_de_Cargo:=$l_idDC2
  //[ACT_Cargos]MontosPagados:=0
  //[ACT_Cargos]MontosPagadosMPago:=0
  //[ACT_Cargos]Saldo:=[ACT_Cargos]MontosPagados-[ACT_Cargos]Monto_Neto
  //SAVE RECORD([ACT_Cargos])

  //End if 
  //End for 
  //End for 


  //  //recalculo de AC
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=$l_idNuevoAC)
  //ACTac_Recalcular (Record number([ACT_Avisos_de_Cobranza]))

  //APPEND TO ARRAY(aQR_Longint2;$l_idNuevoAC)
  //End for 


  //  //emisión ND
  //QUERY([ACT_Boletas];[ACT_Boletas]codigo_SII=$t_tipoDocAsoc;*)
  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]Numero=$l_numDoc)
  //If (Records in selection([ACT_Boletas])=1)
  //$l_idApdo:=[ACT_Boletas]ID_Apoderado

  //QUERY([ACT_Boletas];[ACT_Boletas]ID_DctoAsociado=$l_idBol)
  //If (Records in selection([ACT_Boletas])=0)
  //C_LONGINT($l_idItem;$r;$vl_folioDT;$vl_tipoDoc)
  //C_REAL(RNApdo)
  //C_REAL($r_monto)
  //C_LONGINT($vl_idRecord)
  //C_TEXT($vt_glosa;$vt_obs)
  //C_BOOLEAN($vb_continua;$vb_mostrarThermo;$b_generaMonto0)
  //C_DATE($vd_fechaDT;vdACT_FechaPago;vdACT_FechaE)
  //C_REAL($vr_montoEnCargos;$r_montoBoleta)

  //ptrACTpgs_Table:=->[Personas]
  //ptrACTpgs_FieldID:=->[Personas]No
  //ptrACTpgs_VarRecNum:=->RNApdo
  //ptrACTpgs_FieldDT:=->[Personas]ACT_DocumentoTributario

  //$vd_fechaDT:=Current date(*)
  //$vl_folioDT:=1

  //  //emision de documentos tributarios
  //READ ONLY([ACT_Cargos])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Avisos_de_Cobranza])



  //QUERY WITH ARRAY([ACT_Avisos_de_Cobranza]ID_Aviso;aQR_Longint2)
  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]No_ComprobanteInterno;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
  //$vr_montoEnCargos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos]Monto_Neto;->[ACT_Cargos]Monto_Neto;Current date(*))


  //If ($r_mmontoDoc=$vr_montoEnCargos)
  //VALIDATE TRANSACTION

  //  //retorna el id de la categoria que tenia
  //RNApdo:=KRL_FindAndLoadRecordByIndex (ptrACTpgs_FieldID;->$l_idApdo;True)
  //$vl_tipoDoc:=ptrACTpgs_FieldDT->
  //ptrACTpgs_FieldDT->:=$CatApdo
  //SAVE RECORD(ptrACTpgs_Table->)
  //KRL_UnloadReadOnly (ptrACTpgs_Table)


  //CREATE SET([ACT_Avisos_de_Cobranza];"Selection")
  //vdACT_FechaE:=Current date(*)
  //vdACT_FEmisionBol:=vdACT_FechaE
  //vtACT_FEmisionBol:=String(vdACT_FEmisionBol)
  //f1:=1
  //f2:=0

  //i1:=0
  //i2:=1
  //  //para quien
  //e1:=1  //apoderados
  //e2:=0
  //e3:=0  //terceros
  //e4:=0  //terceros

  //  //periodos
  //h1:=0
  //  // month year
  //s1:=1
  //s2:=0
  //  // month year?
  //h2:=1
  //h3:=0  // se emite una boleta por aviso

  //vbACT_noGuardarNum:=True

  //ARRAY LONGINT(alACT_idsBoletasEmitidas;0)
  //vbACT_RegistrarIDSBoletas:=True
  //ACTbol_EMasivaDocTribs (False)

  //For ($r;1;Size of array(alACT_idsBoletasEmitidas))
  //READ WRITE([ACT_Boletas])
  //  //USE SET(aSetsDT{$r})
  //  //LOAD RECORD([ACT_Boletas])
  //KRL_FindAndLoadRecordByIndex (->[ACT_Boletas]ID;->alACT_idsBoletasEmitidas{$r};True)
  //If (Records in selection([ACT_Boletas])=1)
  //[ACT_Boletas]orden_interno:=$vl_folioDT
  //SAVE RECORD([ACT_Boletas])
  //KRL_UnloadReadOnly (->[ACT_Boletas])

  //READ ONLY([ACT_Boletas])
  //QUERY([ACT_Boletas];[ACT_Boletas]codigo_SII=$t_tipoDocAsoc;*)
  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]Numero=$l_folioDocRef)
  //If (Records in selection([ACT_Boletas])=1)
  //$b_existeEnBD:=True
  //$vl_idBoleta:=[ACT_Boletas]ID
  //Else 
  //$b_existeEnBD:=False
  //End if 
  //READ WRITE([ACT_Boletas])
  //KRL_FindAndLoadRecordByIndex (->[ACT_Boletas]ID;->alACT_idsBoletasEmitidas{$r};True)
  //If ($b_existeEnBD)
  //[ACT_Boletas]ID_DctoAsociado:=$vl_idBoleta
  //Else 
  //[ACT_Boletas]Referencia_TipoDocumento:=$t_tipoDocAsoc
  //[ACT_Boletas]Referencia_FolioDocumento:=String($l_folioDocRef)
  //[ACT_Boletas]Referencia_FechaDocumento:=$d_refFecha
  //End if 
  //[ACT_Boletas]codigo_referencia:=$l_refCod
  //[ACT_Boletas]Referencia_Razon:=$t_refRazon

  //$r_montoBoleta:=[ACT_Boletas]Monto_Total

  //SAVE RECORD([ACT_Boletas])

  //  //SET_ClearSets (aSetsDT{$r})
  //End if 
  //KRL_UnloadReadOnly (->[ACT_Boletas])

  //End for 
  //AT_Initialize (->alACT_idsBoletasEmitidas)
  //vbACT_RegistrarIDSBoletas:=False

  //If ($vr_montoEnCargos=$r_montoBoleta)

  //Else 

  //End if 

  //  //retorna el id de la categoria que tenia
  //RNApdo:=KRL_FindAndLoadRecordByIndex (ptrACTpgs_FieldID;->$l_idApdo;True)
  //ptrACTpgs_FieldDT->:=$vl_tipoDoc
  //SAVE RECORD(ptrACTpgs_Table->)
  //KRL_UnloadReadOnly (ptrACTpgs_Table)

  //SET_ClearSets ("Selection")

  //End if 

  //CD_Dlog (0;"Script ejecutado.")
  //Else 
  //CANCEL TRANSACTION
  //CD_Dlog (0;"Error al ejecutar el script.")
  //End if 


  //End if 

  //IT_UThermometer (-2;$l_proc)
  //End if 



  //End if 
  //Else 
  //CD_Dlog (0;"Antes de ejecutar el script se debe configurar la categoría Nota de Débito con todas sus definiciones.")
  //End if 

  //Else 
  //CD_Dlog (0;"Ejecute el script desde la pestaña Documentos Tributarios, seleccionando el documento para el cual desea emitir la Nota de Débito.")
  //End if 