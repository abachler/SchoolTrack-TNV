//%attributes = {}
TRACE:C157
  //  //ACTdev_IngresaPagos
  //
  //
  //  //Declaraciones (ABK 2011/01/08)
  //ARRAY LONGINT(alACT_IDPagosRegenerados;0)
  //  // Fin declaraciones (ABK 2011/01/08)
  //
  //
  //$FormadePago:=$1
  //
  //If (vrACT_MontoPago>0)
  //KRL_ReloadAsReadOnly (->[Personas])
  //ARRAY LONGINT(aIDs;0)
  //If (vrACT_MontoAdeudado>0)
  //ACTpgs_CreaCargoDesctoEspecial (alACT_RecNumsAvisos{1})
  //ACTpgs_LLenaBlobCargosAviso (False)
  //ACTpgs_ReconstruyeArreglosCargo 
  //$MontoPagado:=ACTpgs_AsignaPagoACargos 
  //UNLOAD RECORD([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //ACTpgs_CreacionDocdePago ($FormadePago)
  //ACTpgs_CreacionPago ($MontoPagado)
  //AT_Insert (1;1;->alACT_IDPagosRegenerados)
  //alACT_IDPagosRegenerados{1}:=[ACT_Pagos]ID
  //ACTpgs_CreacionDocCartera ($FormadePago)
  //If (vrACT_MontoDescto>0)
  //$event:="Aplicación de descuento en caja de "+String(vrACT_MontoDescto)+" a "+[Personas]Apellidos_y_nombres+"."
  //LOG_RegisterEvt ($event;Table(->[ACT_Pagos]);[ACT_Pagos]ID)
  //End if 
  //  //Asignacion de ID_Pago a las transacciones creadas en ACTpgs_AsignaPagoACargos
  //ARRAY LONGINT(aIDs;Records in set("FaltaIDPago"))
  //AT_Populate (->aIDs;->IDParaTrans)
  //
  //READ ONLY([ACT_Cargos])
  //READ WRITE([ACT_Transacciones])
  //USE SET("FaltaIDPago")
  //ARRAY TO SELECTION(aIDs;[ACT_Transacciones]ID_Pago)
  //ARRAY LONGINT($alACT_TransaccionesaPago;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Transacciones];$alACT_TransaccionesaPago;"")
  //CREATE EMPTY SET([ACT_Transacciones];"SacaNoBoleta")
  //For ($t;1;Size of array($alACT_TransaccionesaPago))
  //GOTO RECORD([ACT_Transacciones];$alACT_TransaccionesaPago{$t})
  //$idCargo:=[ACT_Transacciones]ID_Item
  //PUSH RECORD([ACT_Transacciones])
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=$idCargo;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]ID_Pago=0;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]No_Boleta#0)
  //$id_boleta:=[ACT_Transacciones]No_Boleta
  //QUERY([ACT_Cargos];[ACT_Cargos]ID=$idCargo)
  //If ([ACT_Cargos]Saldo=0)
  //CREATE SET([ACT_Transacciones];"TransDelCargo")
  //UNION("SacaNoBoleta";"TransDelCargo";"SacaNoBoleta")
  //End if 
  //POP RECORD([ACT_Transacciones])
  //ONE RECORD SELECT([ACT_Transacciones])
  //If ($id_boleta#0)
  //[ACT_Transacciones]No_Boleta:=$id_boleta
  //SAVE RECORD([ACT_Transacciones])
  //ACTbol_EstadoBoleta ($id_boleta)
  //End if 
  //End for 
  //USE SET("SacaNoBoleta")
  //APPLY TO SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Boleta:=0)
  //SET_ClearSets ("SacaNoBoleta";"TransDelCargo")
  //UNLOAD RECORD([ACT_Transacciones])
  //READ ONLY([ACT_Transacciones])
  //Else 
  //ACTpgs_CreacionDocdePago ($FormadePago)
  //ACTpgs_CreacionPago (vrACT_MontoPago)
  //AT_Insert (1;1;->alACT_IDPagosRegenerados)
  //alACT_IDPagosRegenerados{1}:=[ACT_Pagos]ID
  //ACTpgs_CreacionDocCartera ($FormadePago)
  //End if 
  //UNLOAD RECORD([ACT_Documentos_en_Cartera])
  //READ ONLY([ACT_Documentos_en_Cartera])
  //UNLOAD RECORD([ACT_Pagos])
  //READ ONLY([ACT_Pagos])
  //UNLOAD RECORD([ACT_Documentos_de_Pago])
  //READ ONLY([ACT_Documentos_de_Pago])
  //AT_Initialize (->aIDs)
  //CLEAR SET("FaltaIDPago")
  //$event:="Ingreso de Pago con "+vsACT_FormasdePago+" de "+String(vrACT_MontoPago)+" de "+vsACT_NomApellido+"."
  //LOG_RegisterEvt ($event;Table(->[ACT_Pagos]);[ACT_Pagos]ID)
  //ACTpgs_ClearDlogVars 
  //vrACT_MontoPago:=0
  //vsACT_RUTApoderado:=""
  //atACT_FormasdePago:=1
  //vsACT_FormasdePago:=atACT_FormasdePago{atACT_FormasdePago}
  //Else 
  //ACTpgs_ClearDlogVars 
  //vrACT_MontoPago:=0
  //vsACT_RUTApoderado:=""
  //atACT_FormasdePago:=1
  //vsACT_FormasdePago:=atACT_FormasdePago{atACT_FormasdePago}
  //End if 