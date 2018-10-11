//%attributes = {}
  //PP_LoadCobranzaDetalle

ACT_relacionaCtasyApdos (2)
C_TEXT:C284($0)
C_LONGINT:C283($1)
LOAD RECORD:C52([Personas:7])
ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
FIRST RECORD:C50([ACT_CuentasCorrientes:175])
ARRAY REAL:C219(arACT_CCVencido;0)
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
$index:=Records in selection:C76([ACT_CuentasCorrientes:175])
ARRAY REAL:C219(arACT_CCVencido;$index)  //Total Final
ARRAY REAL:C219(arACT_CCVencidoMoneda;$index)  //Total Final
ARRAY TEXT:C222(atACT_CCHijos;$index)

  //ARRAY LONGINT(aiACT_MesesVencidosAux;0)  `Detalle de seleccion
ARRAY LONGINT:C221(aiACT_MesesVencidosAux;0)
ARRAY TEXT:C222(atACT_MonedaCargo;0)
ARRAY DATE:C224(adACT_FechaEmicion;0)
ARRAY REAL:C219(arACT_VencidosPesosAux;0)  //Detalle de seleccion
ARRAY LONGINT:C221(aiACT_MesesDistintos;0)

ARRAY TEXT:C222(atACT_MesesVdosPalabras;0)  //Detalle Final
ARRAY REAL:C219(arACT_VencidosMoneda;0)  //Detalle Final
ARRAY REAL:C219(arACT_VencidosPesos;0)  //Detalle Final
ARRAY TEXT:C222(atACT_CCAlumno;0)  //Detalle Final
ARRAY TEXT:C222(atACT_CCCurso;0)  //Detalle Final

C_REAL:C285($sumaauxiliar)
ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)

For ($o;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	$NombredelAlumno:=[Alumnos:2]apellidos_y_nombres:40
	$CursodelAlumno:=[Alumnos:2]curso:20
	atACT_CCHijos{$o}:=$CursodelAlumno+" "+$NombredelAlumno
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*);*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
	
	SELECTION TO ARRAY:C260([ACT_Cargos:173]Mes:13;aiACT_MesesVencidosAux;[ACT_Cargos:173]Saldo:23;arACT_VencidosPesosAux;[ACT_Cargos:173]Moneda:28;atACT_MonedaCargo;[ACT_Cargos:173]FechaEmision:22;adACT_FechaEmicion)
	arACT_CCVencido{$o}:=Sum:C1([ACT_Cargos:173]Saldo:23)*(-1)
	
	DISTINCT VALUES:C339([ACT_Cargos:173]Mes:13;aiACT_MesesDistintos)
	
	SORT ARRAY:C229(aiACT_MesesDistintos;>)
	
	$sumamoneda:=0
	$sumapesos:=0
	
	
	For ($y;1;Size of array:C274(aiACT_MesesDistintos))
		AT_Insert (0;1;->atACT_MesesVdosPalabras;->arACT_VencidosMoneda;->atACT_CCAlumno;->atACT_CCCurso;->arACT_VencidosPesos)
		atACT_MesesVdosPalabras{Size of array:C274(atACT_MesesVdosPalabras)}:=aMeses{aiACT_MesesDistintos{$y}}
		atACT_CCAlumno{Size of array:C274(atACT_CCAlumno)}:=$NombredelAlumno
		atACT_CCCurso{Size of array:C274(atACT_CCCurso)}:=$CursodelAlumno
		For ($x;1;Size of array:C274(aiACT_MesesVencidosAux))
			If (aiACT_MesesVencidosAux{$x}=aiACT_MesesDistintos{$y})
				$conversion:=ACTut_fValorUF (adACT_FechaEmicion{$x})
				$sumamoneda:=$sumamoneda+Round:C94(((arACT_VencidosPesosAux{$x}/$conversion)*(-1));4)
				$sumapesos:=$sumapesos+((arACT_VencidosPesosAux{$x})*(-1))
			End if 
		End for 
		arACT_VencidosMoneda{Size of array:C274(arACT_VencidosMoneda)}:=$sumamoneda
		arACT_VencidosPesos{Size of array:C274(arACT_VencidosPesos)}:=$sumapesos
		$sumamoneda:=0
		$sumapesos:=0
	End for 
	QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[Personas:7]No:1)
	NEXT RECORD:C51([ACT_CuentasCorrientes:175])
End for 

vrACT_Deuda_Vencida:=AT_GetSumArray (->arACT_CCVencido)
vrACT_Deuda_VencidaMoneda:=AT_GetSumArray (->arACT_VencidosMoneda)
ARRAY TEXT:C222(atMesesFinales;0)
ARRAY TEXT:C222(atMesesFinales;Size of array:C274(atACT_MesesVdosPalabras))
C_TEXT:C284(vtMesesenPalabra)
COPY ARRAY:C226(atACT_MesesVdosPalabras;atMesesFinales)
AT_DistinctsArrayValues (->atMesesFinales)

  //Para ordenar los meses de menor a mayor.
ARRAY INTEGER:C220(aiOrdenMeses;0)
For ($i;1;Size of array:C274(atMesesFinales))
	AT_Insert (0;1;->aiOrdenMeses)
	aiOrdenMeses{Size of array:C274(aiOrdenMeses)}:=Find in array:C230(aMeses;atMesesFinales{$i})
End for 

ARRAY POINTER:C280(aPtrs;0)
ARRAY LONGINT:C221(aDir;0)
ARRAY POINTER:C280(aPtrs;2)
ARRAY LONGINT:C221(aDir;2)
aPtrs{1}:=->aiOrdenMeses
aPtrs{2}:=->atMesesFinales
aDir{1}:=1
aDir{2}:=0
MULTI SORT ARRAY:C718(aPtrs;aDir)

  //Para armar la frase.
vtMesesenPalabra:=""
For ($e;1;Size of array:C274(atMesesFinales))
	
	Case of 
		: (($e=Size of array:C274(atMesesFinales)) & (Size of array:C274(atMesesFinales)#1))
			vtMesesenPalabra:=vtMesesenPalabra+" y "+atMesesFinales{$e}
		: (Size of array:C274(atMesesFinales)=1)
			vtMesesenPalabra:=atMesesFinales{$e}
		Else 
			vtMesesenPalabra:=vtMesesenPalabra+" "+atMesesFinales{$e}+","
	End case 
	
End for 

If (Count parameters:C259>0)
	Case of 
		: ($1=1)
			$0:=String:C10(vrACT_Deuda_Vencida;"|Despliegue_ACT")
		: ($1=2)
			$0:=String:C10(vrACT_Deuda_VencidaMoneda;"|Despliegue_UF")
		: ($1=3)
			$0:=vtMesesenPalabra
	End case 
	
End if 

