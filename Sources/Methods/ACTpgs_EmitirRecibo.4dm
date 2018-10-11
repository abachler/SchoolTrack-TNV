//%attributes = {}
  //ACTpgs_EmitirRecibo

  //$idpago:=$1
  //
  //$monto:=AT_GetSumArray (->arACT_PagadoCargo)
  //
  //CREATE EMPTY SET([ACT_Boletas];"AImprimirRecibos")
  //
  //If ($monto>0)
  //
  //CREATE RECORD([ACT_Boletas])
  //[ACT_Boletas]ID:=SQ_SeqNumber (->[ACT_Boletas]ID)
  //[ACT_Boletas]ID_Pago:=$idpago
  //[ACT_Boletas]FechaEmision:=Current date(*)
  //[ACT_Boletas]AfectaIVA:=False
  //[ACT_Boletas]Monto_Total:=$monto
  //[ACT_Boletas]Monto_Afecto:=0
  //[ACT_Boletas]Monto_IVA:=0
  //[ACT_Boletas]Numero:=alACT_Proxima{9}
  //alACT_Proxima{9}:=alACT_Proxima{9}+1
  //[ACT_Boletas]Estado:="Cancelado"
  //[ACT_Boletas]TipoDocumento:=atACT_TipoDoc{9}
  //
  //$idBoleta:=[ACT_Boletas]ID
  //
  //SAVE RECORD([ACT_Boletas])
  //
  //ADD TO SET([ACT_Boletas];"AImprimirRecibos")
  //
  //UNLOAD RECORD([ACT_Boletas])
  //READ ONLY([ACT_Boletas])
  //
  //For ($i;1;Size of array(alACT_RecNumCargos))
  //READ WRITE([ACT_Transacciones])
  //USE SET("FaltaIDPago")
  //GOTO RECORD([ACT_Cargos];alACT_RecNumCargos{$i})
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID)
  //[ACT_Transacciones]No_Boleta:=$idBoleta
  //SAVE RECORD([ACT_Transacciones])
  //End for 
  //
  //UNLOAD RECORD([ACT_Transacciones])
  //REDUCE SELECTION([ACT_Transacciones];0)
  //READ ONLY([ACT_Transacciones])
  //
  //End if 
  //
  //ACTcfg_SaveConfig (8)
  //  `vtACT_CurrentPrinter:=Get current printer
  //  `If (ok#1)
  //  `$CurrentPrinter:=False
  //  `Else 
  //  `$CurrentPrinter:=True
  //  `End if 
  //ACTbol_PrintBoletas ("Recibo";"AImprimirRecibos")
  //  `If ($CurrentPrinter)
  //  `SET CURRENT PRINTER(vtACT_CurrentPrinter)
  //  `End if 
  //SET_ClearSets ("AImprimirRecibos")