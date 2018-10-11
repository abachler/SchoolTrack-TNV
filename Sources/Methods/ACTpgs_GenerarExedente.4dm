//%attributes = {}
  //ACTpgs_GenerarExedente

  //  `Vamos a crear un cargo de refitem -2 que contenga el excedente de pago del mes anterior. Este cargo sera
  //  `incluido en el aviso de cobranza del proximo mes
  //
  //$MontoPagado:=$1
  //
  //If ($MontoPagado>0)
  //LOAD RECORD([ACT_Avisos_de_Cobranza])
  //[ACT_Documentos_de_Cargo]Pagos:=[ACT_Documentos_de_Cargo]Pagos+$MontoPagado
  //[ACT_Documentos_de_Cargo]Saldo:=[ACT_Documentos_de_Cargo]Pagos-[ACT_Documentos_de_Cargo]Monto_Neto
  //
  //SAVE RECORD([ACT_Documentos_de_Cargo])
  //UNLOAD RECORD([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //
  //$month:=[ACT_Avisos_de_Cobranza]Mes+1
  //$year:=[ACT_Avisos_de_Cobranza]Agno
  //UNLOAD RECORD([ACT_Avisos_de_Cobranza])
  //If ($month=13)
  //$month:=1
  //$year:=$year+1
  //End if 
  //
  //$diaGeneracion:=1
  //$date:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($diaGeneracion;$month;$year))
  //
  //CREATE RECORD([ACT_Cargos])
  //[ACT_Cargos]ID_CuentaCorriente:=IDCtaAsigExcedente
  //[ACT_Cargos]ID_Apoderado:=IDApdoAsigExcedente
  //[ACT_Cargos]ID_Documento_de_Cargo:=0
  //[ACT_Cargos]Inutilizado:=IDParaTrans
  //[ACT_Cargos]Mes:=$month
  //[ACT_Cargos]Año:=$year
  //[ACT_Cargos]Fecha_de_generacion:=$date
  //[ACT_Cargos]Glosa:="Excedente pagado el mes anterior"
  //[ACT_Cargos]Ref_Item:=-2
  //[ACT_Cargos]Fecha_de_Vencimiento:=!00/00/00!
  //  `[ACT_Cargos]Moneda:="Peso Chileno"
  //[ACT_Cargos]Moneda:=◊vsACT_MonedaColegio
  //[ACT_Cargos]Monto_Neto:=$MontoPagado*-1
  //SAVE RECORD([ACT_Cargos])
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //End if 