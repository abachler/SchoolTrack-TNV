//%attributes = {}
  //ACTpp_LoadPagos

ACTpp_FormArraysDeclarations ("ArreglosPagos")

C_TEXT:C284($vt_yearHist;$vt_tipo;$vl_loadFrom)
C_LONGINT:C283($vl_id)

$vl_loadFrom:="personas"
If (Count parameters:C259>=1)
	Case of 
		: (Count parameters:C259=1)
			$vt_yearHist:=$1
		: (Count parameters:C259=2)
			$vt_yearHist:=$1
			$vl_loadFrom:=$2
		Else 
			$vt_yearHist:=""
			$vl_loadFrom:="personas"
	End case 
End if 

If ($vl_loadFrom="terceros")
	$vt_tipo:="pagosTer"
	$vl_id:=[ACT_Terceros:138]Id:1
Else 
	$vt_tipo:="pagos"
	$vl_id:=[Personas:7]No:1
End if 

$year:=Num:C11(ST_GetWord ($vt_yearHist;1;"-"))
$month:=Num:C11(ST_GetWord ($vt_yearHist;2;"-"))

Case of 
	: ($year=0)
		If ($vl_loadFrom="terceros")
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26=[ACT_Terceros:138]Id:1)
		Else 
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
		End if 
		ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;<)
		  //SELECTION TO ARRAY([ACT_Pagos]Fecha;aACT_ApdosPFecha;[ACT_Pagos]forma_de_pago_new;aACT_ApdosPGlosa;[ACT_Pagos]Monto_Pagado;aACT_ApdosPMonto;[ACT_Pagos]ID;aACT_ApdosPIDPagos;[ACT_Pagos]Saldo;aACT_ApdosPSaldo;[ACT_Pagos]Nulo;aACT_ApdosPNulo)
		SELECTION TO ARRAY:C260([ACT_Pagos:172]Fecha:2;aACT_ApdosPFecha;[ACT_Pagos:172]id_forma_de_pago:30;aACT_IDsFormasPagos;[ACT_Pagos:172]Monto_Pagado:5;aACT_ApdosPMonto;[ACT_Pagos:172]ID:1;aACT_ApdosPIDPagos;[ACT_Pagos:172]Saldo:15;aACT_ApdosPSaldo;[ACT_Pagos:172]Nulo:14;aACT_ApdosPNulo)
		  //cargo el nombre de las formas de pago según el lenguaje seleccionado por el usuario
		For (vQR_long1;1;Size of array:C274(aACT_IDsFormasPagos))
			APPEND TO ARRAY:C911(aACT_ApdosPGlosa;ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->aACT_IDsFormasPagos{vQR_long1}))
		End for 
	Else 
		READ ONLY:C145([xxACT_Datos_de_Cierre:116])
		QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$year;*)
		QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$month)
		If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
			READ ONLY:C145([xxACT_ArchivosHistoricos:113])
			$key:=String:C10([xxACT_Datos_de_Cierre:116]Year:1;"0000")+"."+String:C10([xxACT_Datos_de_Cierre:116]Month:3;"00")+"."+$vt_tipo+"."+String:C10($vl_id)+".@"
			QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Referencia:8=$key)
			For ($x;1;Records in selection:C76([xxACT_ArchivosHistoricos:113]))
				BLOB_ExpandBlob_byPointer (->[xxACT_ArchivosHistoricos:113]xData:3)
				$blob:=[xxACT_ArchivosHistoricos:113]xData:3
				$otRef:=OT BLOBToObject ($blob)
				APPEND TO ARRAY:C911(aACT_ApdosPIDPagos;OT GetLong ($otRef;"IDPago"))
				APPEND TO ARRAY:C911(aACT_ApdosPFecha;OT GetDate ($otRef;"Fecha"))
				APPEND TO ARRAY:C911(aACT_ApdosPGlosa;OT GetText ($otRef;"FormadePago"))
				APPEND TO ARRAY:C911(aACT_ApdosPMonto;OT GetReal ($otRef;"Monto"))
				APPEND TO ARRAY:C911(aACT_ApdosPSaldo;OT GetReal ($otRef;"Saldo"))
				APPEND TO ARRAY:C911(aACT_ApdosPNulo;(OT GetLong ($otRef;"Nulo")=1))
				OT Clear ($otRef)
				NEXT RECORD:C51([xxACT_ArchivosHistoricos:113])
			End for 
		End if 
End case 

If (Size of array:C274(aACT_ApdosPIDPagos)>0)
	ACTpp_CargaDetallePago (aYearsACT{aYearsACT};1;aACT_ApdosPIDPagos{1};$vt_tipo;$vl_id)
End if 