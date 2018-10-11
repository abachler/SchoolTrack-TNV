//%attributes = {}
C_DATE:C307($d_fecha1;$d_fecha2)
C_REAL:C285($r_montoEmitido;$r_montoPagado;$r_saldo)
C_POINTER:C301($1;$2)
C_POINTER:C301($parameterNames;$parameterValues)
C_OBJECT:C1216($ob_raiz)

$parameterNames:=$1
$parameterValues:=$2

$action:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"action")

SYS_SetFormatResources 
Case of 
	: ($action="detallexforma")
		$year:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"year"))
		$mes:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"mes"))
		$orden:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"orden"))
		$mes:=$mes+1
		$forma:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"forma")
		
		$json:=DASH_GeneraJSON ("detallexforma";->$year;->$mes;->$orden;->$forma)
		
	: ($action="observacionesapdo")
		$idapdo:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"id"))
		
		$json:=DASH_GeneraJSON ("observacionesapdo";->$idapdo)
		
	: ($action="saldoxmes")
		$year:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"year"))
		$mes:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"mes"))
		$orden:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"orden"))
		$mes:=$mes+1
		
		$json:=DASH_GeneraJSON ("saldoxmes";->$year;->$mes;->$orden)
		
	: ($action="formadepagoxmes")
		$year:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"year"))
		$mes:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"mes"))
		$mes:=$mes+1
		
		$json:=DASH_GeneraJSON ("formadepagoxmes";->$year;->$mes)
		
	: ($action="dashboard")
		$year:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"year"))
		READ ONLY:C145([ACT_Cargos:173])
		ARRAY REAL:C219($arMontosEmitidos;12)
		ARRAY REAL:C219($arMontosPagados;12)
		ARRAY REAL:C219($arSaldos;12)
		$totalEmitido:=0
		$totalPagado:=0
		$totalSaldo:=0
		For ($i;1;12)
			$d_fecha1:=DT_GetDateFromDayMonthYear (1;$i;$year)
			$d_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($i;$year);$i;$year)
			
			  //QUERY([ACT_Cargos];[ACT_Cargos]FechaEmision>=$d_fecha1;*)
			  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision<=$d_fecha2)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$d_fecha1;*)  //20180531 RCH Se iguala búsqueda de DASH_GeneraJSON.
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$d_fecha2;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129)  //quito la devolución de NC
			
			  //emitido para el periodo calculado al dia actual
			$r_montoEmitido:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			
			  //pagado para el periodo
			$r_montoPagado:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
			
			  //saldo para el periodo
			$r_saldo:=$r_montoEmitido-$r_montoPagado
			
			$arMontosEmitidos{$i}:=$r_montoEmitido
			$arMontosPagados{$i}:=$r_montoPagado
			$arSaldos{$i}:=$r_saldo
			
			$totalEmitido:=$totalEmitido+$r_montoEmitido
			$totalPagado:=$totalPagado+$r_montoPagado
			$totalSaldo:=$totalSaldo+$r_saldo
		End for 
		
		$divisa:=ACT_DivisaPais 
		$t_simbolo:=ST_GetWord ($divisa;2;";")
		$decimales:=<>vlACT_Decimales
		
		$totalEmitidoFormat:=String:C10($totalEmitido;"|Despliegue_ACT")
		$totalPagadoFormat:=String:C10($totalPagado;"|Despliegue_ACT")
		$totalSaldoFormat:=String:C10($totalSaldo;"|Despliegue_ACT")
		
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"sepDecimal")
		OB_SET ($ob_raiz;-><>tXS_RS_ThousandsSeparator;"sepMiles")
		OB_SET ($ob_raiz;->$t_simbolo;"simbmoneda")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$arMontosEmitidos;"emitido")
		OB_SET ($ob_raiz;->$arMontosPagados;"pagado")
		OB_SET ($ob_raiz;->$arSaldos;"saldo")
		OB_SET ($ob_raiz;->$totalEmitidoFormat;"totalemitido")
		OB_SET ($ob_raiz;->$totalPagadoFormat;"totalpagado")
		OB_SET ($ob_raiz;->$totalSaldoFormat;"totalsaldo")
		$json:=OB_Object2Json ($ob_raiz)
		
End case 
$0:=$json