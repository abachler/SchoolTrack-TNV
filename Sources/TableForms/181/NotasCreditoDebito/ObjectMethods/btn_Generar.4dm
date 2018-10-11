  //START TRANSACTION
C_LONGINT:C283($vl_idDocto;$vl_idRazonSocial;$vl_idCargoRelacionado)
C_BOOLEAN:C305($vb_cancelaT;$b_continua)
C_TEXT:C284($t_palabraClave1;$t_palabraClave2)
C_BLOB:C604($xBlob)
C_BOOLEAN:C305($b_errorDup)
C_LONGINT:C283($l_selecionados)  //20160609 RCH
$l_selecionados:=Count in array:C907(abACT_ItemsSeleccionado;True:C214)

$t_palabraClave1:="Donde dice"
$t_palabraClave2:="Debe decir"

Case of 
	: ((ACTdte_EsEmisorColegium ([ACT_Boletas:181]ID_RazonSocial:25)) & (atACT_referencia=0))  //20151006 RCH Se valida que se seleccione una Razón de referencia
		CD_Dlog (0;"Seleccione una Razón de Referencia.")
		
	: (Position:C15("XXX";vt_refRazon)>0)
		CD_Dlog (0;"Debe ingresar la zona a corregir en la referencia.")
		
	: (Position:C15("TEXTO_INCORRECTO";vt_refRazon)>0)
		CD_Dlog (0;"Debe ingresar el texto a corregir en la referencia.")
		
	: (Position:C15("TEXTO_CORRECTO";vt_refRazon)>0)
		CD_Dlog (0;"Debe ingresar el texto corregido en la referencia.")
		
	: (Length:C16(vt_refRazon)>90)
		vt_refRazon:=Substring:C12(vt_refRazon;1;90)
		CD_Dlog (0;__ ("El número máximo de caracteres es 90."))
		
	: (Length:C16(vt_detalleNC)>255)
		vt_detalleNC:=Substring:C12(vt_detalleNC;1;255)
		CD_Dlog (0;__ ("El número máximo de caracteres es 255."))
		
	: ((atACT_referencia=2) & (Position:C15($t_palabraClave1;vt_refRazon)=0))
		CD_Dlog (0;__ ("Para el código de referencia ^0, es obligatoria la palabra: ^1 .";atACT_referencia{atACT_referencia};ST_Qte ($t_palabraClave1)))
		
		  //: ((atACT_referencia=2) & (Find in array(atACT_DetallesNCT2;$t_palabraClave2)=-1))
	: ((atACT_referencia=2) & (Position:C15($t_palabraClave2;vt_refRazon)=0))
		CD_Dlog (0;__ ("Para el código de referencia ^0, es obligatoria la palabra: ^1.";atACT_referencia{atACT_referencia};ST_Qte ($t_palabraClave2)))
		
	: ((vr_montoTotal>0) & (atACT_referencia=0) & (vb_documentElectronico))
		CD_Dlog (0;__ ("Para los documentos electrónicos que modifican montos, se debe seleccionar la razón de referencia."))
		
	: ((vr_montoTotal>0) & (atACT_referencia=2) & (vb_documentElectronico))
		CD_Dlog (0;"La razón de referencia que corrige textos no debe tener montos.")
		
	: ((vr_montoTotal#[ACT_Boletas:181]Monto_Total:6) & (atACT_referencia=1) & (vb_documentElectronico))
		CD_Dlog (0;__ ("Cuando es una nota de crédito que anula el documento de referencia, no se puede modificar el monto del documento."))
		
		  //: ((Size of array(al_recNumsCargos)#Size of array(atACT_RecNumsCargosAgr)) & (vb_documentElectronico) & (atACT_referencia=1))  //20160512 RCH
	: ((Size of array:C274(al_recNumsCargos)#$l_selecionados) & (vb_documentElectronico) & (atACT_referencia=1))  //20160609 RCH
		CD_Dlog (0;__ ("Cuando se necesita generar una Nota de Crédito que anula el documento de referencia, se deben seleccionar todos los cargos de la lista en el Documento Tributario original."))
		
	Else 
		$b_continua:=True:C214
End case 

If ($b_continua)
	If ((vr_montoTotal>0) | (atACT_referencia=2))
		$msg:=__ ("Está seguro de querer generar una nota de crédito por un monto de ")+String:C10(vr_montoTotal;"|Despliegue_ACT_Pagos")
		If ((vr_montoDevolucion>0) & (cs_generarDevolución=1))
			$msg:=$msg+__ (" y una devolución de ")+String:C10(vr_montoDevolucion;"|Despliegue_ACT_Pagos")
		End if 
		$msg:=$msg+"."
		$resp:=CD_Dlog (0;$msg;"";__ ("Si");__ ("No"))
		If ($resp=1)
			  //If (vr_montoTotal>0)
			
			  //20140311 ASM Para seleccionar los items a incluir al emitir notas de crédito.
			ACTbol_SeleccionItemsNC ("AgregarCargosSeleccionados")
			$resp:=Num:C11(ACTbol_OpcionesDuplicacionNC ("DialogoConsulta"))
			If ($resp=1)
				
				LOG_RegisterEvt ("Inicio de emisión de Nota de Crédito a partir del D.T. tipo: "+KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->vl_idDocumentoAsociado;->[ACT_Boletas:181]TipoDocumento:7)+"(código SII: "+KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->vl_idDocumentoAsociado;->[ACT_Boletas:181]codigo_SII:33)+", id DT: "+String:C10(vl_idDocumentoAsociado)+"), folio: "+String:C10(KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->vl_idDocumentoAsociado;->[ACT_Boletas:181]Numero:11))+". Razón de referencia: "+atACT_referencia{atACT_referencia}+", por un monto de: "+String:C10(vr_montoTotal;"|Despliegue_ACT")+", para el: "+vt_fechaDcto+". Opción generar devolución "+Choose:C955(cs_generarDevolución=1;"marcada, devolución por: "+String:C10(vr_montoDevolucion;"|Despliegue_ACT");"no marcada")+". Opción duplicar deuda "+Choose:C955(cs_duplicarDeuda=1;"marcada, duplicación por: "+String:C10(vr_montoDuplicacion;"|Despliegue_ACT")+", con la opción de usar moneda original "+Choose:C955(cs_duplicarDeudaMontoOriginal=1;"marcada";"mno marcada")+".";"no marcada."))  //20171123 RCH
				
				ACTcfg_OpcionesRazonesSociales ("CargaArreglosDesdeNC";->vl_idDocumentoAsociado;->$vl_idRazonSocial)
				
				ACTcfg_ItemsMatricula ("InicializaYLee")
				$proc:=IT_UThermometer (1;0;__ ("Generando documento..."))
				$vl_idBoletaAsoc:=vl_idDocumentoAsociado
				$vrACT_MontoDesctoExento:=vr_montoExento
				$vrACT_MontoDesctoAfecto:=vr_montoAfecto
				$vrACT_MontoDesctoIVA:=vr_montoIVA
				$vd_fechaEmision:=vd_fechaDcto
				$vl_idApdo:=vl_idApdo
				$vl_idTercero:=vl_idTercero
				$t_moneda:=t_monedaDT  //20161020 RCH
				
				  //asigna categoría de documento tributario NC
				If ($vl_idApdo#0)
					$ptrTable:=->[Personas:7]
					$ptrIdTable:=->[Personas:7]No:1
					$ptrIdDocTrib:=->[Personas:7]ACT_DocumentoTributario:45
					$vl_valor:=$vl_idApdo
				Else 
					$ptrTable:=->[ACT_Terceros:138]
					$ptrIdTable:=->[ACT_Terceros:138]Id:1
					$ptrIdDocTrib:=->[ACT_Terceros:138]id_CatDocTrib:55
					$vl_valor:=$vl_idTercero
				End if 
				KRL_FindAndLoadRecordByIndex ($ptrIdTable;->$vl_valor;True:C214)
				
				If (ok=1)
					
					  //20180523 RCH Se revisa si hay descuentos no usados asociados a los cargos a considerar para emitir la NC. Ticket 203744
					  //********* USO DESCUENTOS *********
					ARRAY LONGINT:C221($al_idsCargos;0)
					ARRAY LONGINT:C221($al_recNumDctos;0)
					ARRAY LONGINT:C221($al_recNumCargos2Descontar;0)
					ARRAY LONGINT:C221($al_idsAC;0)
					C_LONGINT:C283($x;$l_idAviso)
					vdACT_FechaUF:=Current date:C33(*)
					
					CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];al_recNumsCargos;"")
					SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargos)
					QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsCargos)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
					
					If (Records in selection:C76([ACT_Cargos:173])>0)
						
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumDctos;"")
						CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];al_recNumsCargos;"")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
						
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumCargos2Descontar;"")
						CREATE EMPTY SET:C140([ACT_Transacciones:178];"$ACT_setTransPagos")
						For ($x;1;Size of array:C274($al_recNumCargos2Descontar))
							GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCargos2Descontar{$x})
							$l_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							If (Find in array:C230($al_idsAC;$l_idAviso)=-1)
								APPEND TO ARRAY:C911($al_idsAC;$l_idAviso)
							End if 
							
							ACTac_UtilizaDescuentos ($al_recNumCargos2Descontar{$x};"$ACT_setTransPagos";0;->$al_recNumDctos)
							If (Size of array:C274($al_recNumDctos)=0)
								$x:=Size of array:C274($al_recNumCargos2Descontar)
							End if 
						End for 
						ACTpgs_AsignaIDPagoEnTrans ("$ACT_setTransPagos";-2)
						
						For ($x;1;Size of array:C274($al_idsAC))
							ACTac_Recalcular (Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$al_idsAC{$x}))
						End for 
					End if 
					  //******** USO DCTOS
					
					  //20120419 RCH se introduce transaccion porque la boleta podia estar duplicada y se debe cancelar todo
					  //20120514 RCH Se introduce variable para escribir el log fuera de la transaccion
					C_TEXT:C284(vtACT_logEmisionNC)
					vtACT_logEmisionNC:=""
					START TRANSACTION:C239
					ARRAY LONGINT:C221($al_recNumsTransacciones;0)
					If (vr_montoTotal>0)
						$vb_cancelaT:=Not:C34(ACTpgs_GenCargoDesctoEspecial (->$al_recNumsTransacciones))
					Else 
						If (atACT_referencia=2)  //20141007 RCH Probar e integrar en cóndor
							
							READ ONLY:C145([ACT_Transacciones:178])
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=vl_idDocumentoAsociado)
							CREATE SET:C116([ACT_Transacciones:178];"Transacciones")
							KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
							FIRST RECORD:C50([ACT_Cargos:173])
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
							QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8#"Pago con descuento")
							
							If (Records in selection:C76([ACT_Transacciones:178])>0)
								DUPLICATE RECORD:C225([ACT_Transacciones:178])
								[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
								[ACT_Transacciones:178]Auto_UUID:17:=Generate UUID:C1066
								[ACT_Transacciones:178]MontoMonedaPago:14:=0
								[ACT_Transacciones:178]Debito:6:=0
								[ACT_Transacciones:178]Credito:7:=0
								SAVE RECORD:C53([ACT_Transacciones:178])
								APPEND TO ARRAY:C911($al_recNumsTransacciones;Record number:C243([ACT_Transacciones:178]))
								
							End if 
						End if 
					End if 
					If (Not:C34($vb_cancelaT))
						  //If (Size of array($al_recNumsTransacciones)>0)
						
						If (Size of array:C274($al_recNumsTransacciones)>0)
							READ ONLY:C145([ACT_Transacciones:178])
							GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumsTransacciones{1})
							$vl_idCargoRelacionado:=[ACT_Transacciones:178]ID_Item:3
						End if 
						
						ARRAY LONGINT:C221($al_transaccionesBol;0)
						If (Records in set:C195("FaltaIDPago")>0)
							READ WRITE:C146([ACT_Transacciones:178])
							USE SET:C118("FaltaIDPago")
							CLEAR SET:C117("FaltaIDPago")
							APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4:=-1)
							SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;$al_transaccionesBol)
							KRL_UnloadReadOnly (->[ACT_Transacciones:178])
						End if 
						
						$vr_montoTotal:=$vrACT_MontoDesctoAfecto+$vrACT_MontoDesctoExento+$vrACT_MontoDesctoIVA
						
						$cb_UtilizaMultiNum:=cb_UtilizaMultiNum
						cb_UtilizaMultiNum:=0
						$vl_identificador:=0
						
						KRL_FindAndLoadRecordByIndex ($ptrIdTable;->$vl_valor;True:C214)
						$vl_idDocto:=$ptrIdDocTrib->
						$ptrIdDocTrib->:=vlACT_IdCategoriaNC
						SAVE RECORD:C53($ptrTable->)
						
						ARRAY LONGINT:C221($al_recNumApdos;0)
						SELECTION TO ARRAY:C260($ptrTable->;$al_recNumApdos)
						ACTbol_validaInfo ("ACTbolLlenaArreglos";->$al_recNumApdos;$ptrTable;$ptrIdDocTrib)
						ACTbol_validaInfo ("ACTbolLlenaVariables";->vlACT_IdCategoriaNC;->$vl_identificador;->$vl_idRazonSocial)
						$vt_set2Print:=""
						$vl_index:=0
						
						vl_idRazonSocial:=Choose:C955((vl_idRazonSocial=0);-1;vl_idRazonSocial)
						$b_esEmisorElectCLG:=ACTdte_EsEmisorColegium (vl_idRazonSocial)
						
						ACTcfg_LeeConfRS (vl_idRazonSocial)  //20161105 RCH
						
						  //20120420 RCH Se agrega parametro vt_Observacion al llamado a ACTbol_CreateRecord
						Case of 
								  //20130729 RCH 
								  //: (<>gCountryCode="mx")
								  //$id_boleta:=ACTbol_CreateRecord (Size of array($al_transaccionesBol);$vr_montoTotal;$vd_fechaEmision;False;vl_IDCat;alACT_IDDT{vl_IndexExento};vt_DocExento;$vl_idApdo;vl_IndexExento;vt_setExento;False;$vrACT_MontoDesctoAfecto+$vrACT_MontoDesctoIVA;$vl_idTercero;vt_Observacion;vl_idRazonSocial;4;atACT_referencia)
								  //: ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array(alACT_IDsCats;vl_IDCat)}))
							: ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array:C230(alACT_IDsCats;vl_IDCat)}) | ($b_esEmisorElectCLG))
								
								
								  //$id_boleta:=ACTbol_CreateRecord (Size of array($al_transaccionesBol);$vr_montoTotal;$vd_fechaEmision;True;vl_IDCat;alACT_IDDT{vl_IndexExento};vt_DocExento;$vl_idApdo;vl_IndexExento;vt_setExento;False;$vrACT_MontoDesctoAfecto+$vrACT_MontoDesctoIVA;$vl_idTercero;vt_Observacion;vl_idRazonSocial;4;atACT_referencia)
								$id_boleta:=ACTbol_CreateRecord (Size of array:C274($al_transaccionesBol);$vr_montoTotal;$vd_fechaEmision;True:C214;vl_IDCat;alACT_IDDT{vl_IndexExento};vt_DocExento;$vl_idApdo;vl_IndexExento;vt_setExento;False:C215;$vrACT_MontoDesctoAfecto+$vrACT_MontoDesctoIVA;$vl_idTercero;vt_Observacion;vl_idRazonSocial;4;atACT_referencia;False:C215;0;$t_moneda)  //20161020 RCH
								$vt_set2Print:=vt_setExento
								$vl_index:=alACT_IDDT{vl_IndexExento}
							Else 
								If ($vrACT_MontoDesctoAfecto>0)
									  //$id_boleta:=ACTbol_CreateRecord (Size of array($al_transaccionesBol);$vr_montoTotal;$vd_fechaEmision;True;vl_IDCat;alACT_IDDT{vl_IndexAfecto};vt_DocAfecto;$vl_idApdo;vl_IndexAfecto;vt_setafecto;False;0;$vl_idTercero;vt_Observacion;vl_idRazonSocial;4;atACT_referencia)
									  //$id_boleta:=ACTbol_CreateRecord (Size of array($al_transaccionesBol);$vr_montoTotal;$vd_fechaEmision;True;vl_IDCat;alACT_IDDT{vl_IndexAfecto};vt_DocAfecto;$vl_idApdo;vl_IndexAfecto;vt_setafecto;False;$vrACT_MontoDesctoAfecto+$vrACT_MontoDesctoIVA;$vl_idTercero;vt_Observacion;vl_idRazonSocial;4;atACT_referencia)
									$id_boleta:=ACTbol_CreateRecord (Size of array:C274($al_transaccionesBol);$vr_montoTotal;$vd_fechaEmision;True:C214;vl_IDCat;alACT_IDDT{vl_IndexAfecto};vt_DocAfecto;$vl_idApdo;vl_IndexAfecto;vt_setafecto;False:C215;$vrACT_MontoDesctoAfecto+$vrACT_MontoDesctoIVA;$vl_idTercero;vt_Observacion;vl_idRazonSocial;4;atACT_referencia;False:C215;0;$t_moneda)  //20161020 RCH
									$vt_set2Print:=vt_setafecto
									$vl_index:=alACT_IDDT{vl_IndexAfecto}
								Else 
									  //$id_boleta:=ACTbol_CreateRecord (Size of array($al_transaccionesBol);$vr_montoTotal;$vd_fechaEmision;False;vl_IDCat;alACT_IDDT{vl_IndexExento};vt_DocExento;$vl_idApdo;vl_IndexExento;vt_setExento;False;$vrACT_MontoDesctoAfecto+$vrACT_MontoDesctoIVA;$vl_idTercero;vt_Observacion;vl_idRazonSocial;4;atACT_referencia)
									$id_boleta:=ACTbol_CreateRecord (Size of array:C274($al_transaccionesBol);$vr_montoTotal;$vd_fechaEmision;False:C215;vl_IDCat;alACT_IDDT{vl_IndexExento};vt_DocExento;$vl_idApdo;vl_IndexExento;vt_setExento;False:C215;$vrACT_MontoDesctoAfecto+$vrACT_MontoDesctoIVA;$vl_idTercero;vt_Observacion;vl_idRazonSocial;4;atACT_referencia;False:C215;0;$t_moneda)  //20161020 RCH
									$vt_set2Print:=vt_setExento
									$vl_index:=alACT_IDDT{vl_IndexExento}
								End if 
						End case 
						
						If ($id_boleta>0)
							  //Asocia id boleta asociada
							KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$id_boleta;True:C214)
							[ACT_Boletas:181]ID_DctoAsociado:19:=$vl_idBoletaAsoc
							[ACT_Boletas:181]Referencia_Razon:40:=vt_refRazon
							[ACT_Boletas:181]Detalle_NC:35:=ST_GetCleanString (vt_detalleNC)
							$l_offSet:=BLOB_Variables2Blob (->[ACT_Boletas:181]xDetalleNC:41;0;->atACT_DetallesNCT2)
							SAVE RECORD:C53([ACT_Boletas:181])
							KRL_UnloadReadOnly (->[ACT_Boletas:181])
							cb_UtilizaMultiNum:=$cb_UtilizaMultiNum
							
							KRL_FindAndLoadRecordByIndex ($ptrIdTable;->$vl_valor;True:C214)
							$ptrIdDocTrib->:=$vl_idDocto
							SAVE RECORD:C53($ptrTable->)
							
							ARRAY LONGINT:C221($al_idsPagos;0)
							READ WRITE:C146([ACT_Transacciones:178])
							CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$al_recNumsTransacciones;"")
							APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15:=$id_boleta)
							  //APPLY TO SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago:=([ACT_Transacciones]ID_Pago*-1))
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=0)
							APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=0)
							
							  //READ WRITE([ACT_Transacciones])
							CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$al_recNumsTransacciones;"")
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumsTransacciones;"")
							APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=-1)
							AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_Pago:4;->$al_idsPagos)
							ARRAY LONGINT:C221($al_recNum;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum)
							ACTpgs_DesasignaIdTransaccion (->$al_recNum)
							
							READ WRITE:C146([ACT_Transacciones:178])
							  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=-1)
							CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$al_recNumsTransacciones;"")
							APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=0)
							
							KRL_UnloadReadOnly (->[ACT_Transacciones:178])
							SET_ClearSets ("lockedSet")  //20110408 RCH cuando se hace un array to selection cuando no hay registros en la tabla el set no se limpia
							
							IT_UThermometer (-2;$proc)
							AL_UpdateArrays (ALP_CargosBoleta;0)
							AL_UpdateArrays (xALP_DocsInvolved;0)
							AL_UpdateArrays (xALP_DocsAsociados;0)
							
							
							If (Records in set:C195($vt_set2Print)>0)
								  //$idBoleta:=ACTbol_PrintBoletasVR ($vt_set2Print;False;$vl_index)
								SET BLOB SIZE:C606($xBlob;0)
								$al_transaccionesBol{0}:=0
								ARRAY LONGINT:C221($DA_Return;0)
								AT_SearchArray (->$al_transaccionesBol;"=";->$DA_Return)
								For ($j;Size of array:C274($DA_Return);1;-1)
									AT_Delete (0;1;->$al_transaccionesBol)
								End for 
								BLOB_Variables2Blob (->$xBlob;0;->$id_boleta;->$al_transaccionesBol)
								  //20150904 RCH. Para emitir la NC si está configurado que así sea.
								  //$idBoleta:=ACTbol_PrintBoletasVR ($vt_set2Print;False;$vl_index;False;True;0;->$xBlob)
								$idBoleta:=ACTbol_PrintBoletasVR ($vt_set2Print;False:C215;$vl_index;False:C215;True:C214;0;->$xBlob;r_generaDTEAlIngresarPago;r_abrirDTEAlIngresarPago;r_enviarDTEAlIngresarPago)
								If ($idBoleta>=0)
									ACTbol_RegisterEvt ($vt_set2Print)
									CLEAR SET:C117($vt_set2Print)
								Else 
									$vb_cancelaT:=True:C214
								End if 
							End if 
							
							ACTbol_EstadoBoleta ($id_boleta)
							
						Else 
							$vb_cancelaT:=True:C214
							vtACT_logEmisionNC:="Documento no generado."
						End if 
						
						If (Not:C34($vb_cancelaT))
							$proc:=IT_UThermometer (1;0;__ ("Recalculando Avisos de Cobranza..."))
							
							For ($i;1;Size of array:C274(alACTpgs_Avisos2Recalc))
								ACTac_Recalcular (alACTpgs_Avisos2Recalc{$i})
							End for 
							If (cs_generarDevolución=1)
								If (vr_montoDevolucion>0)
									
									IT_UThermometer (0;$proc;__ ("Generando devolución..."))
									
									If (vr_montoDevolucion>vr_MaxDevolucion)
										vr_montoDevolucion:=vr_MaxDevolucion
									End if 
									ACTbol_GeneraDevolucion (vr_montoDevolucion;->$al_idsPagos;->$id_boleta;$vl_idCargoRelacionado)
									For ($i;1;Size of array:C274(alACTpgs_Avisos2Recalc))
										ACTac_Recalcular (alACTpgs_Avisos2Recalc{$i})
									End for 
								End if 
							End if 
							ACTbol_EstadoBoleta (vl_idDocumentoAsociado)
							
							  //ahora no se cancela la transaccion si hay error al duplicar cargos.. solo se registra log y se muestra mensaje
							$b_errorDup:=(Num:C11(ACTbol_OpcionesDuplicacionNC ("DuplicaCargos"))<1)
							If ($b_errorDup)
								LOG_RegisterEvt (vtACT_logEmisionNC)
							End if 
							
							ACTbol_OpcionesGenerales ("RecalculoAvisosNC";->$vl_idApdo;->$vl_idTercero)
							
							IT_UThermometer (-2;$proc)
						End if 
						ACCEPT:C269
						  //End if 
					Else 
						IT_UThermometer (-2;$proc)
						If (vtACT_logEmisionNC="")
							vtACT_logEmisionNC:="No fue posible encontrar los cargos asociados al documento a emitir."
						End if 
					End if 
					If (In transaction:C397)
						  //20150624 RCH agrego validacion para asegurarme que la NC se emiten correctas
						If (Not:C34($vb_cancelaT))
							  //$vb_cancelaT:=Not(ACTbol_ValidaEmisionDT ($id_boleta)) //20150813 RCH Ahora se hace en ACTbol_PrintBoletasVR
						End if 
						
						If ($vb_cancelaT)
							CANCEL TRANSACTION:C241
							If (vtACT_logEmisionNC#"")
								LOG_RegisterEvt (vtACT_logEmisionNC)
							End if 
							CD_Dlog (0;__ ("Se ha producido un error. No es posible emitir el documento."))
						Else 
							VALIDATE TRANSACTION:C240
							
							If ($b_errorDup)
								CD_Dlog (0;__ ("Se ha producido un error en la duplicación de cargos. Error: ^0");vtACT_logEmisionNC)
							End if 
						End if 
					End if 
					vtACT_logEmisionNC:=""
				Else 
					CD_Dlog (0;__ ("El registro del responsable asociado se encuentra en uso.")+" "+__ ("Por favor intente más tarde."))
				End if 
				KRL_UnloadReadOnly ($ptrTable)
			End if 
			  //Else 
			  //CD_Dlog (0;__ ("Se produjo un problema durante la emisión."))
			  //End if 
		End if 
	Else 
		BEEP:C151
	End if 
End if 