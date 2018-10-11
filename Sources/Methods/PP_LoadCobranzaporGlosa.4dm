//%attributes = {}
  //PP_LoadCobranzaporGlosa

C_BOOLEAN:C305($vb_agruparIntereses;$vb_insertElement)
C_LONGINT:C283($index;$i;$el;$x;$vl_idItem;$y;$hayNum)
C_REAL:C285($sumapesos;$sumamoneda)
$vb_insertElement:=True:C214

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
READ ONLY:C145([Personas:7])

C_LONGINT:C283($accion)  //1 apdo. 2 cta.
C_POINTER:C301($table;$field)
If (Count parameters:C259=1)
	$accion:=$1
Else 
	$accion:=0
End if 
If (($accion=0) | ($accion=1))
	ACT_relacionaCtasyApdos (2)
	$table:=->[ACT_Cargos:173]ID_Apoderado:18
	$field:=->[Personas:7]No:1
Else 
	QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	$table:=->[ACT_Cargos:173]ID_CuentaCorriente:2
	$field:=->[ACT_CuentasCorrientes:175]ID:1
End if 
C_TEXT:C284($0)
C_LONGINT:C283($1)
  //LOAD RECORD([Personas])
ARRAY REAL:C219(arACT_CCVencido;0)
$index:=Records in selection:C76([ACT_CuentasCorrientes:175])
ARRAY REAL:C219(arACT_CCVencido;$index)  //Total Final
ARRAY REAL:C219(arACT_CCVencidoMoneda;$index)  //Total Final
ARRAY TEXT:C222(atACT_CCHijos;$index)
ARRAY LONGINT:C221(alACT_MesesVencidosAux;0)  //Detalle de seleccion
ARRAY LONGINT:C221(alACT_AgnosVencidosAux;0)
ARRAY TEXT:C222(atACT_MonedaCargo;0)
ARRAY DATE:C224(adACT_FechaEmision;0)
ARRAY REAL:C219(arACT_VencidosPesosAux;0)  //Detalle de seleccion
ARRAY TEXT:C222(atACT_GlosasAux;0)
ARRAY TEXT:C222(atACT_GlosasDistintas;0)
ARRAY LONGINT:C221(alACT_MesesDistintos;0)  //Detalle para calculo
ARRAY TEXT:C222(atACT_MesesVdosPalabras;0)  //Detalle Final
ARRAY REAL:C219(arACT_VencidosMoneda;0)  //Detalle Final
ARRAY REAL:C219(arACT_VencidosPesos;0)  //Detalle Final
ARRAY TEXT:C222(atACT_CCAlumno;0)  //Detalle Final
ARRAY TEXT:C222(atACT_CCCurso;0)  //Detalle Final
ARRAY TEXT:C222(atACT_Glosas;0)  //Detalle Final
ARRAY TEXT:C222(atACT_MonedasCargos;0)
ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Apoderado=[Personas]No;*)
QUERY:C277([ACT_Cargos:173];$table->=$field->;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*);*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
CREATE SET:C116([ACT_Cargos:173];"todos")
  //ARRAY LONGINT($aRefs;0)
ARRAY LONGINT:C221(aQR_Longint4;0)
ARRAY BOOLEAN:C223(aQR_Boolean1;0)
SELECTION TO ARRAY:C260([ACT_Cargos:173]Año:14;alACT_AgnosVencidosAux;[ACT_Cargos:173]Mes:13;alACT_MesesVencidosAux;[ACT_Cargos:173]Saldo:23;arACT_VencidosPesosAux;[ACT_Cargos:173]Moneda:28;atACT_MonedaCargo;[ACT_Cargos:173]FechaEmision:22;adACT_FechaEmision;[ACT_Cargos:173]Glosa:12;atACT_GlosasAux;[ACT_Cargos:173]Ref_Item:16;aQR_Longint4;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;aQR_Boolean1)
READ ONLY:C145([xxACT_Items:179])
For ($i;1;Size of array:C274(aQR_Longint4))
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=aQR_Longint4{$i})
	If (Records in selection:C76([xxACT_Items:179])=1)
		atACT_GlosasAux{$i}:=[xxACT_Items:179]Glosa_de_Impresión:20
	End if 
End for 
COPY ARRAY:C226(atACT_GlosasAux;atACT_GlosasDistintas)
AT_DistinctsArrayValues (->atACT_GlosasDistintas)

ARRAY LONGINT:C221(aQR_Longint3;0)
ARRAY TEXT:C222(aQR_Text2;0)
For ($i;1;Size of array:C274(atACT_GlosasDistintas))  //se perdía la referencia del cargo
	ARRAY LONGINT:C221(aQR_Longint5;0)
	atACT_GlosasAux{0}:=atACT_GlosasDistintas{$i}
	AT_SearchArray (->atACT_GlosasAux;"=";->aQR_Longint5)
	For ($x;1;Size of array:C274(aQR_Longint5))
		aQR_Longint5{$x}:=aQR_Longint4{aQR_Longint5{$x}}
	End for 
	AT_DistinctsArrayValues (->aQR_Longint5)
	  // 20180124 Patricio Aliaga MOD ticket N° 198125, El formato utilizado genera "<<<", se quita ya que no es necesario formatear
	  //APPEND TO ARRAY(aQR_Text2;AT_array2text (->aQR_Longint5;";";"##0"))
	APPEND TO ARRAY:C911(aQR_Text2;AT_array2text (->aQR_Longint5;";"))
