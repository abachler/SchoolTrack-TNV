//%attributes = {}
  //ACTcc_GeneraCargos2

  //C_BLOB($1;xBlob)
  //C_DATE($date)
  //C_LONGINT($startAtMonth;$endAtMonth;$matrixId;$itemID)
  //C_INTEGER($diaGeneracion;$diaVencimiento)
  //ARRAY LONGINT(aLong1;0)
  //
  //<>vbACT_Generando:=True
  //ACTinit_LoadPrefs   `lectura de las preferencias generales
  //xBlob:=$1
  //If (Count parameters>1)
  //vpXS_IconModule:=$2
  //vsBWR_CurrentModule:=$3
  //End if 
  //If (Count parameters=4)
  //$Termometro:=$4
  //Else 
  //$Termometro:=True
  //End if 
  //
  //BLOB_Blob2Vars (->xBlob;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->bc_ExecuteOnServer;->vbACT_CargoEspecial;->vdACT_AñoAviso;->bc_EliminaDesctos;->vsACT_CtaContable;->vsACT_CentroContable;->vsACT_CCtaContable;->vsACT_CCentroContable;->vbACT_ImputacionUNica)
  //$ExecuteOnServer:=bc_ExecuteOnServer
  //$fromMonth:=aMeses
  //$toMonth:=aMeses2
  //If (vdACT_AñoAviso=0)
  //vdACT_AñoAviso:=Year of(<>vdACT_InicioEjercicio)
  //End if 
  //  `Los siguientes ifs evitan que generemos fuera del peridodo del ejercicio si es que generamos dentro del año de ejercicio
  //If (vdACT_AñoAviso=Year of(Current date(*)))
  //If ($fromMonth#$toMonth)
  //If ($fromMonth<Month of(<>vdACT_InicioEjercicio))
  //$fromMonth:=Month of(<>vdACT_InicioEjercicio)
  //End if 
  //If ($toMonth>Month of(<>vdACT_TerminoEjercicio))
  //$toMonth:=Month of(<>vdACT_TerminoEjercicio)
  //End if 
  //Else 
  //If (($fromMonth<Month of(<>vdACT_InicioEjercicio)) | ($fromMonth>Month of(<>vdACT_TerminoEjercicio)))
  //$fromMonth:=1
  //$toMonth:=0  `Para que no haga loop por los meses
  //End if 
  //End if 
  //End if 
  //$matrixId:=vlACT_SelectedMatrixID
  //$itemID:=vlACT_selectedItemId
  //$diaGeneracion:=viACT_DiaGeneracion
  //
  //COPY ARRAY(aLong1;$aRecNums)
  //AT_Initialize (->aLong1)
  //
  //If ($Termometro)
  //CD_THERMOMETRE (1;0;"Generando/actualizando deudas...")
  //End if 
  //
  //$year:=vdACT_AñoAviso
  //If ($FromMonth#$toMonth)
  //If ((Year of(<>vdACT_TerminoEjercicio)#(Year of(<>vdACT_InicioEjercicio))))
  //$toMonth:=12+$toMonth
  //End if 
  //End if 
  //$iterations:=($toMonth-$fromMonth+1)*Size of array($aRecNums)
  //$currentIteration:=0
  //
  //For ($monthIndex;$fromMonth;$toMonth)  `Loop por los meses a generar
  //If ($monthIndex>12)
  //$month:=$monthIndex-12
  //$year:=$year+1
  //Else 
  //$month:=$monthIndex
  //End if 
  //
  //If (ACTcm_IsMonthOpenFromMonthYear ($month;$year))
  //$date:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($diaGeneracion;$month;$year))
  //
  //$fechaVencimiento:=!00-00-00!
  //
  //For ($recnumIndex;1;Size of array($aRecNums))  `Loop por las ctas ctes.
  //
  //$currentIteration:=$currentIteration+1
  //
  //GOTO RECORD([ACT_CuentasCorrientes];$aRecNums{$recNumIndex})
  //
  //SET QUERY DESTINATION(Into variable ;vl_AvisosEncontrados)
  //
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado=[ACT_CuentasCorrientes]ID_Apoderado;*)
  //QUERY([ACT_Avisos_de_Cobranza]; & ;[ACT_Avisos_de_Cobranza]Mes=$month;*)
  //QUERY([ACT_Avisos_de_Cobranza]; & ;[ACT_Avisos_de_Cobranza]Agno=$year)
  //
  //SET QUERY DESTINATION(Into current selection )
  //SET QUERY DESTINATION(Into variable ;vl_CargosEncontrados)
  //
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //
  //SET QUERY DESTINATION(Into current selection )
  //
  //  ` busqueda o creación del documento de cargo
  //READ WRITE([ACT_Documentos_de_Cargo])
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]ID_Matriz>-1;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Año=$year;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Mes=$month)
  //  `QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]FechaEmision=!00 00 00!)
  //
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
  //
  //$CrearDocCargo:=False
  //
  //Case of 
  //
  //: ((vl_AvisosEncontrados#0) & (Records in selection([ACT_Documentos_de_Cargo])=0))
  //$CrearDocCargo:=True
  //: (Records in selection([ACT_Documentos_de_Cargo])=0)
  //$CrearDocCargo:=True
  //: ((Records in selection([ACT_Documentos_de_Cargo])>0) & (Records in selection([ACT_Cargos])>0) & (b2=1))
  //$CrearDocCargo:=True
  //: ((Records in selection([ACT_Documentos_de_Cargo])>0) & (Records in selection([ACT_Cargos])>0) & (b3=1) & (bc_ReplaceSameDescription=0))
  //$CrearDocCargo:=True
  //: ((Records in selection([ACT_Documentos_de_Cargo])>0) & (Records in selection([ACT_Cargos])>0) & (b3=1) & (bc_ReplaceSameDescription=1))
  //SET QUERY DESTINATION(Into variable ;$CargosIguales)
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Glosa=vsACT_Glosa;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item=-1;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year)
  //If ($CargosIguales=0)
  //$CrearDocCargo:=True
  //End if 
  //SET QUERY DESTINATION(Into current selection )
  //End case 
  //If ($CrearDocCargo)
  //CREATE RECORD([ACT_Documentos_de_Cargo])
  //[ACT_Documentos_de_Cargo]ID_Documento:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo]ID_Documento)
  //[ACT_Documentos_de_Cargo]ID_CuentaCorriente:=[ACT_CuentasCorrientes]ID
  //[ACT_Documentos_de_Cargo]ID_Alumno:=[ACT_CuentasCorrientes]ID_Alumno
  //[ACT_Documentos_de_Cargo]ID_Apoderado:=[ACT_CuentasCorrientes]ID_Apoderado
  //Case of 
  //: (b1=1)
  //$matriz:=[ACT_CuentasCorrientes]ID_Matriz
  //QUERY([ACT_Matrices];[ACT_Matrices]ID=$matriz)
  //$moneda:=[ACT_Matrices]Moneda
  //: (b2=1)
  //$matriz:=-2
  //QUERY([xxACT_Items];[xxACT_Items]ID=$ItemID)
  //$moneda:=[xxACT_Items]Moneda
  //: (b3=1)
  //$matriz:=-1
  //$moneda:=vsACT_Moneda
  //End case 
  //[ACT_Documentos_de_Cargo]ID_Matriz:=$matriz
  //[ACT_Documentos_de_Cargo]Moneda:=$moneda
  //[ACT_Documentos_de_Cargo]Año:=$year
  //[ACT_Documentos_de_Cargo]Mes:=$month
  //[ACT_Documentos_de_Cargo]FechaGeneracion:=$date
  //[ACT_Documentos_de_Cargo]Fecha_Vencimiento:=$fechaVencimiento
  //SAVE RECORD([ACT_Documentos_de_Cargo])
  //SELECTION TO ARRAY([ACT_Documentos_de_Cargo];$aRecNumDocsCta)
  //LOAD RECORD([ACT_Documentos_de_Cargo])
  //Else 
  //READ WRITE([ACT_Documentos_de_Cargo])
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Año=$year;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Mes=$month;*)
  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]FechaEmision=!00-00-00!)
  //
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
  //SELECTION TO ARRAY([ACT_Documentos_de_Cargo];$aRecNumDocsCta)
  //LOAD RECORD([ACT_Documentos_de_Cargo])
  //End if 
  //Case of 
  //: (vl_AvisosEncontrados>0)
  //Case of 
  //: (b1=1)
  //SELECTION TO ARRAY([ACT_Documentos_de_Cargo];$aRecNumDocs)
  //For ($i_Docs;1;Size of array($aRecNumDocs))
  //GOTO RECORD([ACT_Documentos_de_Cargo];$aRecNumDocs{$i_Docs})
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //SELECTION TO ARRAY([ACT_Cargos];$aRecNumsCargos)
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
  //If (Size of array($aRecNumsCargos)>0)
  //For ($i_Cargos;1;Size of array($aRecNumsCargos))
  //GOTO RECORD([ACT_Cargos];$aRecNumsCargos{$i_Cargos})
  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID=[ACT_Cargos]ID_CuentaCorriente)
  //$idmatriz:=[ACT_CuentasCorrientes]ID_Matriz
  //ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes]ID_Matriz)
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
  //Else 
  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID=[ACT_Documentos_de_Cargo]ID_CuentaCorriente)
  //ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes]ID_Matriz)
  //End if 
  //End for 
  //For ($Docs;1;Size of array($aRecNumDocs))
  //ACTcc_RecalculaCargosyDocs ($aRecNumDocs{$Docs};$month;$year;$date;$fechaVencimiento;True;False;False)
  //End for 
  //: (b2=1)
  //READ ONLY([xxACT_Items])
  //QUERY([xxACT_Items];[xxACT_Items]ID=$itemID)
  //$itemRecNum:=Record number([xxACT_Items])
  //ARRAY LONGINT(alACT_IdItemMatriz;1)
  //SELECTION TO ARRAY([xxACT_Items];alACT_ItemRecNum;[xxACT_Items]Glosa;atACT_GlosaItemMatriz;[xxACT_Items]Monto;arACT_AmountItemMatriz;[xxACT_Items]EsDescuento;abACT_IsDiscountItemMatriz;[xxACT_Items]EsRelativo;abACT_isPercentItemMatriz;[xxACT_Items]Afecto_a_descuentos;abACT_esDescontable;[xxACT_Items]Moneda;atACT_MonedaItem;[xxACT_Items]Meses_de_cargo;alACT_MesDeCargo;[xxACT_Items]Afecto_IVA;abACT_ItemAfectoIVA;[xxACT_Items]AfectoDsctoIndividual;abACT_AfectoDescInd;[xxACT_Items]No_de_Cuenta_Contable;asACT_CtaContableItem;[xxACT_Items]Centro_de_Costos;asACT_CentroContableItem;[xxACT_Items]No_CCta_contable;asACT_CCtaContableItem;[xxACT_Items]CCentro_de_costos;asACT_CCentroContableItem;[xxACT_Items]Imputacion_Unica;abACT_ImputacionUnica)
  //alACT_IdItemMatriz{1}:=$itemID
  //$itemIndex:=1
  //For ($Docs;1;Size of array($aRecNumDocsCta))
  //ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};$month;$year;$date;$fechaVencimiento;False;False;False)
  //End for 
  //: (b3=1)
  //READ ONLY([xxACT_Items])
  //QUERY([xxACT_Items];[xxACT_Items]ID=$itemID)
  //$itemRecNum:=Record number([xxACT_Items])
  //ARRAY LONGINT(alACT_IdItemMatriz;1)
  //SELECTION TO ARRAY([xxACT_Items];alACT_ItemRecNum;[xxACT_Items]Glosa;atACT_GlosaItemMatriz;[xxACT_Items]Monto;arACT_AmountItemMatriz;[xxACT_Items]EsDescuento;abACT_IsDiscountItemMatriz;[xxACT_Items]EsRelativo;abACT_isPercentItemMatriz;[xxACT_Items]Afecto_a_descuentos;abACT_esDescontable;[xxACT_Items]Moneda;atACT_MonedaItem;[xxACT_Items]Meses_de_cargo;alACT_MesDeCargo;[xxACT_Items]Afecto_IVA;abACT_ItemAfectoIVA;[xxACT_Items]AfectoDsctoIndividual;abACT_AfectoDescInd;[xxACT_Items]No_de_Cuenta_Contable;asACT_CtaContableItem;[xxACT_Items]Centro_de_Costos;asACT_CentroContableItem;[xxACT_Items]No_CCta_contable;asACT_CCtaContableItem;[xxACT_Items]CCentro_de_costos;asACT_CCentroContableItem;[xxACT_Items]Imputacion_Unica;abACT_ImputacionUnica)
  //alACT_IdItemMatriz{1}:=$itemID
  //$itemIndex:=1
  //For ($Docs;1;Size of array($aRecNumDocsCta))
  //ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};$month;$year;$date;$fechaVencimiento;False;False;True)
  //End for 
  //End case 
  //: (b1=1)  ` generar cargos utilizando la matriz asignada
  //SELECTION TO ARRAY([ACT_Documentos_de_Cargo];$aRecNumDocs)
  //For ($i_Docs;1;Size of array($aRecNumDocs))
  //GOTO RECORD([ACT_Documentos_de_Cargo];$aRecNumDocs{$i_Docs})
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //SELECTION TO ARRAY([ACT_Cargos];$aRecNumsCargos)
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
  //If (Size of array($aRecNumsCargos)>0)
  //For ($i_Cargos;1;Size of array($aRecNumsCargos))
  //GOTO RECORD([ACT_Cargos];$aRecNumsCargos{$i_Cargos})
  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID=[ACT_Cargos]ID_CuentaCorriente)
  //$idmatriz:=[ACT_CuentasCorrientes]ID_Matriz
  //ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes]ID_Matriz)
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
  //Else 
  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID=[ACT_Documentos_de_Cargo]ID_CuentaCorriente)
  //ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes]ID_Matriz)
  //End if 
  //End for 
  //For ($Docs;1;Size of array($aRecNumDocs))
  //ACTcc_RecalculaCargosyDocs ($aRecNumDocs{$Docs};$month;$year;$date;$fechaVencimiento;True;False;False)
  //End for 
  //: (b2=1)  ` generar cargos utilizando el item de cargo seleccionado
  //READ ONLY([xxACT_Items])
  //QUERY([xxACT_Items];[xxACT_Items]ID=$itemID)
  //$itemRecNum:=Record number([xxACT_Items])
  //ARRAY LONGINT(alACT_IdItemMatriz;1)
  //SELECTION TO ARRAY([xxACT_Items];alACT_ItemRecNum;[xxACT_Items]Glosa;atACT_GlosaItemMatriz;[xxACT_Items]Monto;arACT_AmountItemMatriz;[xxACT_Items]EsDescuento;abACT_IsDiscountItemMatriz;[xxACT_Items]EsRelativo;abACT_isPercentItemMatriz;[xxACT_Items]Afecto_a_descuentos;abACT_esDescontable;[xxACT_Items]Moneda;atACT_MonedaItem;[xxACT_Items]Meses_de_cargo;alACT_MesDeCargo;[xxACT_Items]Afecto_IVA;abACT_ItemAfectoIVA;[xxACT_Items]AfectoDsctoIndividual;abACT_AfectoDescInd;[xxACT_Items]No_de_Cuenta_Contable;asACT_CtaContableItem;[xxACT_Items]Centro_de_Costos;asACT_CentroContableItem;[xxACT_Items]No_CCta_contable;asACT_CCtaContableItem;[xxACT_Items]CCentro_de_costos;asACT_CCentroContableItem;[xxACT_Items]Imputacion_Unica;abACT_ImputacionUnica)
  //alACT_IdItemMatriz{1}:=$itemID
  //$itemIndex:=1
  //For ($Docs;1;Size of array($aRecNumDocsCta))
  //ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};$month;$year;$date;$fechaVencimiento;False;False;False)
  //End for 
  //: (b3=1)  ` generar cargo extraordinario      
  //READ ONLY([xxACT_Items])
  //QUERY([xxACT_Items];[xxACT_Items]ID=$itemID)
  //$itemRecNum:=Record number([xxACT_Items])
  //ARRAY LONGINT(alACT_IdItemMatriz;1)
  //SELECTION TO ARRAY([xxACT_Items];alACT_ItemRecNum;[xxACT_Items]Glosa;atACT_GlosaItemMatriz;[xxACT_Items]Monto;arACT_AmountItemMatriz;[xxACT_Items]EsDescuento;abACT_IsDiscountItemMatriz;[xxACT_Items]EsRelativo;abACT_isPercentItemMatriz;[xxACT_Items]Afecto_a_descuentos;abACT_esDescontable;[xxACT_Items]Moneda;atACT_MonedaItem;[xxACT_Items]Meses_de_cargo;alACT_MesDeCargo;[xxACT_Items]Afecto_IVA;abACT_ItemAfectoIVA;[xxACT_Items]AfectoDsctoIndividual;abACT_AfectoDescInd;[xxACT_Items]No_de_Cuenta_Contable;asACT_CtaContableItem;[xxACT_Items]Centro_de_Costos;asACT_CentroContableItem;[xxACT_Items]No_CCta_contable;asACT_CCtaContableItem;[xxACT_Items]CCentro_de_costos;asACT_CCentroContableItem;[xxACT_Items]Imputacion_Unica;abACT_ImputacionUnica)
  //alACT_IdItemMatriz{1}:=$itemID
  //$itemIndex:=1
  //For ($Docs;1;Size of array($aRecNumDocsCta))
  //ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};$month;$year;$date;$fechaVencimiento;False;False;True)
  //End for 
  //
  //LOAD RECORD([ACT_Documentos_de_Cargo])
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //SELECTION TO ARRAY([ACT_Cargos];$aRecNumsCargos)
  //For ($i_Cargos;1;Size of array($aRecNumsCargos))
  //READ WRITE([ACT_Cargos])
  //ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos};0;True)
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //End for 
  //For ($Docs;1;Size of array($aRecNumDocsCta))
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item=-2;*)
  //  `QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
  //  `QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
  //
  //SELECTION TO ARRAY([ACT_Cargos];$aRecNumExcedentes)
  //GOTO RECORD([ACT_Documentos_de_Cargo];$aRecNumDocsCta{$Docs})
  //
  //For ($i;1;Size of array($aRecNumExcedentes))
  //READ WRITE([ACT_Cargos])
  //GOTO RECORD([ACT_Cargos];$aRecNumExcedentes{$i})
  //[ACT_Cargos]ID_Documento_de_Cargo:=[ACT_Documentos_de_Cargo]ID_Documento
  //SAVE RECORD([ACT_Cargos])
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //End for 
  //ACTcc_CalculaDocumentoCargo ($aRecNumDocsCta{$Docs})
  //End for 
  //End case 
  //If ($Termometro)
  //CD_THERMOMETRE (0;$currentIteration/$iterations*100;"Generando/actualizando deudas para el mes de "+atACT_Meses{$month}+"...")
  //End if 
  //End for 
  //End if 
  //End for 
  //If ($Termometro)
  //CD_THERMOMETRE (-1)
  //End if 
  //KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo])
  //KRL_UnloadReadOnly (->[ACT_Cargos])
  //KRL_UnloadReadOnly (->[ACT_CuentasCorrientes])
  //KRL_UnloadReadOnly (->[ACT_Transacciones])
  //
  //FLUSH BUFFERS
  //<>vbACT_Generando:=False