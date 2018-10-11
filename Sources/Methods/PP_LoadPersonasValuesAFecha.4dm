//%attributes = {}
  //PP_LoadPersonasValuesAFecha

ACT_relacionaCtasyApdos (2;"current")
LOAD RECORD:C52([Personas:7])
ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
FIRST RECORD:C50([ACT_CuentasCorrientes:175])
ARRAY REAL:C219(arACT_CCFacturado;0)
ARRAY REAL:C219(arACT_CCVencido;0)
ARRAY REAL:C219(arACT_CCSaldo;0)
ARRAY REAL:C219(arACT_CCProyectadoEjercicio;0)
ARRAY REAL:C219(arACT_CCPagado;0)
ARRAY TEXT:C222(atACT_CCAlumno;0)
ARRAY TEXT:C222(atACT_CCCurso;0)
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
READ ONLY:C145([ACT_Pagos:172])
For ($o;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
	AT_Insert (0;1;->arACT_CCFacturado;->arACT_CCVencido;->arACT_CCSaldo;->atACT_CCAlumno;->atACT_CCCurso;->arACT_CCProyectadoEjercicio;->arACT_CCPagado)
	ARRAY INTEGER:C220($aExApdode;Size of array:C274(arACT_CCVencido))
	
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	atACT_CCAlumno{Size of array:C274(atACT_CCAlumno)}:=[Alumnos:2]apellidos_y_nombres:40
	atACT_CCCurso{Size of array:C274(atACT_CCCurso)}:=[Alumnos:2]curso:20
	
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4;<=;vdFechaCargo;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	CREATE SET:C116([ACT_Cargos:173];"todos")
	
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	  //arACT_CCProyectadoEjercicio{Size of array(arACT_CCProyectadoEjercicio)}:=Sum([ACT_Cargos]Monto_Neto)+Sum([ACT_Cargos]Intereses)
	  //arACT_CCProyectadoEjercicio{Size of array(arACT_CCProyectadoEjercicio)}:=Sum([ACT_Cargos]Monto_Neto)
	arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;vdFechaCargo)
	USE SET:C118("todos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
	
	CREATE SET:C116([ACT_Cargos:173];"cargos")
	SET_ClearSets ("todos")
	CREATE SET:C116([ACT_Cargos:173];"todos")
	
	  //arACT_CCFacturado{Size of array(arACT_CCFacturado)}:=Sum([ACT_Cargos]Monto_Neto)+Sum([ACT_Cargos]Intereses)
	  //arACT_CCFacturado{Size of array(arACT_CCFacturado)}:=Sum([ACT_Cargos]Monto_Neto)
	arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;vdFechaCargo)
	arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}+arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
	
	
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
	
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
	QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=vdFechaCargo)
	
	
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
	
	
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	CREATE SET:C116([ACT_Cargos:173];"posttrans")
	INTERSECTION:C121("cargos";"posttrans";"cargos")
	USE SET:C118("cargos")
	arACT_CCPagado{Size of array:C274(arACT_CCPagado)}:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)+Sum:C1([ACT_Pagos:172]Saldo:15)
	arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}:=arACT_CCPagado{Size of array:C274(arACT_CCPagado)}-arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
	SET_ClearSets ("cargos";"posttrans")
	
	USE SET:C118("todos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7;<=;vdFechaCargo)
	  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Fecha_de_Vencimiento<Current date(*))
	$vencidos:=Records in selection:C76([ACT_Cargos:173])
	If (($vencidos>0) & (arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}#0))
		arACT_CCVencido{Size of array:C274(arACT_CCVencido)}:=arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}
	Else 
		  //arACT_CCVencido{Size of array(arACT_CCVencido)}:=Sum([ACT_Cargos]Saldo)
		arACT_CCVencido{Size of array:C274(arACT_CCVencido)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;vdFechaCargo)
	End if 
	QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[Personas:7]No:1)
	NEXT RECORD:C51([ACT_CuentasCorrientes:175])
	
End for 
CLEAR SET:C117("todos")
READ ONLY:C145([ACT_Pagos:172])
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2;<=;vdFechaCargo)
$pagos:=Sum:C1([ACT_Pagos:172]Saldo:15)

vrACT_Total_Proyectado:=AT_GetSumArray (->arACT_CCProyectadoEjercicio)
vrACT_Total_Emitido:=AT_GetSumArray (->arACT_CCFacturado)
vrACT_Deuda_Vencida:=AT_GetSumArray (->arACT_CCVencido)
vrACT_Total_Pagado:=AT_GetSumArray (->arACT_CCPagado)+$pagos
vrACT_Total_Saldo:=AT_GetSumArray (->arACT_CCSaldo)+$pagos



