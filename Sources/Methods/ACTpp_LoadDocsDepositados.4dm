//%attributes = {}
  //ACTpp_LoadDocsDepositados

ACTpp_FormArraysDeclarations ("ArreglosDocDep")
  //C_TEXT($vt_yearHist)
  //If (Count parameters>=1)
  //$vt_yearHist:=$1
  //End if 
C_TEXT:C284($vt_yearHist;$vt_tipo)
C_LONGINT:C283($vl_id)

$vt_queryOver:="personas"
$vt_tipo:="docdep"
$vl_id:=[Personas:7]No:1
If (Count parameters:C259>=1)
	$vt_yearHist:=$1
	If (Count parameters:C259=2)
		$Ptr:=$2
		RESOLVE POINTER:C394($Ptr;$var;$tbl;$field)
		If (Table:C252(Table:C252($tbl))=(Table:C252(->[ACT_Terceros:138])))
			$vt_queryOver:="terceros"
			$vt_tipo:="docdepTer"
			$vl_id:=[ACT_Terceros:138]Id:1
		End if 
	End if 
End if 


$year:=Num:C11(ST_GetWord ($vt_yearHist;1;"-"))
$month:=Num:C11(ST_GetWord ($vt_yearHist;2;"-"))

Case of 
	: ($year=0)
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214;*)
		  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]ID_Apoderado=[Personas]No)
		Case of 
			: ($vt_queryOver="terceros")
				QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]ID_Tercero:48=[ACT_Terceros:138]Id:1)
			: ($vt_queryOver="personas")
				QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]ID_Apoderado:2=[Personas:7]No:1)
			Else 
				QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]ID_Apoderado:2=[Personas:7]No:1)
		End case 
		ORDER BY:C49([ACT_Documentos_de_Pago:176]FechaPago:4;<)
		SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]ID:1;aACT_ApdosDDID;[ACT_Documentos_de_Pago:176]Fecha:13;aACT_ApdosDDFechaDoc;[ACT_Documentos_de_Pago:176]NoSerie:12;aACT_ApdosDDNumeroDoc;[ACT_Documentos_de_Pago:176]MontoPago:6;aACT_ApdosDDMontoDoc;[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7;aACT_ApdosDDBancoDoc;[ACT_Documentos_de_Pago:176]Tipodocumento:5;aACT_ApdosDDTipoDcto)
		
	Else 
		ARRAY BOOLEAN:C223($ab_depositado;0)
		READ ONLY:C145([xxACT_Datos_de_Cierre:116])
		QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$year;*)
		QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$month)
		If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
			READ ONLY:C145([xxACT_ArchivosHistoricos:113])
			  //$key:=String([xxACT_Datos_de_Cierre]Year;"0000")+"."+String([xxACT_Datos_de_Cierre]Month;"00")+"."+"docdep"+"."+String([Personas]No)+".@"
			$key:=String:C10([xxACT_Datos_de_Cierre:116]Year:1;"0000")+"."+String:C10([xxACT_Datos_de_Cierre:116]Month:3;"00")+"."+$vt_tipo+"."+String:C10($vl_id)+".@"
			QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Referencia:8=$key)
			For ($x;1;Records in selection:C76([xxACT_ArchivosHistoricos:113]))
				BLOB_ExpandBlob_byPointer (->[xxACT_ArchivosHistoricos:113]xData:3)
				$blob:=[xxACT_ArchivosHistoricos:113]xData:3
				$otRef:=OT BLOBToObject ($blob)
				APPEND TO ARRAY:C911(aACT_ApdosDDID;OT GetLong ($otRef;"ID"))
				APPEND TO ARRAY:C911(aACT_ApdosDDFechaDoc;OT GetDate ($otRef;"Fecha"))
				APPEND TO ARRAY:C911(aACT_ApdosDDNumeroDoc;OT GetText ($otRef;"Serie"))
				APPEND TO ARRAY:C911(aACT_ApdosDDMontoDoc;OT GetReal ($otRef;"Monto"))
				APPEND TO ARRAY:C911(aACT_ApdosDDBancoDoc;OT GetText ($otRef;"Banco"))
				APPEND TO ARRAY:C911(aACT_ApdosDDTipoDcto;OT GetText ($otRef;"TipoDocumento"))
				APPEND TO ARRAY:C911($ab_depositado;OT_GetBoolean ($otRef;"Depositado"))
				OT Clear ($otRef)
				NEXT RECORD:C51([xxACT_ArchivosHistoricos:113])
			End for 
			AT_RedimArrays (Size of array:C274(aACT_ApdosDDID);->aACT_ApdosDDFechaDoc;->aACT_ApdosDDNumeroDoc;->aACT_ApdosDDMontoDoc;->aACT_ApdosDDBancoDoc;->aACT_ApdosDDTipoDcto;->$ab_depositado)
		End if 
		$ab_depositado{0}:=False:C215
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->$ab_depositado;"=";->$DA_Return)
		For ($i;Size of array:C274($DA_Return);1;-1)
			AT_Delete ($DA_Return{$i};1;->aACT_ApdosDDID;->aACT_ApdosDDFechaDoc;->aACT_ApdosDDNumeroDoc;->aACT_ApdosDDMontoDoc;->aACT_ApdosDDBancoDoc;->aACT_ApdosDDTipoDcto;->$ab_depositado)
		End for 
End case 