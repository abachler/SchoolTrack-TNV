//%attributes = {}
  //ACTpgs_CalculaMontoRecargoXA

  //  `$1 fecha
  //  `$2 calcular al entrar TRUE-> SI; FALSE -> NO
  //C_BOOLEAN($2;$vb_entrandoAPagos;vb_entroUnaVez)
  //C_DATE($1;$vd_date;$fechaVencimiento;$fechaPago2;$fechaPago3;$fechaPago4)
  //C_LONGINT($vl_rNDctoCargo;$rnAviso)
  //$vd_date:=$1
  //$vb_entrandoAPagos:=$2
  //ACTcfg_LoadConfigData (1)
  //ACTcfg_pctsXFechaPago (2)
  //ACTcfg_LoadCargosEspeciales (2)
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //ARRAY LONGINT(al_rNCargosRA;0)
  //ARRAY LONGINT(al_idRefItemRA;0)
  //If ($vb_entrandoAPagos)
  //If (Size of array(alACT_CRefs)>0)
  //Case of 
  //: ($vb_entrandoAPagos)
  //  `If (Records in set($set)>0)
  //alACT_CRefs{0}:=vl_idIE  `el id del ítem de recargo por adelantado cargado en ACTpgs_LoadCargosEspeciales(2)
  //  `AT_SearchArray (->al_idRefItemRA;"=")
  //AT_SearchArray (->alACT_CRefs;"=")
  //For ($i;1;Size of array(DA_Return))
  //vb_entroUnaVez:=True
  //READ WRITE([ACT_Cargos])
  //GOTO RECORD([ACT_Cargos];alACT_RecNumsCargos{DA_Return{$i}})
  //$fechaVencimiento:=[ACT_Cargos]Fecha_de_Vencimiento
  //$fechaPago2:=ACTut_fFechaValida ($fechaVencimiento+viACT_DiaVencimiento2)
  //$fechaPago3:=ACTut_fFechaValida ($fechaPago2+viACT_DiaVencimiento3)
  //$fechaPago4:=ACTut_fFechaValida ($fechaPago3+viACT_DiaVencimiento4)
  //Case of 
  //: ($vd_date<=$fechaVencimiento)
  //[ACT_Cargos]Monto_Neto:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago1/100))
  //[ACT_Cargos]Monto_Bruto:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago1/100))
  //[ACT_Cargos]Monto_Moneda:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago1/100))
  //[ACT_Cargos]Saldo:=([ACT_Cargos]Monto_Neto-[ACT_Cargos]MontosPagados)*-1
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados
  //
  //arACT_CMontoNeto{DA_Return{$i}}:=[ACT_Cargos]Monto_Neto
  //arACT_MontoMoneda{DA_Return{$i}}:=[ACT_Cargos]Monto_Moneda
  //arACT_CSaldo{DA_Return{$i}}:=[ACT_Cargos]Saldo
  //arACT_MontoPagado{DA_Return{$i}}:=[ACT_Cargos]MontosPagados
  //
  //: ($vd_date<=$fechaPago2)
  //[ACT_Cargos]Monto_Neto:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago2/100))
  //[ACT_Cargos]Monto_Bruto:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago2/100))
  //[ACT_Cargos]Monto_Moneda:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago2/100))
  //[ACT_Cargos]Saldo:=([ACT_Cargos]Monto_Neto-[ACT_Cargos]MontosPagados)*-1
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados
  //
  //arACT_CMontoNeto{DA_Return{$i}}:=[ACT_Cargos]Monto_Neto
  //arACT_MontoMoneda{DA_Return{$i}}:=[ACT_Cargos]Monto_Moneda
  //arACT_CSaldo{DA_Return{$i}}:=[ACT_Cargos]Saldo
  //arACT_MontoPagado{DA_Return{$i}}:=[ACT_Cargos]MontosPagados
  //
  //: ($vd_date<=$fechaPago3)
  //[ACT_Cargos]Monto_Neto:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago3/100))
  //[ACT_Cargos]Monto_Bruto:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago3/100))
  //[ACT_Cargos]Monto_Moneda:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago3/100))
  //[ACT_Cargos]Saldo:=([ACT_Cargos]Monto_Neto-[ACT_Cargos]MontosPagados)*-1
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados
  //
  //arACT_CMontoNeto{DA_Return{$i}}:=[ACT_Cargos]Monto_Neto
  //arACT_MontoMoneda{DA_Return{$i}}:=[ACT_Cargos]Monto_Moneda
  //arACT_CSaldo{DA_Return{$i}}:=[ACT_Cargos]Saldo
  //arACT_MontoPagado{DA_Return{$i}}:=[ACT_Cargos]MontosPagados
  //
  //: ($vd_date<=$fechaPago4)
  //[ACT_Cargos]Monto_Neto:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago4/100))
  //[ACT_Cargos]Monto_Bruto:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago4/100))
  //[ACT_Cargos]Monto_Moneda:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos]Monto_Moneda;[ACT_Cargos]Moneda;$vd_date)*(vr_pctXFechaPago4/100))
  //[ACT_Cargos]Saldo:=([ACT_Cargos]Monto_Neto-[ACT_Cargos]MontosPagados)*-1
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados
  //
  //arACT_CMontoNeto{DA_Return{$i}}:=[ACT_Cargos]Monto_Neto
  //arACT_MontoMoneda{DA_Return{$i}}:=[ACT_Cargos]Monto_Moneda
  //arACT_CSaldo{DA_Return{$i}}:=[ACT_Cargos]Saldo
  //arACT_MontoPagado{DA_Return{$i}}:=[ACT_Cargos]MontosPagados
  //Else   `no se descuenta si paga después de la última fecha 
  //End case 
  //SAVE RECORD([ACT_Cargos])
  //KRL_UnloadReadOnly (->[ACT_Cargos])
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_Documento=alACT_CIdDctoCargo{DA_Return{$i}})
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
  //$el:=Find in array(alACT_AIDAviso;[ACT_Avisos_de_Cobranza]ID_Aviso)
  //If ($el>0)
  //arACT_AMontoNeto{$el}:=AT_GetSumArrayByArrayPos (alACT_AIDAviso{$el};"=";->alACT_CIdsAvisos;->arACT_CMontoNeto)
  //arACT_AMontoMoneda{$el}:=arACT_AMontoNeto{$el}
  //End if 
  //ACTpgs_RecalculaAvisosInArrays 
  //End for 
  //End case 
  //End if 
  //Else 
  //If (vb_entroUnaVez)
  //vb_entroUnaVez:=False
  //alACT_CRefs{0}:=vl_idIE  `el id del ítem de recargo por adelantado cargado en ACTpgs_LoadCargosEspeciales(2)
  //AT_SearchArray (->alACT_CRefs;"=")
  //For ($i;1;Size of array(DA_Return))
  //READ WRITE([ACT_Cargos])
  //READ WRITE([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //GOTO RECORD([ACT_Cargos];alACT_RecNumsCargos{DA_Return{$i}})
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=alACT_CIdsAvisos{DA_Return{$i}})
  //If ([ACT_Avisos_de_Cobranza]Monto_a_Pagar>0)
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_Documento=[ACT_Cargos]ID_Documento_de_Cargo)
  //$vl_rNDctoCargo:=Record number([ACT_Documentos_de_Cargo])
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
  //$rnAviso:=Record number([ACT_Avisos_de_Cobranza])
  //[ACT_Cargos]Monto_Neto:=ACTut_retornaValorEnMoneda (1;vr_montoIE;[ACT_Cargos]Moneda;$vd_date)
  //[ACT_Cargos]Monto_Bruto:=ACTut_retornaValorEnMoneda (1;vr_montoIE;[ACT_Cargos]Moneda;$vd_date)
  //[ACT_Cargos]Monto_Moneda:=vr_montoIE
  //[ACT_Cargos]Saldo:=([ACT_Cargos]Monto_Neto-[ACT_Cargos]MontosPagados)*-1
  //SAVE RECORD([ACT_Cargos])
  //$el:=ACTcc_CalculaDocumentoCargo ($vl_rNDctoCargo)
  //If ($rnAviso>0)
  //ACTac_Recalcular ($rnAviso)
  //End if 
  //End if 
  //End for 
  //End if 
  //End if 