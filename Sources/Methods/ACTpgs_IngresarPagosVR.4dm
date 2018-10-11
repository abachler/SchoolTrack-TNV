//%attributes = {}
TRACE:C157
  //  //ACTpgs_IngresarPagosVR
  //
  //Grabar:=True
  //$SerieDuplicada:=False
  //$FaltanDatos:=False
  //$FormadePago:=$1
  //
  //If (vrACT_MontoAPagar>0)
  //If (vrACT_MontoPago>0)
  //Case of 
  //
  //: ($FormadePago=1)
  //
  //: ($FormadePago=2)
  //If ((vtACT_BancoNombre="") | (vtACT_BancoCuenta="") | (vtACT_NoSerie="") | (vdACT_FechaDocumento=!00-00-00!))
  //Grabar:=False
  //$FaltanDatos:=True
  //End if 
  //If (Not($FaltanDatos))
  //SET QUERY DESTINATION(Into variable;$duplicados)
  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]Ch_BancoCodigo=vtACT_BancoCodigo;*)
  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Ch_Cuenta=vtACT_BancoCuenta;*)
  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]NoSerie=vtACT_NoSerie)
  //SET QUERY DESTINATION(Into current selection)
  //
  //If ($duplicados>0)
  //Grabar:=False
  //$SerieDuplicada:=True
  //End if 
  //End if 
  //: ($FormadePago=3)
  //If ((vtACT_TCTipo="") | (vtACT_TCNumero="") | (vtACT_TCTitular="") | (vtACT_TCRUTTitular="") | (vtACT_TCMesVencimiento="") | (vtACT_TCAgnoVencimiento="") | (vtACT_TCBancoEmisor="") | (vtACT_TCDocumento=""))
  //Grabar:=False
  //$FaltanDatos:=True
  //End if 
  //
  //: ($FormadePago=4)
  //If (vtACT_RDocumento="")
  //Grabar:=False
  //$FaltanDatos:=True
  //End if 
  //: ($FormadePago=5)
  //If ((vdACT_LFechaEmision=!00-00-00!) | (vdACT_LFechaVencimiento=!00-00-00!) | (vtACT_LTitular="") | (vtACT_LRUTTitular=""))
  //Grabar:=False
  //$FaltanDatos:=True
  //End if 
  //End case 
  //
  //If (Grabar)
  //CREATE RECORD([ACT_Documentos_de_Pago])
  //[ACT_Documentos_de_Pago]ID:=SQ_SeqNumber (->[ACT_Documentos_de_Pago]ID)
  //[ACT_Documentos_de_Pago]ID_Apoderado:=-1
  //[ACT_Documentos_de_Pago]Tipodocumento:=vsACT_FormasdePago
  //[ACT_Documentos_de_Pago]ID_AvisodeCobranza:=0
  //[ACT_Documentos_de_Pago]FechaPago:=vdACT_FechaPago
  //[ACT_Documentos_de_Pago]MontoPago:=vrACT_MontoPago
  //
  //Case of 
  //: ($FormadePago=1)  //Efectivo
  //: ($FormadePago=2)  //Cheque
  //[ACT_Documentos_de_Pago]Ch_BancoNombre:=vtACT_BancoNombre
  //[ACT_Documentos_de_Pago]Ch_BancoCodigo:=vtACT_BancoCodigo
  //[ACT_Documentos_de_Pago]Ch_Cuenta:=vtACT_BancoCuenta
  //[ACT_Documentos_de_Pago]Fecha:=vdACT_FechaDocumento
  //[ACT_Documentos_de_Pago]NoSerie:=vtACT_NoSerie
  //[ACT_Documentos_de_Pago]RUTTitular:=vtACT_BancoRUTTitular
  //[ACT_Documentos_de_Pago]Titular:=vtACT_BancoTitular
  //[ACT_Documentos_de_Pago]En_cartera:=True
  //[ACT_Documentos_de_Pago]Depositado:=False
  //
  //: ($FormadePago=3)  //Tarjeta de credito
  //[ACT_Documentos_de_Pago]TC_Tipo:=vtACT_TCTipo
  //[ACT_Documentos_de_Pago]TC_Numero:=vtACT_TCNumero
  //[ACT_Documentos_de_Pago]TC_Codigo:=vtACT_TCCodigo
  //[ACT_Documentos_de_Pago]TC_Titular:=vtACT_TCTitular
  //[ACT_Documentos_de_Pago]TC_RUTTitular:=vtACT_TCRUTTitular
  //[ACT_Documentos_de_Pago]TC_MesVencimiento:=vtACT_TCMesVencimiento
  //[ACT_Documentos_de_Pago]AgnoVencimiento:=vtACT_TCAgnoVencimiento
  //[ACT_Documentos_de_Pago]TC_BancoEmisor:=vtACT_TCBancoEmisor
  //[ACT_Documentos_de_Pago]TC_BancoCodigo:=vtACT_TCBancoCodigo
  //[ACT_Documentos_de_Pago]TC_NoDocumento:=vtACT_TCDocumento
  //
  //: ($FormadePago=4)  //Redcompra
  //[ACT_Documentos_de_Pago]R_NoDocumento:=vtACT_RDocumento
  //
  //: ($FormadePago=5)  //Letra
  //[ACT_Documentos_de_Pago]L_Estado:=""
  //[ACT_Documentos_de_Pago]L_FechaEmision:=vdACT_LFechaEmision
  //[ACT_Documentos_de_Pago]L_FechaProtesto:=!00-00-00!
  //[ACT_Documentos_de_Pago]FechaVencimiento:=vdACT_LFechaVencimiento
  //[ACT_Documentos_de_Pago]L_NoDocumento:=vtACT_LDocumento
  //[ACT_Documentos_de_Pago]L_RUTTitular:=vtACT_LRUTTitular
  //[ACT_Documentos_de_Pago]L_Indice:=vtACT_LTitular
  //[ACT_Documentos_de_Pago]En_cartera:=True
  //[ACT_Documentos_de_Pago]Depositado:=False
  //
  //End case 
  //
  //  //Creacion del Pago
  //
  //CREATE RECORD([ACT_Pagos])
  //[ACT_Pagos]ID:=SQ_SeqNumber (->[ACT_Pagos]ID)
  //[ACT_Pagos]IngresadoPor:=<>tUSR_RelatedTableUserName
  //[ACT_Pagos]IngresadoPor:=<>tUSR_RelatedTableUserName
  //[ACT_Pagos]Fecha:=vdACT_FechaPago
  //[ACT_Pagos]ID_Apoderado:=-1
  //[ACT_Pagos]ID_AvisoDeCobranza:=0
  //[ACT_Pagos]ID_DocumentodePago:=[ACT_Documentos_de_Pago]ID
  //[ACT_Pagos]ID_Boleta:=0
  //[ACT_Pagos]Monto_Pagado:=vrACT_MontoPago
  //[ACT_Pagos]FormaDePago:=vsACT_FormasdePago
  //[ACT_Pagos]Venta_Rapida:=True
  //BLOB_Variables2Blob (->[ACT_Pagos]xItemsVentaRapida;0;->alACT_CantidadVVR;->atACT_GlosaVVR;->arACT_TotalVVR;->abACT_AfectoIVAVVR)
  //
  //  //creación del documento en cartera de ser necesario
  //Case of 
  //
  //: ($FormadePago=2)  //cheque
  //CREATE RECORD([ACT_Documentos_en_Cartera])
  //[ACT_Documentos_en_Cartera]ID:=SQ_SeqNumber (->[ACT_Documentos_en_Cartera]ID)
  //[ACT_Documentos_en_Cartera]ID_Apoderado:=-1
  //[ACT_Documentos_en_Cartera]ID_DocdePago:=[ACT_Documentos_de_Pago]ID
  //[ACT_Documentos_en_Cartera]Tipo_Doc:=[ACT_Documentos_de_Pago]Tipodocumento
  //[ACT_Documentos_en_Cartera]Fecha_Doc:=[ACT_Documentos_de_Pago]Fecha
  //[ACT_Documentos_en_Cartera]Numero_Doc:=[ACT_Documentos_de_Pago]NoSerie
  //[ACT_Documentos_en_Cartera]Monto_Doc:=[ACT_Documentos_de_Pago]MontoPago
  //[ACT_Documentos_en_Cartera]Ubicacion_Doc:="En Cartera"
  //[ACT_Documentos_en_Cartera]Estado:=[ACT_Documentos_de_Pago]Estado
  //[ACT_Documentos_en_Cartera]Fecha_Vencimiento:=[ACT_Documentos_en_Cartera]Fecha_Doc+60
  //[ACT_Documentos_en_Cartera]Ch_Protestadoel:=!00-00-00!
  //[ACT_Documentos_en_Cartera]Ch_Depositardesde:=[ACT_Documentos_en_Cartera]Fecha_Doc
  //[ACT_Documentos_en_Cartera]Ch_Depositarhasta:=[ACT_Documentos_en_Cartera]Fecha_Vencimiento-1
  //
  //: ($FormadePago=5)  //letra
  //CREATE RECORD([ACT_Documentos_en_Cartera])
  //[ACT_Documentos_en_Cartera]ID:=SQ_SeqNumber (->[ACT_Documentos_en_Cartera]ID)
  //[ACT_Documentos_en_Cartera]ID_Apoderado:=-1
  //[ACT_Documentos_en_Cartera]ID_DocdePago:=[ACT_Documentos_de_Pago]ID
  //[ACT_Documentos_en_Cartera]Fecha_Doc:=[ACT_Documentos_de_Pago]L_FechaEmision
  //[ACT_Documentos_en_Cartera]Fecha_Vencimiento:=[ACT_Documentos_de_Pago]FechaVencimiento
  //[ACT_Documentos_en_Cartera]Monto_Doc:=[ACT_Documentos_de_Pago]MontoPago
  //[ACT_Documentos_en_Cartera]Tipo_Doc:=[ACT_Documentos_de_Pago]Tipodocumento
  //[ACT_Documentos_en_Cartera]Ubicacion_Doc:="En Cartera"
  //[ACT_Documentos_en_Cartera]Numero_Doc:=[ACT_Documentos_de_Pago]L_NoDocumento
  //
  //End case 
  //
  //SAVE RECORD([ACT_Documentos_en_Cartera])
  //SAVE RECORD([ACT_Pagos])
  //SAVE RECORD([ACT_Documentos_de_Pago])
  //ACTdc_EstadoCheque 
  //If (AT_GetSumArray (->arACT_DescuentoVVR)>0)
  //$event:="Aplicación de descuento en caja de "+String(AT_GetSumArray (->arACT_DescuentoVVR))+"  por venta rápida."
  //LOG_RegisterEvt ($event;Table(->[ACT_Pagos]);[ACT_Pagos]ID)
  //End if 
  //
  //  //  `Creacion de las boletas si asi esta definido en la preferencias
  //fUnaBoleta:=1
  //fUnaBoletaporDocumento:=0
  //cb_UnRecibo:=1
  //cb_UnReciboporPago:=0
  //ACTpgs_EmitirBoletasVR (Record number([ACT_Pagos]))
  //
  //UNLOAD RECORD([ACT_Documentos_en_Cartera])
  //READ ONLY([ACT_Documentos_en_Cartera])
  //UNLOAD RECORD([ACT_Pagos])
  //READ ONLY([ACT_Pagos])
  //UNLOAD RECORD([ACT_Documentos_de_Pago])
  //READ ONLY([ACT_Documentos_de_Pago])
  //$event:="Venta rápida de "+String(vrACT_MontoPago)+"."
  //LOG_RegisterEvt ($event;Table(->[ACT_Pagos]);[ACT_Pagos]ID)
  //ACTpgs_ClearDlogVarsVR 
  //atACT_FormasdePago:=1
  //vsACT_FormasdePago:=atACT_FormasdePago{atACT_FormasdePago}
  //FORM GOTO PAGE(1)
  //IT_SetButtonState (False;->bFormasdePago;->bIngresarPago)
  //FLUSH BUFFERS
  //End if 
  //Else 
  //ACTpgs_ClearDlogVarsVR 
  //atACT_FormasdePago:=1
  //vsACT_FormasdePago:=atACT_FormasdePago{atACT_FormasdePago}
  //FORM GOTO PAGE(1)
  //IT_SetButtonState (False;->bFormasdePago;->bIngresarPago)
  //End if 
  //If ($FaltanDatos)
  //CD_Dlog (0;__ ("Faltan datos para completar el pago."))
  //End if 
  //If ($SerieDuplicada)
  //CD_Dlog (0;__ ("Para este banco y cuenta, ya existe un cheque con ese número de serie."))
  //GOTO OBJECT(vtACT_NoSerie)
  //End if 
  //End if 