//%attributes = {}
  //ACTcc_RecalculaCargosyDocs2

  //$recnumDocumentoCargo:=$1
  //$month:=$2
  //$year:=$3
  //$date:=$4
  //$fechaVencimiento:=$5
  //$testMes:=$6
  //$BorrarEspeciales:=$7
  //
  //If ($BorrarEspeciales)
  //READ WRITE([ACT_Cargos])
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item=-1;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //DELETE SELECTION([ACT_Cargos])
  //End if 
  //
  //  `asignaremos numero de documento de cargo a los cargos correspondientes a excedentes en los pagos del mes anterior
  //
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item=-2;*)
  //  `QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //  `QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //
  //SELECTION TO ARRAY([ACT_Cargos];$aRecNumExcedentes)
  //GOTO RECORD([ACT_Documentos_de_Cargo];$recnumDocumentoCargo)
  //
  //For ($i;1;Size of array($aRecNumExcedentes))
  //READ WRITE([ACT_Cargos])
  //GOTO RECORD([ACT_Cargos];$aRecNumExcedentes{$i})
  //[ACT_Cargos]ID_Documento_de_Cargo:=[ACT_Documentos_de_Cargo]ID_Documento
  //SAVE RECORD([ACT_Cargos])
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //End for 
  //
  //For ($itemIndex;1;Size of array(alACT_IdItemMatriz))
  //If ($testMes)
  //If (alACT_MesDeCargo{$itemIndex} ?? $month)
  //READ WRITE([ACT_Cargos])
  //GOTO RECORD([ACT_Documentos_de_Cargo];$recnumDocumentoCargo)
  //
  //If ([ACT_Documentos_de_Cargo]ID_Matriz>-1)
  //
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item=alACT_IdItemMatriz{$itemIndex};*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //
  //  ` no puede existir mas de un cargo por item en el mismo período
  //  ` se eliminan los cargos duplicados, a condicion que no hayan sido objeto de 
  //  `aviso de cobranza
  //  `If (Records in selection([ACT_Cargos])>1)
  //  `READ WRITE([ACT_Cargos])
  //  `QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision=!00/00/00!)
  //  `DELETE SELECTION([ACT_Cargos])
  //  `End if 
  //
  //
  //If (Records in selection([ACT_Cargos])>0)
  //READ WRITE([ACT_Cargos])
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision=!00-00-00!)
  //If (bc_EliminaDesctos=1)
  //READ WRITE([xxACT_DesctosXItem])
  //FIRST RECORD([ACT_Cargos])
  //While (Not(End selection([ACT_Cargos])))
  //  `QUERY([xxACT_DesctosXItem];[xxACT_DesctosXItem]Ref_Item=[ACT_Cargos]Ref_Item;*)
  //  `QUERY([xxACT_DesctosXItem]; & ;[xxACT_DesctosXItem]Fecha_Generacion=[ACT_Cargos]Fecha_de_generacion;*)
  //  `QUERY([xxACT_DesctosXItem]; & ;[xxACT_DesctosXItem]ID_CtaCte=[ACT_Cargos]ID_CuentaCorriente)
  //QUERY([xxACT_DesctosXItem];[xxACT_DesctosXItem]ID_Cargo=[ACT_Cargos]ID)
  //DELETE RECORD([xxACT_DesctosXItem])
  //NEXT RECORD([ACT_Cargos])
  //End while 
  //READ ONLY([xxACT_DesctosXItem])
  //End if 
  //DELETE SELECTION([ACT_Cargos])
  //End if 
  //
  //If (Records in selection([ACT_Cargos])=0)
  //CREATE RECORD([ACT_Cargos])
  //[ACT_Cargos]ID_CuentaCorriente:=[ACT_CuentasCorrientes]ID
  //[ACT_Cargos]ID_Documento_de_Cargo:=[ACT_Documentos_de_Cargo]ID_Documento
  //[ACT_Cargos]Mes:=$month
  //[ACT_Cargos]Año:=$year
  //[ACT_Cargos]Fecha_de_generacion:=$date
  //[ACT_Cargos]FechaEmision:=!00-00-00!
  //[ACT_Cargos]Glosa:=atACT_GlosaItemMatriz{$itemIndex}
  //[ACT_Cargos]Ref_Item:=alACT_IdItemMatriz{$itemIndex}
  //[ACT_Cargos]Fecha_de_Vencimiento:=$fechaVencimiento
  //[ACT_Cargos]Afecto_a_Descuentos:=abACT_esDescontable{$itemIndex}
  //[ACT_Cargos]Afecto_a_descuentos_Individual:=abACT_AfectoDescInd{$itemIndex}
  //[ACT_Cargos]EsRelativo:=abACT_isPercentItemMatriz{$itemIndex}
  //[ACT_Cargos]Moneda:=atACT_MonedaItem{$itemIndex}
  //[ACT_Cargos]No_de_Cuenta_contable:=asACT_CtaContableItem{$itemIndex}
  //[ACT_Cargos]No_CCta_contable:=asACT_CCtaContableItem{$itemIndex}
  //[ACT_Cargos]Centro_de_costos:=asACT_CentroContableItem{$itemIndex}
  //[ACT_Cargos]CCentro_de_costos:=asACT_CCentroContableItem{$itemIndex}
  //If (abACT_ItemAfectoIVA{$itemIndex})
  //[ACT_Cargos]TasaIVA:=<>vrACT_TasaIVA
  //End if 
  //Case of 
  //: (abACT_isPercentItemMatriz{$itemIndex})
  //[ACT_Cargos]Monto_Moneda:=0
  //[ACT_Cargos]Monto_Neto:=0
  //: ((arACT_AmountItemMatriz{$itemIndex}>0) & (abACT_IsDiscountItemMatriz{$itemIndex}))
  //[ACT_Cargos]Monto_Moneda:=Abs(arACT_AmountItemMatriz{$itemIndex})*-1
  //: ((arACT_AmountItemMatriz{$itemIndex}<0) & (abACT_IsDiscountItemMatriz{$itemIndex}=False))
  //[ACT_Cargos]Monto_Moneda:=Abs(arACT_AmountItemMatriz{$itemIndex})
  //Else 
  //[ACT_Cargos]Monto_Moneda:=arACT_AmountItemMatriz{$itemIndex}
  //End case 
  //SAVE RECORD([ACT_Cargos])
  //Else 
  //[ACT_Cargos]ID_CuentaCorriente:=[ACT_CuentasCorrientes]ID
  //  `[ACT_Cargos]ID_Documento_de_Cargo:=[ACT_Documentos_de_Cargo]ID_Documento
  //[ACT_Cargos]Mes:=$month
  //[ACT_Cargos]Año:=$year
  //[ACT_Cargos]Fecha_de_generacion:=$date
  //[ACT_Cargos]FechaEmision:=!00-00-00!
  //[ACT_Cargos]Glosa:=atACT_GlosaItemMatriz{$itemIndex}
  //[ACT_Cargos]Ref_Item:=alACT_IdItemMatriz{$itemIndex}
  //[ACT_Cargos]Fecha_de_Vencimiento:=$fechaVencimiento
  //[ACT_Cargos]Afecto_a_Descuentos:=abACT_esDescontable{$itemIndex}
  //[ACT_Cargos]Afecto_a_descuentos_Individual:=abACT_AfectoDescInd{$itemIndex}
  //[ACT_Cargos]EsRelativo:=abACT_isPercentItemMatriz{$itemIndex}
  //[ACT_Cargos]Moneda:=atACT_MonedaItem{$itemIndex}
  //[ACT_Cargos]No_de_Cuenta_contable:=asACT_CtaContableItem{$itemIndex}
  //[ACT_Cargos]No_CCta_contable:=asACT_CCtaContableItem{$itemIndex}
  //[ACT_Cargos]Centro_de_costos:=asACT_CentroContableItem{$itemIndex}
  //[ACT_Cargos]CCentro_de_costos:=asACT_CCentroContableItem{$itemIndex}
  //If (abACT_ItemAfectoIVA{$itemIndex})
  //[ACT_Cargos]TasaIVA:=<>vrACT_TasaIVA
  //End if 
  //Case of 
  //: (abACT_isPercentItemMatriz{$itemIndex})
  //[ACT_Cargos]Monto_Moneda:=0
  //[ACT_Cargos]Monto_Neto:=0
  //: ((arACT_AmountItemMatriz{$itemIndex}>0) & (abACT_IsDiscountItemMatriz{$itemIndex}))
  //[ACT_Cargos]Monto_Moneda:=Abs(arACT_AmountItemMatriz{$itemIndex})*-1
  //: ((arACT_AmountItemMatriz{$itemIndex}<0) & (abACT_IsDiscountItemMatriz{$itemIndex}=False))
  //[ACT_Cargos]Monto_Moneda:=Abs(arACT_AmountItemMatriz{$itemIndex})
  //Else 
  //[ACT_Cargos]Monto_Moneda:=arACT_AmountItemMatriz{$itemIndex}
  //End case 
  //SAVE RECORD([ACT_Cargos])
  //End if 
  //End if 
  //End if 
  //
  //Else 
  //If ([ACT_Documentos_de_Cargo]ID_Matriz>=-2)
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item=alACT_IdItemMatriz{$itemIndex};*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //
  //  ` no puede existir mas de un cargo por item en el mismo período
  //  ` se eliminan los cargos duplicados, a condicion que no hayan sido objeto de 
  //  ` aviso de cobranza
  //If ((Records in selection([ACT_Cargos])>0) & (abACT_ImputacionUnica{$itemIndex}))
  //READ WRITE([ACT_Cargos])
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision=!00-00-00!)
  //If (bc_EliminaDesctos=1)
  //READ WRITE([xxACT_DesctosXItem])
  //FIRST RECORD([ACT_Cargos])
  //While (Not(End selection([ACT_Cargos])))
  //  `QUERY([xxACT_DesctosXItem];[xxACT_DesctosXItem]Ref_Item=[ACT_Cargos]Ref_Item;*)
  //  `QUERY([xxACT_DesctosXItem]; & ;[xxACT_DesctosXItem]Fecha_Generacion=[ACT_Cargos]Fecha_de_generacion;*)
  //  `QUERY([xxACT_DesctosXItem]; & ;[xxACT_DesctosXItem]ID_CtaCte=[ACT_Cargos]ID_CuentaCorriente)
  //QUERY([xxACT_DesctosXItem];[xxACT_DesctosXItem]ID_Cargo=[ACT_Cargos]ID)
  //DELETE RECORD([xxACT_DesctosXItem])
  //NEXT RECORD([ACT_Cargos])
  //End while 
  //READ ONLY([xxACT_DesctosXItem])
  //End if 
  //DELETE SELECTION([ACT_Cargos])
  //End if 
  //CREATE RECORD([ACT_Cargos])
  //[ACT_Cargos]ID_CuentaCorriente:=[ACT_CuentasCorrientes]ID
  //[ACT_Cargos]ID_Documento_de_Cargo:=[ACT_Documentos_de_Cargo]ID_Documento
  //[ACT_Cargos]Mes:=$month
  //[ACT_Cargos]Año:=$year
  //[ACT_Cargos]Fecha_de_generacion:=$date
  //[ACT_Cargos]FechaEmision:=!00-00-00!
  //[ACT_Cargos]Glosa:=atACT_GlosaItemMatriz{$itemIndex}
  //[ACT_Cargos]Ref_Item:=alACT_IdItemMatriz{$itemIndex}
  //[ACT_Cargos]Fecha_de_Vencimiento:=$fechaVencimiento
  //[ACT_Cargos]Afecto_a_Descuentos:=abACT_esDescontable{$itemIndex}
  //[ACT_Cargos]EsRelativo:=abACT_isPercentItemMatriz{$itemIndex}
  //[ACT_Cargos]Moneda:=atACT_MonedaItem{$itemIndex}
  //[ACT_Cargos]No_de_Cuenta_contable:=asACT_CtaContableItem{$itemIndex}
  //[ACT_Cargos]No_CCta_contable:=asACT_CCtaContableItem{$itemIndex}
  //[ACT_Cargos]Centro_de_costos:=asACT_CentroContableItem{$itemIndex}
  //[ACT_Cargos]CCentro_de_costos:=asACT_CCentroContableItem{$itemIndex}
  //If (abACT_ItemAfectoIVA{$itemIndex})
  //[ACT_Cargos]TasaIVA:=<>vrACT_TasaIVA
  //End if 
  //Case of 
  //: (abACT_isPercentItemMatriz{$itemIndex})
  //[ACT_Cargos]Monto_Moneda:=0
  //[ACT_Cargos]Monto_Neto:=0
  //: ((arACT_AmountItemMatriz{$itemIndex}>0) & (abACT_IsDiscountItemMatriz{$itemIndex}))
  //[ACT_Cargos]Monto_Moneda:=Abs(arACT_AmountItemMatriz{$itemIndex})*-1
  //: ((arACT_AmountItemMatriz{$itemIndex}<0) & (abACT_IsDiscountItemMatriz{$itemIndex}=False))
  //[ACT_Cargos]Monto_Moneda:=Abs(arACT_AmountItemMatriz{$itemIndex})
  //Else 
  //[ACT_Cargos]Monto_Moneda:=arACT_AmountItemMatriz{$itemIndex}
  //End case 
  //SAVE RECORD([ACT_Cargos])
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //End if 
  //End if 
  //End for 
  //
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item#-2)
  //
  //LOAD RECORD([ACT_Documentos_de_Cargo])
  //$Mes:=[ACT_Documentos_de_Cargo]Mes
  //$Year:=[ACT_Documentos_de_Cargo]Año
  //$Apdo:=[ACT_Documentos_de_Cargo]ID_Apoderado
  //SELECTION TO ARRAY([ACT_Cargos];$aRecNumsCargos)
  //
  //$idmatriz:=[ACT_CuentasCorrientes]ID_Matriz
  //
  //For ($i_Cargos;1;Size of array($aRecNumsCargos))
  //GOTO RECORD([ACT_Cargos];$aRecNumsCargos{$i_Cargos})
  //QUERY([xxACT_ItemsMatriz];[xxACT_ItemsMatriz]ID_Matriz=$idmatriz;*)
  //QUERY([xxACT_ItemsMatriz]; & ;[xxACT_ItemsMatriz]ID_Item=[ACT_Cargos]Ref_Item)
  //UNLOAD RECORD([ACT_Cargos])
  //If (Records in selection([xxACT_ItemsMatriz])>0)
  //$itemnomatriz:=False
  //Else 
  //$itemnomatriz:=True
  //End if 
  //READ WRITE([ACT_Cargos])
  //ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos};$idmatriz;$itemnomatriz)
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //End for 
  //
  //$montoDoc:=ACTcc_CalculaDocumentoCargo ($recnumDocumentoCargo)
  //
  //ARRAY LONGINT(alACT_RecNumsDocsVenc;0)
  //If ($montoDoc#0)
  //REDUCE SELECTION([ACT_Documentos_de_Cargo];0)
  //$MesAux:=$Mes
  //$YearAux:=$Year
  //$Loop:=True
  //While ((Records in selection([ACT_Documentos_de_Cargo])=0) & ($Loop))
  //$MesAux:=$MesAux-1
  //If ($MesAux=0)
  //$MesAux:=12
  //$YearAux:=$YearAux-1
  //End if 
  //ARRAY LONGINT(alACT_TempRecNumsDocsVenc;0)
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_Apoderado=$Apdo;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Mes=$MesAux;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Año=$YearAux;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Saldo<0)
  //LONGINT ARRAY FROM SELECTION([ACT_Documentos_de_Cargo];alACT_TempRecNumsDocsVenc)
  //AT_Union (->alACT_RecNumsDocsVenc;->alACT_TempRecNumsDocsVenc;->alACT_RecNumsDocsVenc)
  //If ($Year-$YearAux=5)
  //$Loop:=False
  //End if 
  //End while 
  //UNLOAD RECORD([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //CREATE SELECTION FROM ARRAY([ACT_Documentos_de_Cargo];alACT_RecNumsDocsVenc)
  //AT_Initialize (->alACT_RecNumsDocsVenc;->alACT_TempRecNumsDocsVenc)
  //
  //If (Records in selection([ACT_Documentos_de_Cargo])>0)
  //SELECTION TO ARRAY([ACT_Documentos_de_Cargo];$RecNumDocsdeCargoVenc)
  //For ($i;1;Size of array($RecNumDocsdeCargoVenc))
  //$RNCurrentCta:=Record number([ACT_CuentasCorrientes])
  //$readOnlyStateCtas:=Read only state([ACT_CuentasCorrientes])
  //  `ACTcc_CalculaVencIntereses ($RecNumDocsdeCargoVenc{$i})
  //If ($readOnlyStateCtas)
  //READ ONLY([ACT_CuentasCorrientes])
  //Else 
  //READ WRITE([ACT_CuentasCorrientes])
  //End if 
  //GOTO RECORD([ACT_CuentasCorrientes];$RNCurrentCta)
  //End for 
  //End if 
  //Else 
  //READ WRITE([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Cargos])
  //GOTO RECORD([ACT_Documentos_de_Cargo];$recnumDocumentoCargo)
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento)
  //If (Records in selection([ACT_Cargos])=0)
  //If (Not(Locked([ACT_Documentos_de_Cargo])))
  //DELETE RECORD([ACT_Documentos_de_Cargo])
  //Else 
  //BM_CreateRequest ("ACT_BorrarDocdeCargo";String([ACT_Documentos_de_Cargo]ID_Documento))
  //End if 
  //End if 
  //READ ONLY([ACT_Documentos_de_Cargo])
  //End if 