//%attributes = {}
TRACE:C157
  //  //ACTac_Prepagar2
  //
  //C_BOOLEAN($2;$PrepagoPostPago)
  //
  //$RNAviso:=$1
  //$PrepagoPostPago:=False
  //If (Count parameters=2)
  //$PrepagoPostPago:=$2
  //End if 
  //CREATE EMPTY SET([ACT_Transacciones];"PonleBoleta")
  //READ WRITE([ACT_Cargos])
  //READ WRITE([ACT_Documentos_de_Cargo])
  //READ WRITE([ACT_Pagos])
  //GOTO RECORD([ACT_Avisos_de_Cobranza];$RNAviso)
  //SET QUERY LIMIT(1)
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=[ACT_Avisos_de_Cobranza]ID_Aviso)
  //SET QUERY LIMIT(0)
  //QUERY([ACT_Pagos];[ACT_Pagos]ID_Apoderado=[ACT_Documentos_de_Cargo]ID_Apoderado;*)
  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]Saldo>0;*)
  //If (Not($PrepagoPostPago))
  //Case of 
  //: (vlACT_PagosCta=1)
  //If ([ACT_Avisos_de_Cobranza]ID_CuentaCorrriente#0)
  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]ID_CtaCte=[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente)
  //Else 
  //QUERY([ACT_Pagos])
  //End if 
  //: (vlACT_PagosApdo=1)
  //QUERY([ACT_Pagos])
  //End case 
  //Else 
  //If (cb_OcupaSaldos=0)
  //Case of 
  //: (vbACT_PagoXCuenta)
  //If ([ACT_Avisos_de_Cobranza]ID_CuentaCorrriente#0)
  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]ID_CtaCte=[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente)
  //Else 
  //QUERY([ACT_Pagos])
  //End if 
  //: (vbACT_PagoXApdo)
  //QUERY([ACT_Pagos])
  //End case 
  //Else 
  //QUERY([ACT_Pagos])
  //End if 
  //End if 
  //
  //If (Records in selection([ACT_Pagos])=0)
  //UNLOAD RECORD([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Pagos])
  //Else 
  //ARRAY LONGINT($aRecNumPagos;0)
  //SELECTION TO ARRAY([ACT_Pagos];$aRecNumPagos)
  //For ($x;1;Size of array($aRecNumPagos))
  //GOTO RECORD([ACT_Pagos];$aRecNumPagos{$x})
  //$MontoPagado:=[ACT_Pagos]Saldo
  //vsACT_FormasdePago:=[ACT_Pagos]FormaDePago
  //vdACT_FechaPago:=[ACT_Pagos]Fecha
  //$idPago:=[ACT_Pagos]ID
  //GOTO RECORD([ACT_Avisos_de_Cobranza];$RNAviso)
  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]No_ComprobanteInterno;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
  //
  //ARRAY DATE(adACT_CFechaEmision;0)
  //ARRAY DATE(adACT_CFechaVencimiento;0)
  //ARRAY TEXT(atACT_CAlumno;0)
  //ARRAY TEXT(atACT_CGlosa;0)
  //ARRAY REAL(arACT_CMontoNeto;0)
  //ARRAY REAL(arACT_CIntereses;0)
  //ARRAY REAL(arACT_CSaldo;0)
  //ARRAY LONGINT(alACT_RecNumsCargos;0)
  //ARRAY LONGINT(alACT_CRefs;0)
  //ARRAY LONGINT(alACT_CIDCtaCte;0)
  //ARRAY STRING(2;asACT_Marcas;0)
  //ARRAY REAL(arACT_MontoMoneda;0)
  //ARRAY TEXT(atACT_MonedaCargo;0)
  //ARRAY TEXT(atACT_MonedaSimbolo;0)
  //
  //$CuantosCargos:=Records in selection([ACT_Cargos])
  //
  //SELECTION TO ARRAY([ACT_Cargos];alACT_RecNumsCargos;[ACT_Cargos]FechaEmision;adACT_CFechaEmision;[ACT_Cargos]Fecha_de_Vencimiento;adACT_CFechaVencimiento;[ACT_Cargos]Glosa;atACT_CGlosa;[ACT_Cargos]Monto_Neto;arACT_CMontoNeto;[ACT_Cargos]Intereses;arACT_CIntereses;[ACT_Cargos]Saldo;arACT_CSaldo;[ACT_Cargos]ID_CuentaCorriente;alACT_IDCtaCte;[ACT_Cargos]Ref_Item;alACT_CRefs;[ACT_Cargos]ID_CuentaCorriente;alACT_CIDCtaCte)
  //SELECTION TO ARRAY([ACT_Cargos]Monto_Moneda;arACT_MontoMoneda;[ACT_Cargos]Moneda;atACT_MonedaCargo)
  //
  //ARRAY STRING(2;asACT_Marcas;$CuantosCargos)
  //ARRAY TEXT(atACT_CAlumno;$CuantosCargos)
  //ARRAY TEXT(atACT_MonedaSimbolo;$CuantosCargos)
  //ARRAY TEXT(atACT_CGlosaImpresion;$CuantosCargos)
  //ARRAY STRING(2;asACT_Afecto;$CuantosCargos)
  //READ ONLY([Alumnos])
  //For ($j;1;$CuantosCargos)
  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID=alACT_IDCtaCte{$j})
  //QUERY([Alumnos];[Alumnos]Número=[ACT_CuentasCorrientes]ID_Alumno)
  //atACT_CAlumno{$j}:=[Alumnos]Apellidos_y_Nombres
  //End for 
  //
  //ACTpgs_OrdenaCargos 
  //
  //ARRAY LONGINT($alACT_RecNumsVenc;0)
  //ARRAY LONGINT($alACT_RecNumsNormales;0)
  //ARRAY LONGINT($alACT_RecNumsNegRef;0)
  //ARRAY LONGINT($alACT_RecNumsNoMatriz;0)
  //ARRAY LONGINT($alACT_RecNumsExcedentes;0)
  //ARRAY LONGINT($alACT_TodosSinExcedentes;0)
  //ARRAY LONGINT($alACT_RecNumsDsctos;0)
  //
  //For ($i;1;Size of array(adACT_CFechaVencimiento))
  //Case of 
  //: (asACT_Marcas{$i}="V")
  //INSERT IN ARRAY($alACT_RecNumsVenc;Size of array($alACT_RecNumsVenc)+1;1)
  //$alACT_RecNumsVenc{Size of array($alACT_RecNumsVenc)}:=alACT_RecNumsCargos{$i}
  //: (asACT_Marcas{$i}="N")
  //INSERT IN ARRAY($alACT_RecNumsNormales;Size of array($alACT_RecNumsNormales)+1;1)
  //$alACT_RecNumsNormales{Size of array($alACT_RecNumsNormales)}:=alACT_RecNumsCargos{$i}
  //: (asACT_Marcas{$i}="NR")
  //INSERT IN ARRAY($alACT_RecNumsNegRef;Size of array($alACT_RecNumsNegRef)+1;1)
  //$alACT_RecNumsNegRef{Size of array($alACT_RecNumsNegRef)}:=alACT_RecNumsCargos{$i}
  //: (asACT_Marcas{$i}="NM")
  //INSERT IN ARRAY($alACT_RecNumsNoMatriz;Size of array($alACT_RecNumsNoMatriz)+1;1)
  //$alACT_RecNumsNoMatriz{Size of array($alACT_RecNumsNoMatriz)}:=alACT_RecNumsCargos{$i}
  //End case 
  //End for 
  //
  //For ($i;1;Size of array(alACT_CRefs))
  //If (alACT_CRefs{$i}=-2)
  //INSERT IN ARRAY($alACT_RecNumsExcedentes;Size of array($alACT_RecNumsExcedentes)+1;1)
  //$alACT_RecNumsExcedentes{Size of array($alACT_RecNumsExcedentes)}:=alACT_RecNumsCargos{$i}
  //End if 
  //End for 
  //
  //For ($i;1;Size of array($alACT_RecNumsExcedentes))
  //$line:=Find in array(alACT_RecNumsCargos;$alACT_RecNumsExcedentes{$i})
  //If ($line#-1)
  //DELETE FROM ARRAY(alACT_RecNumsCargos;$line;1)
  //End if 
  //End for 
  //
  //For ($i;1;Size of array(alACT_RecNumsCargos))
  //If (arACT_CMontoNeto{$i}<0)
  //INSERT IN ARRAY($alACT_RecNumsDsctos;Size of array($alACT_RecNumsDsctos)+1;1)
  //$alACT_RecNumsDsctos{Size of array($alACT_RecNumsDsctos)}:=alACT_RecNumsCargos{$i}
  //End if 
  //End for 
  //
  //For ($i;1;Size of array($alACT_RecNumsDsctos))
  //$line:=Find in array(alACT_RecNumsCargos;$alACT_RecNumsDsctos{$i})
  //If ($line#-1)
  //DELETE FROM ARRAY(alACT_RecNumsCargos;$line;1)
  //End if 
  //End for 
  //
  //$DesctosAfectos:=0
  //$DesctosExentos:=0
  //READ WRITE([ACT_Cargos])
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //
  //For ($i_Cargos;1;Size of array(alACT_RecNumsCargos))
  //READ WRITE([ACT_Cargos])
  //GOTO RECORD([ACT_Cargos];alACT_RecNumsCargos{$i_Cargos})
  //READ WRITE([ACT_Documentos_de_Cargo])
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_Documento=[ACT_Cargos]ID_Documento_de_Cargo)
  //READ WRITE([ACT_Avisos_de_Cobranza])
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
  //
  //If ([ACT_Cargos]TasaIVA#0)
  //$iva:=True
  //PUSH RECORD([ACT_Cargos])
  //CREATE SELECTION FROM ARRAY([ACT_Cargos];$alACT_RecNumsDsctos)
  //$rnDC:=Record number([ACT_Documentos_de_Cargo])
  //CREATE SET([ACT_Cargos];"a")
  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;"")
  //QUERY SELECTION([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=[ACT_Avisos_de_Cobranza]ID_Aviso)
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
  //CREATE SET([ACT_Cargos];"b")
  //INTERSECTION("a";"b";"a")
  //USE SET("a")
  //SET_ClearSets ("a";"b")
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]TasaIVA#0;*)
  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0)
  //$DesctosAfectos:=Abs(Sum([ACT_Cargos]Monto_Neto))
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]MontosPagados:=[ACT_Cargos]Monto_Neto)
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]Saldo:=0)
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]Monto_Vencido:=0)
  //CREATE SET([ACT_Cargos];"cargosd")
  //$rnAC:=Record number([ACT_Avisos_de_Cobranza])
  //ARRAY LONGINT($aRNDocs;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Documentos_de_Cargo];$aRNDocs)
  //For ($rr;1;Size of array($aRNDocs))
  //ACTcc_CalculaDocumentoCargo ($aRNDocs{$rr})
  //End for 
  //READ WRITE([ACT_Avisos_de_Cobranza])
  //READ WRITE([ACT_Documentos_de_Cargo])
  //GOTO RECORD([ACT_Documentos_de_Cargo];$rnDC)
  //GOTO RECORD([ACT_Avisos_de_Cobranza];$rnAC)
  //USE SET("cargosd")
  //CLEAR SET("cargosd")
  //ARRAY LONGINT($alACT_RecNumsDescAfectos;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Cargos];$alACT_RecNumsDescAfectos;"")
  //FIRST RECORD([ACT_Cargos])
  //For ($thg;1;Records in selection([ACT_Cargos]))
  //CREATE RECORD([ACT_Transacciones])
  //[ACT_Transacciones]ID_Transaccion:=SQ_SeqNumber (->[ACT_Transacciones]ID_Transaccion)
  //[ACT_Transacciones]ID_CuentaCorriente:=[ACT_Cargos]ID_CuentaCorriente
  //[ACT_Transacciones]ID_Item:=[ACT_Cargos]ID
  //[ACT_Transacciones]Fecha:=vdACT_FechaPago
  //[ACT_Transacciones]Debito:=Abs([ACT_Cargos]Monto_Neto)
  //[ACT_Transacciones]Glosa:="Balanceo Descuento"
  //[ACT_Transacciones]No_Comprobante:=[ACT_Avisos_de_Cobranza]ID_Aviso
  //[ACT_Transacciones]ID_Apoderado:=[ACT_Cargos]ID_Apoderado
  //[ACT_Transacciones]RefPeriodo:=String([ACT_Cargos]Mes;"00")+String([ACT_Cargos]Año;"0000")
  //[ACT_Transacciones]ID_Pago:=$idPago
  //SAVE RECORD([ACT_Transacciones])
  //ADD TO SET([ACT_Transacciones];"PonleBoleta")
  //NEXT RECORD([ACT_Cargos])
  //End for 
  //READ WRITE([ACT_Documentos_de_Cargo])
  //GOTO RECORD([ACT_Documentos_de_Cargo];$rnDC)
  //POP RECORD([ACT_Cargos])
  //ONE RECORD SELECT([ACT_Cargos])
  //Case of 
  //: (Abs([ACT_Cargos]Saldo)>=($MontoPagado+$DesctosAfectos))
  //If (([ACT_Cargos]Intereses>=($MontoPagado+$DesctosAfectos)) & ([ACT_Cargos]Intereses>0))
  //  //[ACT_Cargos]Monto_Neto:=[ACT_Cargos]Monto_Neto-[ACT_Cargos]Intereses
  //  //[ACT_Cargos]Intereses:=[ACT_Cargos]Intereses-$MontoPagado
  //  //[ACT_Cargos]Monto_Neto:=[ACT_Cargos]Monto_Neto+[ACT_Cargos]Intereses
  //  //[ACT_Cargos]Fecha_de_Vencimiento:=Current date(*)+viACT_DiasRetardo
  //End if 
  //  //[ACT_Cargos]Intereses:=0
  //[ACT_Documentos_de_Cargo]Pagos:=[ACT_Documentos_de_Cargo]Pagos+$MontoPagado+$DesctosAfectos
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+$MontoPagado+$DesctosAfectos
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-$MontoPagado
  //$MontoTransaccion:=$MontoPagado
  //[ACT_Cargos]Saldo:=[ACT_Cargos]Saldo+$MontoPagado+$DesctosAfectos
  //$MontoPagado:=0
  //: (Abs([ACT_Cargos]Saldo)<($MontoPagado+$DesctosAfectos))
  //[ACT_Documentos_de_Cargo]Pagos:=[ACT_Documentos_de_Cargo]Pagos+Abs([ACT_Cargos]Saldo)
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-Abs([ACT_Cargos]Saldo)+$DesctosAfectos
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+Abs([ACT_Cargos]Saldo)
  //$MontoTransaccion:=Abs([ACT_Cargos]Saldo)-$DesctosAfectos
  //$MontoPagado:=$MontoPagado+[ACT_Cargos]Saldo+$DesctosAfectos
  //  //[ACT_Cargos]Intereses:=0
  //[ACT_Cargos]Saldo:=0
  //End case 
  //Else 
  //$iva:=False
  //PUSH RECORD([ACT_Cargos])
  //CREATE SELECTION FROM ARRAY([ACT_Cargos];$alACT_RecNumsDsctos)
  //$rnDC:=Record number([ACT_Documentos_de_Cargo])
  //CREATE SET([ACT_Cargos];"a")
  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;"")
  //QUERY SELECTION([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=[ACT_Avisos_de_Cobranza]ID_Aviso)
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
  //CREATE SET([ACT_Cargos];"b")
  //INTERSECTION("a";"b";"a")
  //USE SET("a")
  //SET_ClearSets ("a";"b")
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]TasaIVA=0;*)
  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0)
  //$DesctosExentos:=Abs(Sum([ACT_Cargos]Monto_Neto))
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]MontosPagados:=[ACT_Cargos]Monto_Neto)
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]Saldo:=0)
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]Monto_Vencido:=0)
  //CREATE SET([ACT_Cargos];"cargosd")
  //$rnAC:=Record number([ACT_Avisos_de_Cobranza])
  //ARRAY LONGINT($aRNDocs;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Documentos_de_Cargo];$aRNDocs)
  //For ($rr;1;Size of array($aRNDocs))
  //ACTcc_CalculaDocumentoCargo ($aRNDocs{$rr})
  //End for 
  //READ WRITE([ACT_Avisos_de_Cobranza])
  //READ WRITE([ACT_Documentos_de_Cargo])
  //GOTO RECORD([ACT_Documentos_de_Cargo];$rnDC)
  //GOTO RECORD([ACT_Avisos_de_Cobranza];$rnAC)
  //USE SET("cargosd")
  //CLEAR SET("cargosd")
  //ARRAY LONGINT($alACT_RecNumsDescExentos;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Cargos];$alACT_RecNumsDescExentos;"")
  //FIRST RECORD([ACT_Cargos])
  //For ($thg;1;Records in selection([ACT_Cargos]))
  //CREATE RECORD([ACT_Transacciones])
  //[ACT_Transacciones]ID_Transaccion:=SQ_SeqNumber (->[ACT_Transacciones]ID_Transaccion)
  //[ACT_Transacciones]ID_CuentaCorriente:=[ACT_Cargos]ID_CuentaCorriente
  //[ACT_Transacciones]ID_Item:=[ACT_Cargos]ID
  //[ACT_Transacciones]Fecha:=vdACT_FechaPago
  //[ACT_Transacciones]Debito:=Abs([ACT_Cargos]Monto_Neto)
  //[ACT_Transacciones]Glosa:="Balanceo Descuento"
  //[ACT_Transacciones]No_Comprobante:=[ACT_Avisos_de_Cobranza]ID_Aviso
  //[ACT_Transacciones]ID_Apoderado:=[ACT_Cargos]ID_Apoderado
  //[ACT_Transacciones]RefPeriodo:=String([ACT_Cargos]Mes;"00")+String([ACT_Cargos]Año;"0000")
  //[ACT_Transacciones]ID_Pago:=$idPago
  //SAVE RECORD([ACT_Transacciones])
  //ADD TO SET([ACT_Transacciones];"PonleBoleta")
  //NEXT RECORD([ACT_Cargos])
  //End for 
  //READ WRITE([ACT_Documentos_de_Cargo])
  //GOTO RECORD([ACT_Documentos_de_Cargo];$rnDC)
  //POP RECORD([ACT_Cargos])
  //ONE RECORD SELECT([ACT_Cargos])
  //Case of 
  //: (Abs([ACT_Cargos]Saldo)>=($MontoPagado+$DesctosExentos))
  //If (([ACT_Cargos]Intereses>=($MontoPagado+$DesctosExentos)) & ([ACT_Cargos]Intereses>0))
  //  //[ACT_Cargos]Monto_Neto:=[ACT_Cargos]Monto_Neto-[ACT_Cargos]Intereses
  //  //[ACT_Cargos]Intereses:=[ACT_Cargos]Intereses-$MontoPagado
  //  //[ACT_Cargos]Monto_Neto:=[ACT_Cargos]Monto_Neto+[ACT_Cargos]Intereses
  //  //[ACT_Cargos]Fecha_de_Vencimiento:=Current date(*)+viACT_DiasRetardo
  //End if 
  //  //[ACT_Cargos]Intereses:=0
  //[ACT_Documentos_de_Cargo]Pagos:=[ACT_Documentos_de_Cargo]Pagos+$MontoPagado+$DesctosExentos
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+$MontoPagado+$DesctosExentos
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-$MontoPagado
  //$MontoTransaccion:=$MontoPagado
  //[ACT_Cargos]Saldo:=[ACT_Cargos]Saldo+$MontoPagado+$DesctosExentos
  //$MontoPagado:=0
  //: (Abs([ACT_Cargos]Saldo)<($MontoPagado+$DesctosExentos))
  //
  //[ACT_Documentos_de_Cargo]Pagos:=[ACT_Documentos_de_Cargo]Pagos+Abs([ACT_Cargos]Saldo)
  //
  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-Abs([ACT_Cargos]Saldo)+$DesctosExentos
  //[ACT_Cargos]MontosPagados:=[ACT_Cargos]MontosPagados+Abs([ACT_Cargos]Saldo)
  //$MontoTransaccion:=Abs([ACT_Cargos]Saldo)-$DesctosExentos
  //$MontoPagado:=$MontoPagado+[ACT_Cargos]Saldo+$DesctosExentos
  //  //[ACT_Cargos]Intereses:=0
  //[ACT_Cargos]Saldo:=0
  //End case 
  //End if 
  //[ACT_Cargos]Monto_Vencido:=(Abs([ACT_Cargos]Monto_Neto)-[ACT_Cargos]MontosPagados)*-1
  //[ACT_Documentos_de_Cargo]Saldo:=[ACT_Documentos_de_Cargo]Pagos-[ACT_Documentos_de_Cargo]Monto_Neto
  //SAVE RECORD([ACT_Documentos_de_Cargo])
  //SAVE RECORD([ACT_Avisos_de_Cobranza])
  //SAVE RECORD([ACT_Cargos])
  //
  //  //Creacion de la transaccion
  //
  //If ($MontoTransaccion>0)
  //CREATE RECORD([ACT_Transacciones])
  //[ACT_Transacciones]ID_Transaccion:=SQ_SeqNumber (->[ACT_Transacciones]ID_Transaccion)
  //[ACT_Transacciones]ID_CuentaCorriente:=[ACT_Cargos]ID_CuentaCorriente
  //[ACT_Transacciones]ID_Item:=[ACT_Cargos]ID
  //[ACT_Transacciones]Fecha:=vdACT_FechaPago
  //[ACT_Transacciones]Debito:=$MontoTransaccion
  //[ACT_Transacciones]Glosa:="Pago con "+vsACT_FormasdePago
  //[ACT_Transacciones]No_Comprobante:=[ACT_Avisos_de_Cobranza]ID_Aviso
  //[ACT_Transacciones]ID_Apoderado:=[ACT_Cargos]ID_Apoderado
  //[ACT_Transacciones]RefPeriodo:=String([ACT_Cargos]Mes;"00")+String([ACT_Cargos]Año;"0000")
  //[ACT_Transacciones]ID_Pago:=$idPago
  //SAVE RECORD([ACT_Transacciones])
  //ADD TO SET([ACT_Transacciones];"PonleBoleta")
  //End if 
  //$ID_CargoPagado:=[ACT_Cargos]ID
  //If ($iva)
  //For ($rt;1;Size of array($alACT_RecNumsDescAfectos))
  //GOTO RECORD([ACT_Cargos];$alACT_RecNumsDescAfectos{$rt})
  //CREATE RECORD([ACT_Transacciones])
  //[ACT_Transacciones]ID_Transaccion:=SQ_SeqNumber (->[ACT_Transacciones]ID_Transaccion)
  //[ACT_Transacciones]ID_CuentaCorriente:=[ACT_Cargos]ID_CuentaCorriente
  //[ACT_Transacciones]ID_Item:=$ID_CargoPagado
  //[ACT_Transacciones]Fecha:=vdACT_FechaPago
  //[ACT_Transacciones]Debito:=Abs([ACT_Cargos]Monto_Neto)
  //[ACT_Transacciones]Glosa:="Pago con Descuento"
  //[ACT_Transacciones]No_Comprobante:=[ACT_Avisos_de_Cobranza]ID_Aviso
  //[ACT_Transacciones]ID_Apoderado:=[ACT_Cargos]ID_Apoderado
  //[ACT_Transacciones]RefPeriodo:=String([ACT_Cargos]Mes;"00")+String([ACT_Cargos]Año;"0000")
  //[ACT_Transacciones]ID_Pago:=$idPago
  //SAVE RECORD([ACT_Transacciones])
  //ADD TO SET([ACT_Transacciones];"PonleBoleta")
  //End for 
  //Else 
  //For ($rt;1;Size of array($alACT_RecNumsDescExentos))
  //GOTO RECORD([ACT_Cargos];$alACT_RecNumsDescExentos{$rt})
  //CREATE RECORD([ACT_Transacciones])
  //[ACT_Transacciones]ID_Transaccion:=SQ_SeqNumber (->[ACT_Transacciones]ID_Transaccion)
  //[ACT_Transacciones]ID_CuentaCorriente:=[ACT_Cargos]ID_CuentaCorriente
  //[ACT_Transacciones]ID_Item:=$ID_CargoPagado
  //[ACT_Transacciones]Fecha:=vdACT_FechaPago
  //[ACT_Transacciones]Debito:=Abs([ACT_Cargos]Monto_Neto)
  //[ACT_Transacciones]Glosa:="Pago con Descuento"
  //[ACT_Transacciones]No_Comprobante:=[ACT_Avisos_de_Cobranza]ID_Aviso
  //[ACT_Transacciones]ID_Apoderado:=[ACT_Cargos]ID_Apoderado
  //[ACT_Transacciones]RefPeriodo:=String([ACT_Cargos]Mes;"00")+String([ACT_Cargos]Año;"0000")
  //[ACT_Transacciones]ID_Pago:=$idPago
  //SAVE RECORD([ACT_Transacciones])
  //ADD TO SET([ACT_Transacciones];"PonleBoleta")
  //End for 
  //End if 
  //
  //UNLOAD RECORD([ACT_Avisos_de_Cobranza])
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //UNLOAD RECORD([ACT_Transacciones])
  //READ ONLY([ACT_Transacciones])
  //UNLOAD RECORD([ACT_Cargos])
  //READ ONLY([ACT_Cargos])
  //If ($MontoPagado=0)
  //$i_Cargos:=Size of array(alACT_RecNumsCargos)+1
  //End if 
  //End for 
  //[ACT_Pagos]Saldo:=$MontoPagado
  //SAVE RECORD([ACT_Pagos])
  //End for 
  //UNLOAD RECORD([ACT_Pagos])
  //READ ONLY([ACT_Pagos])
  //End if 
  //READ WRITE([ACT_Transacciones])
  //USE SET("PonleBoleta")
  //CLEAR SET("PonleBoleta")
  //ARRAY LONGINT($alACT_TransaccionesaPago;0)
  //LONGINT ARRAY FROM SELECTION([ACT_Transacciones];$alACT_TransaccionesaPago;"")
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
  //APPLY TO SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Boleta:=0)
  //End if 
  //POP RECORD([ACT_Transacciones])
  //[ACT_Transacciones]No_Boleta:=$id_boleta
  //SAVE RECORD([ACT_Transacciones])
  //ACTbol_EstadoBoleta ($id_boleta)
  //End for 
  //UNLOAD RECORD([ACT_Transacciones])
  //READ ONLY([ACT_Transacciones])