//%attributes = {}
  //ACTdev_AnularPagos

  //$Abort:=False
  //If (Records in selection([ACT_Pagos])>0)
  //ARRAY LONGINT($aRecNumPagos;0)
  //ARRAY LONGINT($aIDApdosPagos;0)
  //SELECTION TO ARRAY([ACT_Pagos];$aRecNumPagos;[ACT_Pagos]ID_Apoderado;$aIDApdosPagos)
  //$lockedDocdePago:=True
  //$lockedDocenCartera:=False
  //$lockedCargos:=False
  //$lockedDocdeCargo:=False
  //$lockedPago:=True
  //$lockedAviso:=False
  //
  //For ($i;1;Size of array($aRecNumPagos))
  //READ WRITE([ACT_Pagos])
  //READ WRITE([ACT_Documentos_de_Pago])
  //GOTO RECORD([ACT_Pagos];$aRecNumPagos{$i})
  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]ID=[ACT_Pagos]ID_DocumentodePago)
  //$lockedDocdePago:=Locked([ACT_Documentos_de_Pago])
  //  `If (Not([ACT_Documentos_de_Pago]Depositado))
  //If (Not([ACT_Pagos]Venta_Rapida))
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Pago=[ACT_Pagos]ID)
  //ARRAY LONGINT($aRecNumTransacciones;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Transacciones];$aRecNumTransacciones;"")
  //For ($j;1;Size of array($aRecNumTransacciones))
  //GOTO RECORD([ACT_Transacciones];$aRecNumTransacciones{$j})
  //READ WRITE([ACT_Cargos])
  //$Cargo:=Find in field([ACT_Cargos]ID;[ACT_Transacciones]ID_Item)
  //If ($Cargo#-1)
  //GOTO RECORD([ACT_Cargos];$Cargo)
  //$lockedCargos:=Locked([ACT_Cargos])
  //If ([ACT_Cargos]Monto_Neto<0)
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+[ACT_Transacciones]Credito+[ACT_Transacciones]Debito
  //Else 
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados-[ACT_Transacciones]Debito-[ACT_Transacciones]Credito
  //End if 
  //[ACT_Cargos]Saldo:=[ACT_Cargos]MontosPagados-[ACT_Cargos]Monto_Neto
  //If (Current date(*)>=[ACT_Cargos]Fecha_de_Vencimiento)
  //[ACT_Cargos]Monto_Vencido:=(Abs([ACT_Cargos]Monto_Neto)-[ACT_Cargos]MontosPagados)*-1
  //Else 
  //[ACT_Cargos]Monto_Vencido:=0
  //End if 
  //SAVE RECORD([ACT_Cargos])
  //GOTO RECORD([ACT_Transacciones];$aRecNumTransacciones{$j})
  //READ WRITE([ACT_Documentos_de_Cargo])
  //$DocdeCargo:=Find in field([ACT_Documentos_de_Cargo]ID_Documento;[ACT_Cargos]ID_Documento_de_Cargo)
  //If ($DocdeCargo#-1)
  //GOTO RECORD([ACT_Documentos_de_Cargo];$DocdeCargo)
  //$lockedDocdeCargo:=Locked([ACT_Documentos_de_Cargo])
  //If ([ACT_Cargos]Monto_Neto<0)
  //[ACT_Documentos_de_Cargo]Pagos:=[ACT_Documentos_de_Cargo]Pagos+[ACT_Transacciones]Credito+[ACT_Transacciones]Debito
  //Else 
  //[ACT_Documentos_de_Cargo]Pagos:=[ACT_Documentos_de_Cargo]Pagos-[ACT_Transacciones]Debito-[ACT_Transacciones]Credito
  //End if 
  //[ACT_Documentos_de_Cargo]Saldo:=[ACT_Documentos_de_Cargo]Pagos-[ACT_Documentos_de_Cargo]Monto_Neto
  //SAVE RECORD([ACT_Documentos_de_Cargo])
  //$Aviso:=Find in field([ACT_Avisos_de_Cobranza]ID_Aviso;[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
  //If ($Aviso#-1)
  //READ WRITE([ACT_Avisos_de_Cobranza])
  //GOTO RECORD([ACT_Avisos_de_Cobranza];$Aviso)
  //$lockedAviso:=Locked([ACT_Avisos_de_Cobranza])
  //If ([ACT_Cargos]Monto_Neto<0)
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-[ACT_Transacciones]Debito-[ACT_Transacciones]Credito
  //Else 
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar+[ACT_Transacciones]Credito+[ACT_Transacciones]Debito
  //End if 
  //SAVE RECORD([ACT_Avisos_de_Cobranza])
  //End if 
  //End if 
  //End if 
  //End for 
  //READ WRITE([ACT_Documentos_en_Cartera])
  //$DocenCartera:=Find in field([ACT_Documentos_en_Cartera]ID_DocdePago;[ACT_Documentos_de_Pago]ID)
  //If ($DocenCartera#-1)
  //GOTO RECORD([ACT_Documentos_en_Cartera];$DocenCartera)
  //$lockedDocenCartera:=Locked([ACT_Documentos_en_Cartera])
  //DELETE RECORD([ACT_Documentos_en_Cartera])
  //End if 
  //READ WRITE([ACT_Transacciones])
  //For ($trans;1;Size of array($aRecNumTransacciones))
  //GOTO RECORD([ACT_Transacciones];$aRecNumTransacciones{$trans})
  //$idItem:=[ACT_Transacciones]ID_Item
  //$idBoleta:=[ACT_Transacciones]No_Boleta
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=$idItem;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]No_Boleta=0)
  //[ACT_Transacciones]No_Boleta:=$idBoleta
  //SAVE RECORD([ACT_Transacciones])
  //End for 
  //CREATE SELECTION FROM ARRAY([ACT_Transacciones];$aRecNumTransacciones)
  //DELETE SELECTION([ACT_Transacciones])
  //$tomadosTransacciones:=Records in set("LockedSet")
  //  `[ACT_Documentos_de_Pago]Nulo:=True
  //  `[ACT_Documentos_de_Pago]Depositado:=False
  //  `SAVE RECORD([ACT_Documentos_de_Pago])
  //DELETE RECORD([ACT_Documentos_de_Pago])
  //  `[ACT_Pagos]Nulo:=True
  //  `[ACT_Pagos]Saldo:=0
  //  `SAVE RECORD([ACT_Pagos])
  //DELETE RECORD([ACT_Pagos])
  //$lockedPago:=Locked([ACT_Pagos])
  //If (Not($lockedPago) & (Not($lockedDocdePago)) & (Not($lockedCargos)) & (Not($lockedDocdeCargo)) & (Not($lockedDocenCartera)) & Not($lockedAviso) & ($tomadosTransacciones=0))
  //Else 
  //$Abort:=True
  //$msg:="En este momento existen pagos en uso. La selección no puede ser anulada."
  //$i:=Size of array($aRecNumPagos)+1
  //End if 
  //End if 
  //  `End if 
  //READ ONLY([ACT_Pagos])
  //READ ONLY([ACT_Transacciones])
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //UNLOAD RECORD([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Documentos_en_Cartera])
  //UNLOAD RECORD([ACT_Avisos_de_Cobranza])
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //End for 
  //If (Not($Abort))
  //READ WRITE([ACT_Avisos_de_Cobranza])
  //QUERY WITH ARRAY([ACT_Transacciones]ID_Apoderado;$aIDApdosPagos)
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Comprobante#0)
  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Transacciones]No_Comprobante;"")
  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Monto_a_Pagar>0)
  //ARRAY LONGINT($aAvisos;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];$aAvisos)
  //For ($v;1;Size of array($aAvisos))
  //GOTO RECORD([ACT_Avisos_de_Cobranza];$aAvisos{$v})
  //If (Not(Locked([ACT_Avisos_de_Cobranza])))
  //ACTac_Prepagar (Record number([ACT_Avisos_de_Cobranza]))
  //Else 
  //BM_CreateRequest ("ACT_PrepagaAviso";String([ACT_Avisos_de_Cobranza]ID_Aviso))
  //End if 
  //End for 
  //UNLOAD RECORD([ACT_Avisos_de_Cobranza])
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //End if 
  //End if 