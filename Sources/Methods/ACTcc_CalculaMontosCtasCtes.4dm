//%attributes = {}
  //ACTcc_CalculaMontosCtasCtes
  //1 Modificado por: roberto (06-07-2010) Se agrega una condicion al if para no entrar a calcular los montos cuando la moneda es moneda nacional

C_REAL:C285(vrACT_Neto;vrACT_Pagado)
vrACT_Neto:=0
vrACT_Pagado:=0

C_DATE:C307($vd_date)
  //20111015 RCH Se quita de calculo los cargos de devolucion de dinero. item -129
  //If ([ACT_Cargos]Monto_Neto#0)
If (([ACT_Cargos:173]Monto_Neto:5#0) & ([ACT_Cargos:173]Ref_Item:16#-129))
	If (([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11) & (ST_GetWord (ACT_DivisaPais ;1;";")#[ACT_Cargos:173]Moneda:28))
		  //If ([ACT_Cargos]EmitidoSegúnMonedaCargo=True) `1
		PUSH RECORD:C176([ACT_Cargos:173])
		$neto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		POP RECORD:C177([ACT_Cargos:173])
		PUSH RECORD:C176([ACT_Cargos:173])
		$saldo:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))
		POP RECORD:C177([ACT_Cargos:173])
		$montosPagados:=[ACT_Cargos:173]MontosPagadosMPago:52
	Else 
		$neto:=[ACT_Cargos:173]Monto_Neto:5
		$saldo:=[ACT_Cargos:173]Saldo:23
		$montosPagados:=[ACT_Cargos:173]MontosPagados:8
	End if 
	$vt_monedaNacional:=ST_GetWord (ACT_DivisaPais ;1;";")
	$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaNacional))
	$neto:=Round:C94($neto;$vl_decimales)
	$saldo:=Round:C94($saldo;$vl_decimales)
	$montosPagados:=Round:C94($montosPagados;$vl_decimales)
	If ([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
		If ((Current date:C33(*)>[ACT_Cargos:173]Fecha_de_Vencimiento:7) & ([ACT_Cargos:173]Monto_Neto:5#0))
			[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18:=[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18+($saldo)
			[ACT_CuentasCorrientes:175]MontosVencidos_Ejercicio:15:=[ACT_CuentasCorrientes:175]MontosVencidos_Ejercicio:15+($saldo)
		End if 
		[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16:=[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16+$neto
	Else 
		[ACT_CuentasCorrientes:175]MontosProyectados_Ejercicio:14:=[ACT_CuentasCorrientes:175]MontosProyectados_Ejercicio:14+$neto
	End if 
	[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17:=[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17+$montosPagados
	[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21:=[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17-[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16
	If ([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
		[ACT_CuentasCorrientes:175]Total_emitidos:5:=[ACT_CuentasCorrientes:175]Total_emitidos:5+$neto
		If ((Current date:C33(*)>[ACT_Cargos:173]Fecha_de_Vencimiento:7) & ([ACT_Cargos:173]Monto_Vencido:30>0))
			[ACT_CuentasCorrientes:175]Total_Vencida:20:=[ACT_CuentasCorrientes:175]Total_Vencida:20+Abs:C99($saldo)
			[ACT_CuentasCorrientes:175]Total_DeudaVencida:22:=[ACT_Cargos:173]MontosPagados:8-[ACT_CuentasCorrientes:175]Total_Vencida:20
		End if 
	End if 
	[ACT_CuentasCorrientes:175]Total_pagados:6:=[ACT_CuentasCorrientes:175]Total_pagados:6+$montosPagados
	[ACT_CuentasCorrientes:175]Total_Saldos:8:=[ACT_CuentasCorrientes:175]Total_pagados:6-[ACT_CuentasCorrientes:175]Total_emitidos:5
	
	If ([ACT_Cargos:173]ID_Tercero:54#0)
		AT_Insert (1;1;->arACT_MontoProyectado;->arACT_MontoEmitido;->arACT_MontoPagado;->arACT_MontoVencido)
		If ([ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			arACT_MontoProyectado{1}:=$neto
		Else 
			arACT_MontoEmitido{1}:=$neto
			If ((Current date:C33(*)>[ACT_Cargos:173]Fecha_de_Vencimiento:7))
				arACT_MontoVencido{1}:=$neto-$montosPagados
			End if 
		End if 
		arACT_MontoPagado{1}:=$montosPagados
	End if 
	vrACT_Neto:=$neto
	vrACT_Pagado:=$montosPagados
End if 
KRL_UnloadReadOnly (->[ACT_Cargos:173])