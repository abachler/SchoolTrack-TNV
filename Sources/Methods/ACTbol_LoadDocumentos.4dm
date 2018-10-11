//%attributes = {}
  //ACTbol_LoadDocumentos

READ ONLY:C145([ACT_Boletas:181])
  //QUERY([ACT_Boletas];[ACT_Boletas]ID_Documento=vlACT_WTipoDoc)
ARRAY LONGINT:C221($al_idDoc;0)
AT_Text2Array (->$al_idDoc;vtACT_WTipoDocID;";")
QRY_QueryWithArray (->[ACT_Boletas:181]ID_Documento:13;->$al_idDoc)

Case of 
	: (vlACT_WTipoBusqueda=1)
		$num1:=Num:C11(vtACT_WDTDesde)
		$num2:=Num:C11(vtACT_WDTHasta)
		If (Num:C11(vtACT_WDTHasta)=0)
			$num2:=MAXLONG:K35:2
		End if 
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Numero:11>=$num1;*)
		QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11<=$num2)
	: (vlACT_WTipoBusqueda=2)
		$fecha1:=vdACT_WDTDesde
		$fecha2:=vdACT_WDTHasta
		If (vdACT_WDTDesde=!00-00-00!)
			$fecha1:=!1904-01-01!
		End if 
		If (vdACT_WDTHasta=!00-00-00!)
			$fecha2:=!3000-01-01!
		End if 
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$fecha1;*)
		QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$fecha2)
End case 
ARRAY LONGINT:C221(alACT_WDTRecNums;0)
ARRAY LONGINT:C221(alACT_WDTNumero;0)
ARRAY LONGINT:C221($idApdoWDT;0)
ARRAY LONGINT:C221($idTerceroWDT;0)
ARRAY TEXT:C222(atACT_WDTApdo;0)
ARRAY TEXT:C222(atACT_WDTEstado;0)
ARRAY DATE:C224(adACT_WDTFecha;0)
ARRAY REAL:C219(arACT_WDTAfecto;0)
ARRAY REAL:C219(arACT_WDTIVA;0)
ARRAY REAL:C219(arACT_WDTTotal;0)
ARRAY BOOLEAN:C223(abACT_WDTNulas;0)
_O_ARRAY STRING:C218(2;asACT_WDT_Duplis;0)
_O_ARRAY STRING:C218(2;asACT_WDT_Dates;0)
_O_ARRAY STRING:C218(2;asACT_WDT_Sincro;0)
ARRAY BOOLEAN:C223(abACT_WDTModificada;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];alACT_WDTRecNums;"")
  //20111125 AS se agrega arreglo  para  guardar los datos de terceros.
SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;alACT_WDTNumero;[ACT_Boletas:181]ID_Tercero:21;$idTerceroWDT;[ACT_Boletas:181]ID_Apoderado:14;$idApdoWDT;[ACT_Boletas:181]Estado:2;atACT_WDTEstado;[ACT_Boletas:181]FechaEmision:3;adACT_WDTFecha;[ACT_Boletas:181]Monto_Afecto:4;arACT_WDTAfecto;[ACT_Boletas:181]Monto_IVA:5;arACT_WDTIVA;[ACT_Boletas:181]Monto_Total:6;arACT_WDTTotal;[ACT_Boletas:181]Nula:15;abACT_WDTNulas)
READ ONLY:C145([Personas:7])
ARRAY TEXT:C222(atACT_WDTApdo;Size of array:C274(alACT_WDTNumero))
_O_ARRAY STRING:C218(2;asACT_WDT_Duplis;Size of array:C274(alACT_WDTNumero))
_O_ARRAY STRING:C218(2;asACT_WDT_Dates;Size of array:C274(alACT_WDTNumero))
_O_ARRAY STRING:C218(2;asACT_WDT_Sincro;Size of array:C274(alACT_WDTNumero))
ARRAY BOOLEAN:C223(abACT_WDTModificada;Size of array:C274(alACT_WDTNumero))
  //20111125 AS se modifica instrucción para listar el nombre del tercero.
For ($i;1;Size of array:C274($idApdoWDT))
	$found:=Find in field:C653([Personas:7]No:1;$idApdoWDT{$i})
	If ($found#-1)
		GOTO RECORD:C242([Personas:7];$found)
		atACT_WDTApdo{$i}:=[Personas:7]Apellidos_y_nombres:30
	Else 
		$found:=Find in field:C653([ACT_Terceros:138]Id:1;$idTerceroWDT{$i})
		If ($found#-1)
			GOTO RECORD:C242([ACT_Terceros:138];$found)
			atACT_WDTApdo{$i}:=[ACT_Terceros:138]Nombre_Completo:9
		End if 
	End if 
End for 