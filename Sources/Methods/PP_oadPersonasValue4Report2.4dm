//%attributes = {}
  //PP_oadPersonasValue4Report2


C_REAL:C285(vrACT_Total_Proyectado)
C_REAL:C285(vrACT_Total_Emitido)
C_REAL:C285(vrACT_Total_Pagado)
C_REAL:C285(vrACT_Total_Saldo)
C_REAL:C285(vrACT_Deuda_Vencida)
C_REAL:C285(vrACT_Saldo_Anterior)
C_DATE:C307(vdFechaCargoFin)
C_DATE:C307(vdFechaCargoIni)
C_LONGINT:C283($ultimodia)
C_LONGINT:C283($añoCalculo)
C_LONGINT:C283($vencidos)
C_REAL:C285($pagos)


vrACT_Saldo_Anterior:=0
$años:=vlSelAño-2000
For ($j;0;$años)
	
	ARRAY TEXT:C222(aMeses;0)
	COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
	ARRAY REAL:C219(arACT_Total_Proyectado;0)
	ARRAY REAL:C219(arACT_Total_Emitido;0)
	ARRAY REAL:C219(arACT_Deuda_Vencida;0)
	ARRAY REAL:C219(arACT_Total_Pagado;0)
	ARRAY REAL:C219(arACT_Total_Saldo;0)
	$añoCalculo:=2000+$j
	For ($i;1;12)
		AT_Insert (0;1;->arACT_Total_Proyectado;->arACT_Total_Emitido;->arACT_Deuda_Vencida;->arACT_Total_Pagado;->arACT_Total_Saldo)
		$ultimodia:=DT_GetLastDay ($i;vlSelAño)
		vdFechaCargoFin:=DT_GetDateFromDayMonthYear ($ultimodia;$i;$añoCalculo)
		vdFechaCargoIni:=DT_GetDateFromDayMonthYear (1;$i;$añoCalculo)
		LOAD RECORD:C52([Personas:7])
		ARRAY REAL:C219(arACT_CCFacturado;0)
		ARRAY REAL:C219(arACT_CCVencido;0)
		ARRAY REAL:C219(arACT_CCSaldo;0)
		ARRAY REAL:C219(arACT_CCProyectadoEjercicio;0)
		ARRAY REAL:C219(arACT_CCPagado;0)
		READ ONLY:C145([ACT_Pagos:172])
		
		AT_Insert (0;1;->arACT_CCFacturado;->arACT_CCVencido;->arACT_CCSaldo;->arACT_CCProyectadoEjercicio;->arACT_CCPagado)
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4;>=;vdFechaCargoIni;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4;<=;vdFechaCargoFin;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
		CREATE SET:C116([ACT_Cargos:173];"todos")
		
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		
		USE SET:C118("todos")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
		CREATE SET:C116([ACT_Cargos:173];"cargos")
		
		arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}+arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
		
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
		KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;>=;vdFechaCargoIni)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;<=;vdFechaCargoFin)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Nulo:14=False:C215)
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		CREATE SET:C116([ACT_Cargos:173];"posttrans")
		
		INTERSECTION:C121("cargos";"posttrans";"cargos")
		USE SET:C118("cargos")
		arACT_CCPagado{Size of array:C274(arACT_CCPagado)}:=Sum:C1([ACT_Pagos:172]Monto_Pagado:5)
		  //ALERT(String(Sum([ACT_Pagos]Monto_Pagado)))
		arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}:=arACT_CCPagado{Size of array:C274(arACT_CCPagado)}-arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
		SET_ClearSets ("cargos";"posttrans")
		
		USE SET:C118("todos")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7;>=;vdFechaCargoIni)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7;<=;vdFechaCargoFin)
		
		$vencidos:=Records in selection:C76([ACT_Cargos:173])
		If (($vencidos>0) & (arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}<0))
			arACT_CCVencido{Size of array:C274(arACT_CCVencido)}:=arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}
		Else 
			arACT_CCVencido{Size of array:C274(arACT_CCVencido)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))
		End if 
		
		$pagos:=0
		If (Records in set:C195("todos")=0)
			READ ONLY:C145([ACT_Pagos:172])
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2;>=;vdFechaCargoIni;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2;<=;vdFechaCargoFin;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
			$pagos:=Sum:C1([ACT_Pagos:172]Monto_Pagado:5)
			  //arACT_CCPagado{Size of array(arACT_CCPagado)}:=$pagos+Sum([ACT_Pagos]Saldo)
			arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}:=arACT_CCPagado{Size of array:C274(arACT_CCPagado)}-arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
		Else 
			CLEAR SET:C117("todos")
			READ ONLY:C145([ACT_Pagos:172])
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0;*)
			  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]Saldo>0;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2;>=;vdFechaCargoIni;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2;<=;vdFechaCargoFin;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
			$pagos:=Sum:C1([ACT_Pagos:172]Monto_Pagado:5)
			$montopagadocargo:=AT_GetSumArray (->arACT_CCPagado)
			If (($pagos>$montopagadocargo) & ($montopagadocargo#0))
				$pagos:=$pagos-$montopagadocargo
			Else 
				If (AT_GetSumArray (->arACT_CCPagado)>0)
					$pagos:=0
				End if 
			End if 
		End if 
		
		arACT_Total_Proyectado{$i}:=AT_GetSumArray (->arACT_CCProyectadoEjercicio)
		arACT_Total_Emitido{$i}:=AT_GetSumArray (->arACT_CCFacturado)
		arACT_Deuda_Vencida{$i}:=AT_GetSumArray (->arACT_CCVencido)
		arACT_Total_Pagado{$i}:=AT_GetSumArray (->arACT_CCPagado)+$pagos
		arACT_Total_Saldo{$i}:=AT_GetSumArray (->arACT_CCSaldo)+$pagos
		
	End for 
	
	vrACT_Total_Proyectado:=AT_GetSumArray (->arACT_Total_Proyectado)
	vrACT_Total_Emitido:=AT_GetSumArray (->arACT_Total_Emitido)
	vrACT_Total_Pagado:=AT_GetSumArray (->arACT_Total_Pagado)
	vrACT_Total_Saldo:=AT_GetSumArray (->arACT_Total_Saldo)+vrACT_Saldo_Anterior
	
	If (vrACT_Total_Saldo<0)
		vrACT_Deuda_Vencida:=vrACT_Total_Saldo
	Else 
		vrACT_Deuda_Vencida:=0
	End if 
	
	If ($añoCalculo#vlSelAño)
		vrACT_Saldo_Anterior:=vrACT_Total_Saldo
	End if 
	
End for 





