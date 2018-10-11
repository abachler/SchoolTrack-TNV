//%attributes = {}
  //ACTcc_LoadPagos

C_TEXT:C284($vt_yearHist)
ACTcc_FormArraysDeclarations ("ArreglosPagos")
If (Count parameters:C259>=1)
	$vt_yearHist:=$1
End if 

$year:=Num:C11(ST_GetWord ($vt_yearHist;1;"-"))
$month:=Num:C11(ST_GetWord ($vt_yearHist;2;"-"))

Case of 
	: ($year=0)
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Pagos:172])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
		KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
		CREATE SET:C116([ACT_Pagos:172];"normales")
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1)
		CREATE SET:C116([ACT_Pagos:172];"cuenta")
		UNION:C120("normales";"cuenta";"pagos")
		USE SET:C118("pagos")
		SET_ClearSets ("normales";"cuenta";"pagos")
		ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;<)
		SELECTION TO ARRAY:C260([ACT_Pagos:172]Fecha:2;aACT_CtasPFecha;[ACT_Pagos:172]forma_de_pago_new:31;aACT_CtasPGlosa;[ACT_Pagos:172]Monto_Pagado:5;aACT_CtasPMonto;[ACT_Pagos:172]ID:1;aACT_CtasPIDPagos;[ACT_Pagos:172]Saldo:15;aACT_CtasPSaldo;[ACT_Pagos:172]Nulo:14;aACT_CtasPNulo)
	Else 
		READ ONLY:C145([xxACT_Datos_de_Cierre:116])
		QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$year;*)
		QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$month)
		If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
			READ ONLY:C145([xxACT_ArchivosHistoricos:113])
			$key:=String:C10([xxACT_Datos_de_Cierre:116]Year:1;"0000")+"."+String:C10([xxACT_Datos_de_Cierre:116]Month:3;"00")+"."+"pagosDesdeCtas"+"."+String:C10([ACT_CuentasCorrientes:175]ID:1)+".@"
			QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Referencia:8=$key)
			ARRAY TEXT:C222($at_referenciasHistoricas;0)
			SELECTION TO ARRAY:C260([xxACT_ArchivosHistoricos:113]Referencia:8;$at_referenciasHistoricas)
			For ($x;1;Size of array:C274($at_referenciasHistoricas))
				$ref:=$at_referenciasHistoricas{$x}
				KRL_FindAndLoadRecordByIndex (->[xxACT_ArchivosHistoricos:113]Referencia:8;->$ref)
				KRL_FindAndLoadRecordByIndex (->[xxACT_ArchivosHistoricos:113]ID:7;->[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9)
				BLOB_ExpandBlob_byPointer (->[xxACT_ArchivosHistoricos:113]xData:3)
				$blob:=[xxACT_ArchivosHistoricos:113]xData:3
				$otRef:=OT BLOBToObject ($blob)
				APPEND TO ARRAY:C911(aACT_CtasPIDPagos;OT GetLong ($otRef;"IDPago"))
				APPEND TO ARRAY:C911(aACT_CtasPFecha;OT GetDate ($otRef;"Fecha"))
				APPEND TO ARRAY:C911(aACT_CtasPGlosa;OT GetText ($otRef;"FormadePago"))
				APPEND TO ARRAY:C911(aACT_CtasPMonto;OT GetReal ($otRef;"Monto"))
				APPEND TO ARRAY:C911(aACT_CtasPSaldo;OT GetReal ($otRef;"Saldo"))
				APPEND TO ARRAY:C911(aACT_CtasPNulo;OT_GetBoolean ($otRef;"Nulo"))
				OT Clear ($otRef)
			End for 
		End if 
End case 

  //20110826 RCH Cuando no hay pagos, igual se mostraban los cargos ya que los arreglos no se inicializaban...
C_LONGINT:C283($vl_idPago)
If (Size of array:C274(aACT_CtasPIDPagos)>0)
	$vl_idPago:=aACT_CtasPIDPagos{1}
End if 
ACTpp_CargaDetallePago (aYearsACT{aYearsACT};1;$vl_idPago;"pagosDesdeCtas";[ACT_CuentasCorrientes:175]ID:1)