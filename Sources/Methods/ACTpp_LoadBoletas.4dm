//%attributes = {}
  //ACTpp_LoadBoletas

C_TEXT:C284($vt_yearHist;$vt_queryOver;$vt_tipoAviso)
C_LONGINT:C283($vl_id)

ACTpp_FormArraysDeclarations ("ArreglosAvisos")

Case of 
	: (Count parameters:C259=1)
		$vt_yearHist:=$1
		$vt_queryOver:="personas"
	: (Count parameters:C259=2)
		$vt_yearHist:=$1
		$vt_queryOver:=$2
	Else 
		$vt_yearHist:=""
		$vt_queryOver:="personas"
End case 

If ($vt_queryOver="terceros")
	$vt_tipoAviso:="avisosTer"
	$vl_id:=[ACT_Terceros:138]Id:1
Else 
	$vt_tipoAviso:="avisos"
	$vl_id:=[Personas:7]No:1
End if 

  //If (Count parameters>=1)
  //$vt_yearHist:=$1
  //End if 

$year:=Num:C11(ST_GetWord ($vt_yearHist;1;"-"))
$month:=Num:C11(ST_GetWord ($vt_yearHist;2;"-"))

Case of 
	: ($year=0)
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		
		Case of 
			: ($vt_queryOver="terceros")
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Tercero:16=[ACT_Terceros:138]Id:1;*)
			: ($vt_queryOver="personas")
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Apoderado:11=[Personas:7]No:1;*)
			Else 
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Apoderado:11=[Personas:7]No:1;*)
		End case 
		
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0)
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;<)
		
		ARRAY LONGINT:C221($alACT_ApdosDCPagares;0)
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aACT_ApdosDCNoComprobante;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;aACT_ApdosDCFechaEmision;[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;aACT_ApdosDCNeto;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;aACT_ApdosDCSaldo;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aACT_ApdosDCID;[ACT_Avisos_de_Cobranza:124]Moneda:17;aACT_ApdosDCMoneda;[ACT_Avisos_de_Cobranza:124]Intereses:13;aACT_ApdosDCIntereses;[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;$alACT_ApdosDCPagares)
		For ($i;1;Size of array:C274($alACT_ApdosDCPagares))
			AT_Insert ($i;1;->alACT_ApdosDCPagares)
			$vl_idPagare:=$alACT_ApdosDCPagares{$i}
			If ($vl_idPagare#0)
				READ ONLY:C145([ACT_Pagares:184])
				KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$vl_idPagare)
				alACT_ApdosDCPagares{$i}:=[ACT_Pagares:184]Numero_Pagare:11
			End if 
		End for 
		
	Else 
		READ ONLY:C145([xxACT_Datos_de_Cierre:116])
		QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$year;*)
		QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$month)
		If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
			READ ONLY:C145([xxACT_ArchivosHistoricos:113])
			$key:=String:C10([xxACT_Datos_de_Cierre:116]Year:1;"0000")+"."+String:C10([xxACT_Datos_de_Cierre:116]Month:3;"00")+"."+$vt_tipoAviso+"."+String:C10($vl_id)+".@"
			QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Referencia:8=$key)
			For ($x;1;Records in selection:C76([xxACT_ArchivosHistoricos:113]))
				BLOB_ExpandBlob_byPointer (->[xxACT_ArchivosHistoricos:113]xData:3)
				$blob:=[xxACT_ArchivosHistoricos:113]xData:3
				$otRef:=OT BLOBToObject ($blob)
				APPEND TO ARRAY:C911(aACT_ApdosDCNoComprobante;OT GetLong ($otRef;"IDAviso"))
				APPEND TO ARRAY:C911(aACT_ApdosDCFechaEmision;OT GetDate ($otRef;"FechaEmision"))
				APPEND TO ARRAY:C911(aACT_ApdosDCNeto;OT GetReal ($otRef;"MontoNeto"))
				APPEND TO ARRAY:C911(aACT_ApdosDCSaldo;OT GetReal ($otRef;"MontoAPagar"))
				APPEND TO ARRAY:C911(aACT_ApdosDCID;OT GetLong ($otRef;"IDAviso"))
				APPEND TO ARRAY:C911(aACT_ApdosDCMoneda;OT GetText ($otRef;"Moneda"))
				APPEND TO ARRAY:C911(aACT_ApdosDCIntereses;OT GetReal ($otRef;"Intereses"))
				If (OT ItemExists ($otRef;"Pagares")=1)
					APPEND TO ARRAY:C911(alACT_ApdosDCPagares;OT GetLong ($otRef;"NumPagare"))
				Else 
					APPEND TO ARRAY:C911(alACT_ApdosDCPagares;0)
				End if 
				OT Clear ($otRef)
				NEXT RECORD:C51([xxACT_ArchivosHistoricos:113])
			End for 
		End if 
End case 

If (Size of array:C274(aACT_ApdosDCID)>0)
	ACTac_CargaCargosAviso (aYearsACT{aYearsACT};aACT_ApdosDCID{1};$vt_tipoAviso;$vl_id)
End if 
