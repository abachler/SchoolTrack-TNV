//%attributes = {}
  //ACTcc_CalculaMontos

C_LONGINT:C283($1;$IDCta)  //(ABK_Integracion_AT)
C_BOOLEAN:C305($vb_calculaApdo)
ARRAY LONGINT:C221($al_recNumCargos;0)

$IDCta:=$1  //ID de la cuenta corriente cuyos montos se van a recalcular
$0:=True:C214

If (Count parameters:C259=2)
	$vb_calculaApdo:=$2
Else 
	$vb_calculaApdo:=True:C214
End if 

READ ONLY:C145([ACT_Cargos:173])
READ WRITE:C146([ACT_CuentasCorrientes:175])
QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$IDCta)

If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
	If (Not:C34(Locked:C147([ACT_CuentasCorrientes:175])))
		If ($vb_calculaApdo)
			ARRAY REAL:C219(arACT_MontoProyectado;0)
			ARRAY REAL:C219(arACT_MontoEmitido;0)
			ARRAY REAL:C219(arACT_MontoPagado;0)
			ARRAY REAL:C219(arACT_MontoVencido;0)
		End if 
		
		[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18:=0
		[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16:=0
		[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17:=0
		[ACT_CuentasCorrientes:175]MontosProyectados_Ejercicio:14:=0
		[ACT_CuentasCorrientes:175]MontosVencidos_Ejercicio:15:=0
		[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21:=0
		[ACT_CuentasCorrientes:175]Total_DeudaVencida:22:=0
		[ACT_CuentasCorrientes:175]Total_emitidos:5:=0
		[ACT_CuentasCorrientes:175]Total_pagados:6:=0
		[ACT_CuentasCorrientes:175]Total_Saldos:8:=0
		[ACT_CuentasCorrientes:175]Proyectado_Futuro:24:=0
		[ACT_CuentasCorrientes:175]Emitido_Futuro:25:=0
		SAVE RECORD:C53([ACT_CuentasCorrientes:175])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$IDCta)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumCargos;"")
		For ($i;1;Size of array:C274($al_recNumCargos))
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCargos{$i})
			ACTcc_CalculaMontosCtasCtes 
			SAVE RECORD:C53([ACT_CuentasCorrientes:175])
		End for 
		READ ONLY:C145([ACT_Pagos:172])
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1)
		$saldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
		[ACT_CuentasCorrientes:175]Total_pagados:6:=[ACT_CuentasCorrientes:175]Total_pagados:6+$saldo
		[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17:=[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17+$saldo
		[ACT_CuentasCorrientes:175]Total_Saldos:8:=[ACT_CuentasCorrientes:175]Total_pagados:6-[ACT_CuentasCorrientes:175]Total_emitidos:5
		[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21:=[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17-[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16
		
		  //20130704 RCH Note problemas de redondeo...
		C_TEXT:C284($vt_monedaNacional)
		C_LONGINT:C283($vl_decimales)
		$vt_monedaNacional:=ST_GetWord (ACT_DivisaPais ;1;";")
		$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaNacional))
		[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18:=Round:C94([ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18;$vl_decimales)
		[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16:=Round:C94([ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16;$vl_decimales)
		[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17:=Round:C94([ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17;$vl_decimales)
		[ACT_CuentasCorrientes:175]MontosProyectados_Ejercicio:14:=Round:C94([ACT_CuentasCorrientes:175]MontosProyectados_Ejercicio:14;$vl_decimales)
		[ACT_CuentasCorrientes:175]MontosVencidos_Ejercicio:15:=Round:C94([ACT_CuentasCorrientes:175]MontosVencidos_Ejercicio:15;$vl_decimales)
		[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21:=Round:C94([ACT_CuentasCorrientes:175]Saldo_Ejercicio:21;$vl_decimales)
		[ACT_CuentasCorrientes:175]Total_DeudaVencida:22:=Round:C94([ACT_CuentasCorrientes:175]Total_DeudaVencida:22;$vl_decimales)
		[ACT_CuentasCorrientes:175]Total_emitidos:5:=Round:C94([ACT_CuentasCorrientes:175]Total_emitidos:5;$vl_decimales)
		[ACT_CuentasCorrientes:175]Total_pagados:6:=Round:C94([ACT_CuentasCorrientes:175]Total_pagados:6;$vl_decimales)
		[ACT_CuentasCorrientes:175]Total_Saldos:8:=Round:C94([ACT_CuentasCorrientes:175]Total_Saldos:8;$vl_decimales)
		[ACT_CuentasCorrientes:175]Proyectado_Futuro:24:=Round:C94([ACT_CuentasCorrientes:175]Proyectado_Futuro:24;$vl_decimales)
		[ACT_CuentasCorrientes:175]Emitido_Futuro:25:=Round:C94([ACT_CuentasCorrientes:175]Emitido_Futuro:25;$vl_decimales)
		
		SAVE RECORD:C53([ACT_CuentasCorrientes:175])
		If ($vb_calculaApdo)
			$rnApdo:=Find in field:C653([Personas:7]No:1;[ACT_CuentasCorrientes:175]ID_Apoderado:9)
			ACTpp_ActualizaValores ($rnApdo)
		End if 
		KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
		UNLOAD RECORD:C212([ACT_Pagos:172])
	Else 
		$0:=False:C215
	End if 
End if 