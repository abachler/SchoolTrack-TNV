//%attributes = {}
  //PP_LoadPersonasValues4Report

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
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	CREATE SET:C116([ACT_Cargos:173];"todos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
	USE SET:C118("todos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
	arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
	arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}+arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
	arACT_CCPagado{Size of array:C274(arACT_CCPagado)}:=Sum:C1([ACT_Cargos:173]MontosPagados:8)+Sum:C1([ACT_Pagos:172]Saldo:15)
	arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}:=Sum:C1([ACT_Cargos:173]Saldo:23)+Sum:C1([ACT_Pagos:172]Saldo:15)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*))
	arACT_CCVencido{Size of array:C274(arACT_CCVencido)}:=Sum:C1([ACT_Cargos:173]Saldo:23)
	QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[Personas:7]No:1)
	NEXT RECORD:C51([ACT_CuentasCorrientes:175])
End for 
CLEAR SET:C117("todos")
READ ONLY:C145([ACT_Pagos:172])
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
$pagos:=Sum:C1([ACT_Pagos:172]Saldo:15)
vrACT_Total_Proyectado:=AT_GetSumArray (->arACT_CCProyectadoEjercicio)
vrACT_Total_Emitido:=AT_GetSumArray (->arACT_CCFacturado)
vrACT_Deuda_Vencida:=AT_GetSumArray (->arACT_CCVencido)
vrACT_Total_Pagado:=AT_GetSumArray (->arACT_CCPagado)+$pagos
vrACT_Total_Saldo:=AT_GetSumArray (->arACT_CCSaldo)+$pagos