//%attributes = {}
  //dbuACT_VerificaSaldos

ARRAY LONGINT:C221($alACT_idsApdo;0)
C_LONGINT:C283($vlACT_IdApdo)

If (Count parameters:C259=0)
	READ ONLY:C145([Personas:7])
	ALL RECORDS:C47([Personas:7])
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint2;0)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	SELECTION TO ARRAY:C260([Personas:7]No:1;aQR_Longint1)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Ejecutando script...")
	For ($i;1;Size of array:C274(aQR_Longint1))
		$vlACT_IdApdo:=dbuACT_VerificaSaldos (aQR_Longint1{$i})
		If ($vlACT_IdApdo#0)
			APPEND TO ARRAY:C911(aQR_Longint2;$vlACT_IdApdo)
			  //READ ONLY([ACT_Avisos_de_Cobranza])
			  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado=$vlACT_IdApdo)
			  //ARRAY LONGINT(aQR_Longint3;0)
			  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];aQR_Longint3;"")
			  //For ($x;1;Size of array(aQR_Longint3))
			  //ACTac_Recalcular (aQR_Longint3{$x})
			  //End for 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
Else 
	$vlACT_IdApdo:=$1
	
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Pagos:172])
	
	ARRAY REAL:C219(aQR_Real51;0)  //emitido cuenta
	ARRAY REAL:C219(aQR_Real52;0)  //pagos cuenta
	ARRAY REAL:C219(aQR_Real53;0)  //saldo cuenta
	
	ARRAY REAL:C219(aQR_Real54;0)  //emitido apdo
	ARRAY REAL:C219(aQR_Real55;0)  //pagos apdo
	ARRAY REAL:C219(aQR_Real56;0)  //saldo apdo
	
	ARRAY REAL:C219(aQR_Real57;0)  //emitido aviso
	ARRAY REAL:C219(aQR_Real58;0)  //interes aviso
	
	ARRAY REAL:C219(aQR_Real59;0)  //total pagado
	ARRAY REAL:C219(aQR_Real60;0)  //saldo
	
	QUERY:C277([Personas:7];[Personas:7]No:1=$vlACT_IdApdo)
	ACTpp_RecalculaSaldoApdo (Record number:C243([Personas:7]))
	QUERY:C277([Personas:7];[Personas:7]No:1=$vlACT_IdApdo)
	
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Apoderado:11=[Personas:7]No:1)
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
	SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]Total_emitidos:5;aQR_Real51;[ACT_CuentasCorrientes:175]Total_pagados:6;aQR_Real52)
	SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]Total_Saldos:8;aQR_Real53)
	
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
	
	KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Transacciones:178]ID_Apoderado:11;"")
	If (Records in selection:C76([Personas:7])>1)
		QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
	End if 
	
	SELECTION TO ARRAY:C260([Personas:7]MontosEmitidos_Ejercicio:82;aQR_Real54;[Personas:7]MontosPagados_Ejercicio:84;aQR_Real55)
	SELECTION TO ARRAY:C260([Personas:7]Saldo_Ejercicio:85;aQR_Real56)
	
	KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
	
	SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Monto_Neto:11;aQR_Real57;[ACT_Avisos_de_Cobranza:124]Intereses:13;aQR_Real58)
	  //For ($j;1;Size of array($alACT_idsApdo))
	  //GOTO RECORD([ACT_Avisos_de_Cobranza];$alACT_idsApdo{$j})
	  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=[ACT_Avisos_de_Cobranza]ID_Aviso)
	  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
	  //APPEND TO ARRAY(aQR_Real59;Sum([ACT_Cargos]MontosPagadosMPago))
	  //If (aQR_Real59{Size of array(aQR_Real59)}=0)
	  //aQR_Real59{Size of array(aQR_Real59)}:=Round(Sum([ACT_Cargos]MontosPagados);4)
	  //End if 
	  //End for 
	
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
	CREATE SET:C116([ACT_Pagos:172];"setPagos1")
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=$vlACT_IdApdo)
	CREATE SET:C116([ACT_Pagos:172];"setPagos2")
	UNION:C120("setPagos1";"setPagos2";"setPagos1")
	USE SET:C118("setPagos1")
	SET_ClearSets ("setPagos1";"setPagos2")
	  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]FormaDePago#"Nota de Crédito")
	QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30#-12)
	SELECTION TO ARRAY:C260([ACT_Pagos:172]Monto_Pagado:5;aQR_Real59;[ACT_Pagos:172]Saldo:15;aQR_Real60)
	
	
	$vr_emitidoCta:=AT_GetSumArray (->aQR_Real51)
	$vr_pagadoCta:=AT_GetSumArray (->aQR_Real52)
	$vr_saldoCta:=AT_GetSumArray (->aQR_Real53)
	
	$vr_emitidoApdo:=AT_GetSumArray (->aQR_Real54)
	$vr_pagosApdo:=AT_GetSumArray (->aQR_Real55)
	$vr_saldoApdo:=AT_GetSumArray (->aQR_Real56)
	
	$vr_netoAviso:=AT_GetSumArray (->aQR_Real57)
	$vr_interesAviso:=AT_GetSumArray (->aQR_Real58)
	
	$vr_pagadoPago:=AT_GetSumArray (->aQR_Real59)
	$vr_saldoPago:=AT_GetSumArray (->aQR_Real60)
	$vr_montoPagadoEnCargos:=$vr_pagadoPago-$vr_saldoPago
	
	$0:=0
	If (($vr_emitidoCta#$vr_emitidoApdo) | ($vr_emitidoCta#($vr_netoAviso+$vr_interesAviso)))
		  //problema con monto emitido
		$0:=$vlACT_IdApdo
	End if 
	
	If ((($vr_pagadoCta-$vr_saldoPago)#($vr_pagosApdo-$vr_saldoPago)) | (($vr_pagadoCta-$vr_saldoPago)#$vr_montoPagadoEnCargos))
		  //problema con monto `pagado
		$0:=$vlACT_IdApdo
	End if 
	
	If ((($vr_netoAviso-$vr_montoPagadoEnCargos)#Abs:C99($vr_saldoCta)) | (($vr_netoAviso-$vr_montoPagadoEnCargos)#Abs:C99($vr_saldoApdo)))
		  //problema en saldos
		$0:=$vlACT_IdApdo
	End if 
End if 