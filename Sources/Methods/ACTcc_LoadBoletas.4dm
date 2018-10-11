//%attributes = {}
  //ACTcc_LoadBoletas

C_TEXT:C284($vt_yearHist)
ACTcc_FormArraysDeclarations ("ArreglosAvisos")
If (Count parameters:C259>=1)
	$vt_yearHist:=$1
End if 

$year:=Num:C11(ST_GetWord ($vt_yearHist;1;"-"))
$month:=Num:C11(ST_GetWord ($vt_yearHist;2;"-"))

Case of 
	: ($year=0)
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0)
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;<)
		
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aACT_CtasDCNoComprobante;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;aACT_CtasDCFechaEmision;[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;aACT_CtasDCNeto;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;aACT_CtasDCSaldo;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aACT_CtasDCID;[ACT_Avisos_de_Cobranza:124]Moneda:17;aACT_CtasDCMoneda;[ACT_Avisos_de_Cobranza:124]Intereses:13;aACT_CtasDCIntereses)
	Else 
		READ ONLY:C145([xxACT_Datos_de_Cierre:116])
		QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$year;*)
		QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$month)
		If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
			READ ONLY:C145([xxACT_ArchivosHistoricos:113])
			$key:=String:C10([xxACT_Datos_de_Cierre:116]Year:1;"0000")+"."+String:C10([xxACT_Datos_de_Cierre:116]Month:3;"00")+"."+"avisosDesdeCtas"+"."+String:C10([ACT_CuentasCorrientes:175]ID:1)+".@"
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
				APPEND TO ARRAY:C911(aACT_CtasDCNoComprobante;OT GetLong ($otRef;"IDAviso"))
				APPEND TO ARRAY:C911(aACT_CtasDCFechaEmision;OT GetDate ($otRef;"FechaEmision"))
				APPEND TO ARRAY:C911(aACT_CtasDCNeto;OT GetReal ($otRef;"MontoNeto"))
				APPEND TO ARRAY:C911(aACT_CtasDCSaldo;OT GetReal ($otRef;"MontoAPagar"))
				APPEND TO ARRAY:C911(aACT_CtasDCID;OT GetLong ($otRef;"IDAviso"))
				APPEND TO ARRAY:C911(aACT_CtasDCMoneda;OT GetText ($otRef;"Moneda"))
				APPEND TO ARRAY:C911(aACT_CtasDCIntereses;OT GetReal ($otRef;"Intereses"))
				OT Clear ($otRef)
			End for 
		End if 
End case 

  //20110826 RCH Cuando no hay avisos, igual se mostraban los cargos ya que los arreglos no se inicializaban...
  //If (Size of array(aACT_CtasDCNoComprobante)>0)
  //ACTac_CargaCargosAviso (aYearsACT{aYearsACT};aACT_CtasDCNoComprobante{1};"avisosDesdeCtas";[ACT_CuentasCorrientes]ID)
  //End if 
C_LONGINT:C283($vl_idAviso)
If (Size of array:C274(aACT_CtasDCNoComprobante)>0)
	$vl_idAviso:=aACT_CtasDCNoComprobante{1}
End if 
ACTac_CargaCargosAviso (aYearsACT{aYearsACT};$vl_idAviso;"avisosDesdeCtas";[ACT_CuentasCorrientes:175]ID:1)
