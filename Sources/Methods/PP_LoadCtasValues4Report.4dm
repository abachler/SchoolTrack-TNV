//%attributes = {}
  //PP_LoadCtasValues4Report

C_BOOLEAN:C305(vbACT_PagosDelMes)
C_REAL:C285(vrACT_Total_Proyectado)
C_REAL:C285(vrACT_Total_Emitido)
C_REAL:C285(vrACT_Total_Pagado)
C_REAL:C285(vrACT_Total_Saldo)
C_REAL:C285(vrACT_Deuda_Vencida)
C_REAL:C285(vrACT_Saldo_Anterior)

C_REAL:C285(vrACT_Total_EmitidoT;vrACT_Total_PagadoT;vrACT_Total_SaldoT)

C_DATE:C307(vdFechaCargoFin)
C_DATE:C307(vdFechaCargoIni)
C_LONGINT:C283($ultimodia)
C_LONGINT:C283($añoCalculo)
C_LONGINT:C283($vencidos)
C_REAL:C285($pagos)

vrACT_Saldo_Anterior:=0

$year:=vlSelAño
ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
ARRAY REAL:C219(arACT_Total_Proyectado;0)
ARRAY REAL:C219(arACT_Total_Emitido;0)
ARRAY REAL:C219(arACT_Deuda_Vencida;0)
ARRAY REAL:C219(arACT_Total_Pagado;0)
ARRAY REAL:C219(arACT_Total_Saldo;0)
_O_ARRAY STRING:C218(15;asACT_FechaVencimiento;0)

If ($year=Year of:C25(Current date:C33(*)))
	$hasta:=Month of:C24(Current date:C33(*))
	AT_RedimArrays (Month of:C24(Current date:C33(*));->aMeses)
Else 
	$hasta:=12
End if 
vPeriodoInforme:=aMeses{1}+" a "+aMeses{Size of array:C274(aMeses)}+" de "+String:C10($year;"0000")
vFechaInforme:=String:C10(Current date:C33(*);Internal date short:K1:7)
For ($i;1;$hasta)
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=vtHL_SelectedElementText)
	QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	AT_Insert (0;1;->arACT_Total_Proyectado;->arACT_Total_Emitido;->arACT_Deuda_Vencida;->arACT_Total_Pagado;->arACT_Total_Saldo;->asACT_FechaVencimiento)
	$ultimodia:=DT_GetLastDay ($i;vlSelAño)
	vdFechaCargoFin:=DT_GetDateFromDayMonthYear ($ultimodia;$i;$year)
	vdFechaCargoIni:=DT_GetDateFromDayMonthYear (1;$i;$year)
	  //LOAD RECORD([Personas])
	ARRAY REAL:C219(arACT_CCFacturado;0)
	ARRAY REAL:C219(arACT_CCVencido;0)
	ARRAY REAL:C219(arACT_CCSaldo;0)
	ARRAY REAL:C219(arACT_CCProyectadoEjercicio;0)
	ARRAY REAL:C219(arACT_CCPagado;0)
	READ ONLY:C145([ACT_Pagos:172])
	
	AT_Insert (0;1;->arACT_CCFacturado;->arACT_CCVencido;->arACT_CCSaldo;->arACT_CCProyectadoEjercicio;->arACT_CCPagado)
	
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4;>=;vdFechaCargoIni;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4;<=;vdFechaCargoFin;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	CREATE SET:C116([ACT_Cargos:173];"todos")
	
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
	
	USE SET:C118("todos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
	ARRAY DATE:C224($fechas;0)
	SELECTION TO ARRAY:C260([ACT_Cargos:173]Fecha_de_Vencimiento:7;$fechas)
	SORT ARRAY:C229($fechas;>)
	
	arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
	arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}+arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
	
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
	CREATE SET:C116([ACT_Transacciones:178];"setTransacciones1")
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
	If (vbACT_PagosDelMes)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=$fechas{Size of array:C274($fechas)})
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Nulo:14=False:C215)
	Else 
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Nulo:14=False:C215)
	End if 
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
	CREATE SET:C116([ACT_Transacciones:178];"setTransacciones2")
	
	INTERSECTION:C121("setTransacciones1";"setTransacciones2";"setTransacciones2")
	USE SET:C118("setTransacciones2")
	ARRAY LONGINT:C221($al_recNumTransacciones;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
	arACT_CCPagado{Size of array:C274(arACT_CCPagado)}:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
	arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}:=arACT_CCPagado{Size of array:C274(arACT_CCPagado)}-arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
	SET_ClearSets ("setTransacciones1";"setTransacciones2")
	
	USE SET:C118("todos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7;>=;vdFechaCargoIni)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7;<=;vdFechaCargoFin)
	
	$vencidos:=Records in selection:C76([ACT_Cargos:173])
	If (($vencidos>0) & (arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}<0))
		arACT_CCVencido{Size of array:C274(arACT_CCVencido)}:=arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}
	Else 
		arACT_CCVencido{Size of array:C274(arACT_CCVencido)}:=Sum:C1([ACT_Cargos:173]Saldo:23)
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
		If (vlACT_PagosCta=1)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0;*)
		Else 
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1;*)
		End if 
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
	  //arACT_Total_Pagado{$i}:=AT_GetSumArray (->arACT_CCPagado)+$pagos
	  //arACT_Total_Saldo{$i}:=AT_GetSumArray (->arACT_CCSaldo)+$pagos
	arACT_Total_Pagado{$i}:=AT_GetSumArray (->arACT_CCPagado)
	arACT_Total_Saldo{$i}:=AT_GetSumArray (->arACT_CCSaldo)
	asACT_FechaVencimiento{$i}:=ST_Boolean2Str (($fechas{Size of array:C274($fechas)}#!00-00-00!);String:C10($fechas{Size of array:C274($fechas)};Internal date short special:K1:4);"")
	
End for 

vrACT_Total_Proyectado:=AT_GetSumArray (->arACT_Total_Proyectado)
vrACT_Total_Emitido:=AT_GetSumArray (->arACT_Total_Emitido)
vrACT_Total_Pagado:=AT_GetSumArray (->arACT_Total_Pagado)
vrACT_Total_Saldo:=AT_GetSumArray (->arACT_Total_Saldo)+vrACT_Saldo_Anterior

vrACT_Total_EmitidoT:=vrACT_Total_EmitidoT+vrACT_Total_Emitido
vrACT_Total_PagadoT:=vrACT_Total_PagadoT+vrACT_Total_Pagado
vrACT_Total_SaldoT:=vrACT_Total_SaldoT+vrACT_Total_Saldo

If (vrACT_Total_Saldo<0)
	vrACT_Deuda_Vencida:=vrACT_Total_Saldo
Else 
	vrACT_Deuda_Vencida:=0
End if 

  //If ($añoCalculo#vlSelAño)
  //vrACT_Saldo_Anterior:=vrACT_Total_Saldo
  //End if 