End for 
READ ONLY:C145([xxACT_Items:179])
For ($i;1;Size of array:C274(atACT_GlosasDistintas))
	USE SET:C118("todos")
	ARRAY LONGINT:C221(aQR_Longint3;0)
	AT_Text2Array (->aQR_Longint3;aQR_Text2{$i};";")
	QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;aQR_Longint3)
	  //QRY_QueryWithArray (->[ACT_Cargos]Ref_Item;->aQR_Longint3;True)
	If (Find in array:C230(aQR_Longint3;-100)>0)
		$vl_idItem:=-100
		$vb_agruparIntereses:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vl_idItem;->[xxACT_Items:179]AgruparInteresesAC:33)
	End if 
	ARRAY TEXT:C222(aQR_Text1;0)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint2;0)
	SELECTION TO ARRAY:C260([ACT_Cargos:173]Año:14;aQR_Longint1;[ACT_Cargos:173]Mes:13;aQR_Longint2)
	For ($x;1;Size of array:C274(aQR_Longint1))
		APPEND TO ARRAY:C911(aQR_Text1;String:C10(aQR_Longint1{$x};"0000")+String:C10(aQR_Longint2{$x};"00"))
	End for 
	AT_DistinctsArrayValues (->aQR_Text1)
	$sumamoneda:=0
	$sumapesos:=0
	For ($y;1;Size of array:C274(aQR_Text1))
		If ($vb_insertElement)
			AT_Insert (0;1;->atACT_MesesVdosPalabras;->arACT_VencidosMoneda;->arACT_VencidosPesos;->atACT_Glosas;->atACT_MonedasCargos)
		End if 
		atACT_Glosas{Size of array:C274(atACT_Glosas)}:=atACT_GlosasDistintas{$i}
		atACT_MesesVdosPalabras{Size of array:C274(atACT_MesesVdosPalabras)}:=aMeses{Num:C11(Substring:C12(aQR_Text1{$y};5;2))}
		For ($x;1;Size of array:C274(alACT_MesesVencidosAux))
			Case of 
				: ((alACT_MesesVencidosAux{$x}=Num:C11(Substring:C12(aQR_Text1{$y};5;2))) & (atACT_GlosasAux{$x}=atACT_GlosasDistintas{$i}) & (alACT_AgnosVencidosAux{$x}=Num:C11(Substring:C12(aQR_Text1{$y};1;4))))
					If (aQR_Boolean1{$x})
						$sumapesos:=$sumapesos+(ACTut_retornaMontoEnMoneda (arACT_VencidosPesosAux{$x};atACT_MonedaCargo{$x};Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))*-1)
						atACT_MonedasCargos{Size of array:C274(atACT_MonedasCargos)}:=atACT_MonedaCargo{$x}
					Else 
						$sumapesos:=$sumapesos+(arACT_VencidosPesosAux{$x}*-1)
						atACT_MonedasCargos{Size of array:C274(atACT_MonedasCargos)}:=ST_GetWord (ACT_DivisaPais ;1;";")
					End if 
					$sumamoneda:=$sumamoneda+ACTut_retornaMontoEnMoneda ($sumapesos;ST_GetWord (ACT_DivisaPais ;1;";");Current date:C33(*))
					If (Year of:C25(adACT_FechaEmision{$x})#Year of:C25(Current date:C33(*)))
						$hayNum:=Num:C11(atACT_MesesVdosPalabras{Size of array:C274(atACT_MesesVdosPalabras)})
						If ($hayNum=0)
							atACT_MesesVdosPalabras{Size of array:C274(atACT_MesesVdosPalabras)}:=atACT_MesesVdosPalabras{Size of array:C274(atACT_MesesVdosPalabras)}+"-"+Substring:C12(String:C10(Year of:C25(adACT_FechaEmision{$x}));3;2)
						End if 
					End if 
			End case 
		End for 
		If ($vb_agruparIntereses)
			atACT_MesesVdosPalabras{Size of array:C274(atACT_MesesVdosPalabras)}:=""
			$vb_insertElement:=False:C215
			arACT_VencidosMoneda{Size of array:C274(arACT_VencidosMoneda)}:=arACT_VencidosMoneda{Size of array:C274(arACT_VencidosMoneda)}+$sumamoneda
			arACT_VencidosPesos{Size of array:C274(arACT_VencidosPesos)}:=arACT_VencidosPesos{Size of array:C274(arACT_VencidosPesos)}+$sumapesos
		Else 
			arACT_VencidosMoneda{Size of array:C274(arACT_VencidosMoneda)}:=$sumamoneda
			arACT_VencidosPesos{Size of array:C274(arACT_VencidosPesos)}:=$sumapesos
		End if 
		$sumapesos:=0
		$sumamoneda:=0
	End for 
	If ($vb_agruparIntereses)
		$vb_insertElement:=True:C214
		$vb_agruparIntereses:=False:C215
	End if 
	QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[Personas:7]No:1)
	NEXT RECORD:C51([ACT_CuentasCorrientes:175])
End for 

vrACT_Deuda_Vencida:=AT_GetSumArray (->arACT_VencidosPesos)
vrACT_Deuda_VencidaMoneda:=AT_GetSumArray (->arACT_VencidosMoneda)
ARRAY TEXT:C222(atMesesFinales;0)
ARRAY TEXT:C222(atMesesFinales;Size of array:C274(atACT_MesesVdosPalabras))
C_TEXT:C284(vtMesesenPalabra)
COPY ARRAY:C226(atACT_MesesVdosPalabras;atMesesFinales)
AT_DistinctsArrayValues (->atMesesFinales)
vtMesesenPalabra:=""
CLEAR SET:C117("todos")