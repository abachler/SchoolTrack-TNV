//%attributes = {}
  //ACTcc_LoadTransacciones

READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Cargos:173])

If (Count parameters:C259=1)
	If ($1>0)
		atACT_TipoTransacciones:=$1
	Else 
		atACT_TipoTransacciones:=5
	End if 
Else 
	If (atACT_TipoTransacciones=0)
		atACT_TipoTransacciones:=5
	End if 
End if 

$tipoTransaccion:=atACT_TipoTransacciones

Case of 
		
	: ($tipoTransaccion=5)  // todas las transacciones
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
		OBJECT SET VISIBLE:C603(*;"@Cargos@";False:C215)
		_O_DISABLE BUTTON:C193(bDelCargos)
	: ($tipoTransaccion=4)  //solo pagos
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
		OBJECT SET VISIBLE:C603(*;"@Cargos@";False:C215)
	: ($tipoTransaccion=3)  //solo cargos proyectyados
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & [ACT_Transacciones:178]ID_Item:3#0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10=0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
		OBJECT SET VISIBLE:C603(*;"@Cargos@";True:C214)
		_O_DISABLE BUTTON:C193(bDelCargos)
	: ($tipoTransaccion=2)  //Colo cargos emitidos
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & [ACT_Transacciones:178]ID_Item:3#0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
		OBJECT SET VISIBLE:C603(*;"@Cargos@";True:C214)
		_O_DISABLE BUTTON:C193(bDelCargos)
	: ($tipoTransaccion=1)  //cargos emitidos y pagos
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3#0;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; | [ACT_Transacciones:178]ID_Pago:4#0)
		OBJECT SET VISIBLE:C603(*;"@Cargos@";False:C215)
End case 

Case of 
	: ((vd_TransDesde#!00-00-00!) & (vd_TransHasta#!00-00-00!))
		If (vd_TransHasta>=vd_TransDesde)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5>=vd_TransDesde;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Fecha:5<=vd_TransHasta)
		Else 
			BEEP:C151
		End if 
	: (vd_TransDesde#!00-00-00!)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5>=vd_TransDesde)
	: (vd_TransHasta#!00-00-00!)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=vd_TransHasta)
End case 

C_TEXT:C284($vt_set)
$vt_set:="Todas"
ACTcar_OpcionesGenerales ("FiltraYQuitaTransaccionesNC";->$vt_set)
USE SET:C118($vt_set)
CLEAR SET:C117($vt_set)

ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4;>;[ACT_Transacciones:178]Fecha:5;<;[ACT_Cargos:173]Ref_Item:16;>;[ACT_Transacciones:178]Glosa:8;>)
ARRAY LONGINT:C221(aACT_ItemIDs;0)
ARRAY LONGINT:C221(aACT_CtasTRefItem;0)
ARRAY PICTURE:C279(apACT_CtasTAfecta;0)
ARRAY TEXT:C222(aACT_CtasTMoneda;0)
SELECTION TO ARRAY:C260([ACT_Transacciones:178]Fecha:5;aACT_CtasTFecha;[ACT_Transacciones:178]RefPeriodo:12;aACT_CtasTPeriodo;[ACT_Transacciones:178]Glosa:8;aACT_CtasTGlosa;[ACT_Transacciones:178]Debito:6;aACT_CtasTDebito;[ACT_Transacciones:178]Credito:7;aACT_CtasTCredito;[ACT_Transacciones:178]ID_Item:3;aACT_ItemIDs;[ACT_Transacciones:178]No_Boleta:9;$aACT_CtasBoleta;[ACT_Transacciones:178]ID_Pago:4;$aACT_Pago)
ACTcar_OpcionesGenerales ("CargaMonedasCargos";->aACT_ItemIDs;->aACT_CtasTMoneda)
ARRAY TEXT:C222(aACT_CtasTBoleta;0)
ARRAY TEXT:C222(aACT_CtasTBoleta;Size of array:C274(aACT_ItemIDs))
ARRAY LONGINT:C221(aACT_CtasTRefItem;Size of array:C274(aACT_ItemIDs))
ARRAY PICTURE:C279(apACT_CtasTAfecta;Size of array:C274(aACT_ItemIDs))
_O_ARRAY STRING:C218(6;aACT_TipoTransaccion;Size of array:C274(aACT_ItemIDs))
For ($i;1;Size of array:C274(aACT_ItemIDs))
	$Cargo:=Find in field:C653([ACT_Cargos:173]ID:1;aACT_ItemIDs{$i})
	If ($Cargo#-1)
		GOTO RECORD:C242([ACT_Cargos:173];$Cargo)
		aACT_CtasTRefItem{$i}:=[ACT_Cargos:173]Ref_Item:16
		If ([ACT_Cargos:173]TasaIVA:21#0)
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_CtasTAfecta{$i})
		Else 
			GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_CtasTAfecta{$i})
		End if 
		If ($aACT_Pago{$i}>0)
			aACT_TipoTransaccion{$i}:="P"
		Else 
			READ ONLY:C145([xxACT_ItemsMatriz:180])
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			$noMatriz2:=([ACT_Documentos_de_Cargo:174]ID_Matriz:2=-2)
			QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_CuentasCorrientes:175]ID_Matriz:7)
			QUERY SELECTION:C341([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
			$NoEnMatriz:=(Records in selection:C76([xxACT_ItemsMatriz:180])=0)
			$descto:=([ACT_Cargos:173]Monto_Neto:5<0)
			$emitido:=([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
			aACT_TipoTransaccion{$i}:=ST_Boolean2Str (($descto);"D";"C")+"."+ST_Boolean2Str ((($noMatriz2) | ($NoEnMatriz));"NM";"M")+"."+ST_Boolean2Str (($emitido);"E";"P")
		End if 
	End if 
	$Boleta:=Find in field:C653([ACT_Boletas:181]ID:1;$aACT_CtasBoleta{$i})
	If ($Boleta#-1)
		GOTO RECORD:C242([ACT_Boletas:181];$Boleta)
		aACT_CtasTBoleta{$i}:=[ACT_Boletas:181]TipoDocumento:7+" Nº "+String:C10([ACT_Boletas:181]Numero:11)
	End if 
End for 
