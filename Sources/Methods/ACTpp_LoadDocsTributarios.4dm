//%attributes = {}
  //ACTpp_LoadDocsTributarios

ACTpp_FormArraysDeclarations ("ArreglosBoletas")
C_TEXT:C284($vt_yearHist;$vt_tipo;$vt_queryOver)
C_LONGINT:C283($vl_id)
C_POINTER:C301($Ptr)

$vt_queryOver:="personas"
$vt_tipo:="doctrib"
$vl_id:=[Personas:7]No:1
If (Count parameters:C259>=1)
	$vt_yearHist:=$1
	If (Count parameters:C259=2)
		$Ptr:=$2
		RESOLVE POINTER:C394($Ptr;$var;$tbl;$field)
		If (Table:C252(Table:C252($tbl))=(Table:C252(->[ACT_Terceros:138])))
			$vt_queryOver:="terceros"
			$vt_tipo:="doctribTer"
			$vl_id:=[ACT_Terceros:138]Id:1
		End if 
	End if 
End if 

$year:=Num:C11(ST_GetWord ($vt_yearHist;1;"-"))
$month:=Num:C11(ST_GetWord ($vt_yearHist;2;"-"))

Case of 
	: ($year=0)
		READ ONLY:C145([ACT_Boletas:181])
		  //QUERY([ACT_Boletas];[ACT_Boletas]ID_Apoderado=[Personas]No)
		Case of 
			: ($vt_queryOver="terceros")
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Tercero:21=[ACT_Terceros:138]Id:1)
			: ($vt_queryOver="personas")
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Apoderado:14=[Personas:7]No:1)
			Else 
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Apoderado:14=[Personas:7]No:1)
		End case 
		ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3;<)
		SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;alACT_ApdosDTID;[ACT_Boletas:181]Numero:11;alACT_ApdosDTNumero;[ACT_Boletas:181]TipoDocumento:7;atACT_ApdosDTTipo;[ACT_Boletas:181]Estado:2;atACT_ApdosDTEstado;[ACT_Boletas:181]FechaEmision:3;adACT_ApdosDTFecha;[ACT_Boletas:181]Monto_Afecto:4;arACT_ApdosDTMontoAfecto;[ACT_Boletas:181]Monto_IVA:5;arACT_ApdosDTMontoIVA;[ACT_Boletas:181]Monto_Total:6;arACT_ApdosDTMontoTotal;[ACT_Boletas:181]Nula:15;abACT_ApdosDTNula)
	Else 
		READ ONLY:C145([xxACT_Datos_de_Cierre:116])
		QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$year;*)
		QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$month)
		If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
			READ ONLY:C145([xxACT_ArchivosHistoricos:113])
			  //$key:=String([xxACT_Datos_de_Cierre]Year;"0000")+"."+String([xxACT_Datos_de_Cierre]Month;"00")+"."+"doctrib"+"."+String([Personas]No)+".@"
			$key:=String:C10([xxACT_Datos_de_Cierre:116]Year:1;"0000")+"."+String:C10([xxACT_Datos_de_Cierre:116]Month:3;"00")+"."+$vt_tipo+"."+String:C10($vl_id)+".@"
			QUERY:C277([xxACT_ArchivosHistoricos:113];[xxACT_ArchivosHistoricos:113]Referencia:8=$key)
			For ($x;1;Records in selection:C76([xxACT_ArchivosHistoricos:113]))
				BLOB_ExpandBlob_byPointer (->[xxACT_ArchivosHistoricos:113]xData:3)
				$blob:=[xxACT_ArchivosHistoricos:113]xData:3
				$otRef:=OT BLOBToObject ($blob)
				APPEND TO ARRAY:C911(alACT_ApdosDTID;OT GetLong ($otRef;"ID"))
				APPEND TO ARRAY:C911(alACT_ApdosDTNumero;OT GetLong ($otRef;"Numero"))
				APPEND TO ARRAY:C911(atACT_ApdosDTTipo;OT GetText ($otRef;"TipoDoc"))
				APPEND TO ARRAY:C911(atACT_ApdosDTEstado;OT GetText ($otRef;"Estado"))
				APPEND TO ARRAY:C911(adACT_ApdosDTFecha;OT GetDate ($otRef;"Fecha"))
				APPEND TO ARRAY:C911(arACT_ApdosDTMontoAfecto;OT GetReal ($otRef;"Afecto"))
				APPEND TO ARRAY:C911(arACT_ApdosDTMontoIVA;OT GetReal ($otRef;"IVA"))
				APPEND TO ARRAY:C911(arACT_ApdosDTMontoTotal;OT GetReal ($otRef;"Total"))
				APPEND TO ARRAY:C911(abACT_ApdosDTNula;(OT GetLong ($otRef;"Nula")=1))
				OT Clear ($otRef)
				NEXT RECORD:C51([xxACT_ArchivosHistoricos:113])
			End for 
			AT_RedimArrays (Size of array:C274(alACT_ApdosDTID);->alACT_ApdosDTNumero;->atACT_ApdosDTTipo;->atACT_ApdosDTEstado;->adACT_ApdosDTFecha;->arACT_ApdosDTMontoAfecto;->arACT_ApdosDTMontoIVA;->arACT_ApdosDTMontoTotal;->abACT_ApdosDTNula)
		End if 
End case 