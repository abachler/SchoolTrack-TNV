//%attributes = {}
  //ACTpgs_EmitirBoleta

  //$idpago:=$1
  //
  //$montoAfectoTotal:=0
  //$montoNoAfectoTotal:=0
  //
  //ARRAY LONGINT($aCargosAfectos;0)
  //ARRAY LONGINT($aCargosExentos;0)
  //
  //For ($i;1;Size of array(alACT_RecNumCargos))
  //
  //GOTO RECORD([ACT_Cargos];alACT_RecNumCargos{$i})
  //
  //If ([ACT_Cargos]TasaIVA>0)
  //
  //$montoAfectoTotal:=$montoAfectoTotal+arACT_PagadoCargo{$i}
  //Insert in Array($aCargosAfectos;Size of array($aCargosAfectos)+1;1)
  //$aCargosAfectos{Size of array($aCargosAfectos)}:=Record number([ACT_Cargos])
  //
  //Else 
  //
  //$montoNoAfectoTotal:=$montoNoAfectoTotal+arACT_PagadoCargo{$i}
  //Insert in Array($aCargosExentos;Size of array($aCargosExentos)+1;1)
  //$aCargosExentos{Size of array($aCargosExentos)}:=Record number([ACT_Cargos])
  //
  //End if 
  //
  //End for 
  //
  //UNLOAD RECORD([ACT_Cargos])
  //
  //CREATE EMPTY SET([ACT_Boletas];"AImprimirAfectas")
  //CREATE EMPTY SET([ACT_Boletas];"AImprimirNoAfectas")
  //
  //If ($montoAfectoTotal>0)
  //
  //CREATE RECORD([ACT_Boletas])
  //[ACT_Boletas]ID:=SQ_SeqNumber (->[ACT_Boletas]ID)
  //[ACT_Boletas]ID_Pago:=$idpago
  //[ACT_Boletas]FechaEmision:=Current date(*)
  //[ACT_Boletas]AfectaIVA:=True
  //[ACT_Boletas]Monto_Total:=$montoAfectoTotal
  //[ACT_Boletas]Monto_Afecto:=Round([ACT_Boletas]Monto_Total/<>vrACT_FactorIVA;0)
  //[ACT_Boletas]Monto_IVA:=[ACT_Boletas]Monto_Total-[ACT_Boletas]Monto_Afecto
  //[ACT_Boletas]Numero:=alACT_Proxima{1}
  //alACT_Proxima{1}:=alACT_Proxima{1}+1
  //[ACT_Boletas]Estado:="Cancelada"
  //[ACT_Boletas]TipoDocumento:=atACT_TipoDoc{1}
  //
  //$idBoleta:=[ACT_Boletas]ID
  //
  //SAVE RECORD([ACT_Boletas])
  //
  //ADD TO SET([ACT_Boletas];"AImprimirAfectas")
  //
  //UNLOAD RECORD([ACT_Boletas])
  //READ ONLY([ACT_Boletas])
  //
  //For ($i;1;Size of array($aCargosAfectos))
  //READ WRITE([ACT_Transacciones])
  //USE SET("FaltaIDPago")
  //GOTO RECORD([ACT_Cargos];$aCargosAfectos{$i})
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
  //If ($montoNoAfectoTotal>0)
  //
  //CREATE RECORD([ACT_Boletas])
  //[ACT_Boletas]ID:=SQ_SeqNumber (->[ACT_Boletas])
  //[ACT_Boletas]ID_Pago:=$idpago
  //[ACT_Boletas]FechaEmision:=Current date(*)
  //[ACT_Boletas]AfectaIVA:=False
  //[ACT_Boletas]Monto_Afecto:=0
  //[ACT_Boletas]Monto_IVA:=0
  //[ACT_Boletas]Monto_Total:=$montoNoAfectoTotal
  //[ACT_Boletas]Numero:=alACT_Proxima{2}
  //alACT_Proxima{2}:=alACT_Proxima{2}+1
  //[ACT_Boletas]Estado:="Cancelada"
  //[ACT_Boletas]TipoDocumento:=atACT_TipoDoc{2}
  //
  //$idBoleta:=[ACT_Boletas]ID
  //
  //SAVE RECORD([ACT_Boletas])
  //
  //ADD TO SET([ACT_Boletas];"AImprimirNoAfectas")
  //
  //UNLOAD RECORD([ACT_Boletas])
  //READ ONLY([ACT_Boletas])
  //
  //For ($i;1;Size of array($aCargosExentos))
  //READ WRITE([ACT_Transacciones])
  //USE SET("FaltaIDPago")
  //GOTO RECORD([ACT_Cargos];$aCargosExentos{$i})
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
  //
  //ACTbol_PrintBoletas ("Boleta Afecta";"AImprimirAfectas")
  //ACTbol_PrintBoletas ("Boleta Exenta";"AImprimirNoAfectas")
  //
  //  `If ($CurrentPrinter)
  //  `SET CURRENT PRINTER(vtACT_CurrentPrinter)
  //  `End if 
  //SET_ClearSets ("AImprimirNoAfectas";"AImprimirAfectas")