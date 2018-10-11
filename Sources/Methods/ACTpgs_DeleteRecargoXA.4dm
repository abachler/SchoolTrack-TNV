//%attributes = {}
  //ACTpgs_DeleteRecargoXA

  //ahora se usa el nuevo método ACTpgs_CalculaDesctoRXA

  //$set:="RecordSet_Table"+String(Table(->[ACT_Avisos_de_Cobranza]))+"_TempIE"
  //If (Records in set($set)>0)
  //USE SET($set)
  //$set:=$set+"2"
  //CREATE SET([ACT_Avisos_de_Cobranza];$set)
  //ACTmnu_calculaMontoRecargoXA (!00-00-00!;False)
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //
  //ARRAY LONGINT(al_rNCargosRA;0)
  //ARRAY LONGINT(al_idRefItemRA;0)
  //ARRAY LONGINT(al_rNAvisosCRA;0)
  //ARRAY LONGINT(alACT_RecNumsCargos;0)
  //ARRAY DATE(adACT_CFechaVencimiento;0)
  //C_LONGINT($vl_rNDctoCargo1;$rnAviso1)
  //C_LONGINT($vl_idTransaccion;$vl_idPago)
  //C_REAL($saldoTransaccion)
  //C_TEXT($modoPago)
  //C_BOOLEAN($vb_utilizarIdT)
  //C_REAL($montoAviso)
  //
  //
  //If (Records in set($set)>0)
  //USE SET($set)
  //SELECTION TO ARRAY([ACT_Avisos_de_Cobranza];al_rNAvisosCRA)
  //
  //For ($j;1;Size of array(al_rNAvisosCRA))
  //GOTO RECORD([ACT_Avisos_de_Cobranza];al_rNAvisosCRA{$j})
  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]No_ComprobanteInterno;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
  //$montoAviso:=Sum([ACT_Cargos]Saldo)
  //
  //If ($montoAviso#0)
  //CREATE SET([ACT_Cargos];"cargosDelAviso")
  //SELECTION TO ARRAY([ACT_Cargos];al_rNCargosRA;[ACT_Cargos]Ref_Item;al_idRefItemRA)
  //
  //al_idRefItemRA{0}:=vl_idIE  `el id del ítem de recargo por adelantado cargado en ACTpgs_LoadCargosEspeciales(2)
  //AT_SearchArray (->al_idRefItemRA;"=")
  //For ($i;1;Size of array(DA_Return))
  //READ WRITE([ACT_Cargos])
  //GOTO RECORD([ACT_Cargos];al_rNCargosRA{DA_Return{$i}})
  //If ([ACT_Cargos]Monto_Neto#vr_montoIE)
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_Documento=[ACT_Cargos]ID_Documento_de_Cargo)
  //$vl_rNDctoCargo1:=Record number([ACT_Documentos_de_Cargo])
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
  //$rnAviso1:=Record number([ACT_Avisos_de_Cobranza])
  //
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]ID_Pago>0)
  //$vl_idTransaccion:=[ACT_Transacciones]ID_Transaccion
  //$vl_idPago:=[ACT_Transacciones]ID_Pago
  //$saldoTransaccion:=[ACT_Transacciones]Debito
  //DELETE RECORD([ACT_Transacciones])
  //SAVE RECORD([ACT_Transacciones])
  //
  //QUERY([ACT_Pagos];[ACT_Pagos]ID=$vl_idPago)
  //$modoPago:=[ACT_Pagos]FormaDePago
  //$fechaPago:=[ACT_Pagos]Fecha
  //$vb_utilizarIdT:=True
  //
  //[ACT_Cargos]Monto_Neto:=ACTut_retornaValorEnMoneda (1;vr_montoIE;[ACT_Cargos]Moneda)
  //[ACT_Cargos]Monto_Bruto:=ACTut_retornaValorEnMoneda (1;vr_montoIE;[ACT_Cargos]Moneda)
  //[ACT_Cargos]Monto_Moneda:=vr_montoIE
  //[ACT_Cargos]Saldo:=0-[ACT_Cargos]Monto_Neto
  //[ACT_Cargos]MontosPagados:=0
  //SAVE RECORD([ACT_Cargos])
  //
  //If ($saldoTransaccion>0)
  //
  //USE SET("cargosDelAviso")
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
  //ORDER BY([ACT_Cargos];[ACT_Cargos]Saldo;>)
  //SELECTION TO ARRAY([ACT_Cargos];alACT_RecNumsCargos)
  //
  //For ($r;1;Size of array(alACT_RecNumsCargos))
  //READ WRITE([ACT_Cargos])
  //READ WRITE([ACT_Transacciones])
  //READ WRITE([ACT_Avisos_de_Cobranza])
  //
  //GOTO RECORD([ACT_Avisos_de_Cobranza];al_rNAvisosCRA{$j})
  //GOTO RECORD([ACT_Cargos];alACT_RecNumsCargos{$r})
  //$rnAviso:=Record number([ACT_Avisos_de_Cobranza])
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_Documento=[ACT_Cargos]ID_Documento_de_Cargo)
  //$vl_rNDctoCargo:=Record number([ACT_Documentos_de_Cargo])
  //If ($saldoTransaccion>0)
  //Case of 
  //: (Abs([ACT_Cargos]Saldo)>=$saldoTransaccion)
  //If ($vb_utilizarIdT)
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]ID_Pago=$vl_idPago)
  //[ACT_Transacciones]Debito:=[ACT_Transacciones]Debito+$saldoTransaccion
  //SAVE RECORD([ACT_Transacciones])
  //
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Transaccion=$vl_idTransaccion)
  //DELETE RECORD([ACT_Transacciones])
  //SAVE RECORD([ACT_Transacciones])
  //
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+$saldoTransaccion
  //[ACT_Cargos]Saldo:=[ACT_Cargos]Saldo+$saldoTransaccion
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-$saldoTransaccion
  //SAVE RECORD([ACT_Avisos_de_Cobranza])
  //SAVE RECORD([ACT_Cargos])
  //
  //$r:=Size of array(alACT_RecNumsCargos)
  //$saldoTransaccion:=0
  //$vb_utilizarIdT:=False
  //Else 
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+$saldoTransaccion
  //[ACT_Cargos]Saldo:=[ACT_Cargos]Saldo+$saldoTransaccion
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-$saldoTransaccion
  //
  //SAVE RECORD([ACT_Avisos_de_Cobranza])
  //SAVE RECORD([ACT_Cargos])
  //
  //ACTpgs_CreateTransaction ([ACT_Cargos]ID_CuentaCorriente;[ACT_Cargos]ID;$fechaPago;$saldoTransaccion;"Pago con "+$modoPago;[ACT_Avisos_de_Cobranza]ID_Aviso;[ACT_Cargos]ID_Apoderado;String([ACT_Cargos]Mes;"00")+String([ACT_Cargos]Año;"0000");"";$vl_idPago)
  //
  //$r:=Size of array(alACT_RecNumsCargos)
  //$saldoTransaccion:=0
  //$vb_utilizarIdT:=False
  //End if 
  //: (Abs([ACT_Cargos]Saldo)<$saldoTransaccion)
  //If ($vb_utilizarIdT)
  //$saldoTransaccion:=$saldoTransaccion+[ACT_Cargos]Saldo
  //
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]ID_Pago=$vl_idPago)
  //[ACT_Transacciones]Debito:=[ACT_Transacciones]Debito+Abs([ACT_Cargos]Saldo)
  //SAVE RECORD([ACT_Transacciones])
  //
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+Abs([ACT_Cargos]Saldo)
  //[ACT_Cargos]Saldo:=[ACT_Cargos]Saldo+Abs([ACT_Cargos]Saldo)
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-Abs([ACT_Cargos]Saldo)
  //
  //SAVE RECORD([ACT_Avisos_de_Cobranza])
  //SAVE RECORD([ACT_Cargos])
  //$vb_utilizarIdT:=False
  //Else 
  //$saldoTransaccion:=$saldoTransaccion+[ACT_Cargos]Saldo
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+Abs([ACT_Cargos]Saldo)
  //[ACT_Cargos]Saldo:=[ACT_Cargos]Saldo+Abs([ACT_Cargos]Saldo)
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-Abs([ACT_Cargos]Saldo)
  //
  //SAVE RECORD([ACT_Avisos_de_Cobranza])
  //SAVE RECORD([ACT_Cargos])
  //
  //$vb_utilizarIdT:=False
  //ACTpgs_CreateTransaction ([ACT_Cargos]ID_CuentaCorriente;[ACT_Cargos]ID;$fechaPago;Abs([ACT_Cargos]Saldo);"Pago con "+$modoPago;[ACT_Avisos_de_Cobranza]ID_Aviso;[ACT_Cargos]ID_Apoderado;String([ACT_Cargos]Mes;"00")+String([ACT_Cargos]Año;"0000");"";$vl_idPago)
  //End if 
  //End case 
  //$el:=ACTcc_CalculaDocumentoCargo ($vl_rNDctoCargo)
  //ACTac_Recalcular ($rnAviso)
  //End if 
  //End for 
  //$el:=ACTcc_CalculaDocumentoCargo ($vl_rNDctoCargo1)
  //ACTac_Recalcular ($rnAviso1)
  //End if 
  //End if 
  //End for 
  //KRL_UnloadReadOnly (->[ACT_Cargos])
  //KRL_UnloadReadOnly (->[ACT_Transacciones])
  //KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza])
  //End if 
  //End for 
  //SET_ClearSets ($set;"cargosDelAviso")
  //End if 
  //AT_Initialize (->al_rNCargosRA;->al_idRefItemRA;->al_rNAvisosCRA)
  //End if 