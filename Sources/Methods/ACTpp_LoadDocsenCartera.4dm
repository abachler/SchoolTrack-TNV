//%attributes = {}
  //ACTpp_LoadDocsenCartera

$tipoDocumento:=$1

ARRAY LONGINT:C221(aACT_ApdosDCarID;0)
ARRAY LONGINT:C221(aACT_ApdosDCarIDDocPago;0)
ARRAY DATE:C224(aACT_ApdosDCarFechaDoc;0)
ARRAY TEXT:C222(aACT_ApdosDCarNumeroDoc;0)
ARRAY REAL:C219(aACT_ApdosDCarMontoDoc;0)
ARRAY TEXT:C222(aACT_ApdosDCarUbicacionDoc;0)
ARRAY TEXT:C222(aACT_ApdosDCarEstado;0)
ARRAY DATE:C224(aACT_ApdosDCarFechaVenc;0)
ARRAY DATE:C224(aACT_ApdosDCarProtestadoel;0)
ARRAY DATE:C224(aACT_ApdosDCarDepDesde;0)
ARRAY DATE:C224(aACT_ApdosDCarDepHasta;0)
ARRAY TEXT:C222(aACT_ApdosDCarTipoDoc;0)
ARRAY TEXT:C222(aACT_ApdosDCarBancoDoc;0)
ARRAY LONGINT:C221(aACT_ApdosDCarRecNum;0)

Case of 
	: (Count parameters:C259=1)
		$tipoDocumento:=$1
		$vt_queryOver:="personas"
	: (Count parameters:C259=2)
		$tipoDocumento:=$1
		$vt_queryOver:=$2
	Else 
		$tipoDocumento:=1
		$vt_queryOver:="personas"
End case 

Case of 
		
	: ($tipoDocumento=1)  //solo cheques
		  //QUERY([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID_Apoderado=[Personas]No;*)
		Case of 
			: ($vt_queryOver="terceros")
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Tercero:18=[ACT_Terceros:138]Id:1;*)
			: ($vt_queryOver="personas")
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=[Personas:7]No:1;*)
			Else 
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=[Personas:7]No:1;*)
		End case 
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4)
		ORDER BY:C49([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Fecha_Doc:5;>)
		AL_SetColOpts (xALP_DocsenCartera;1;0;1;4;0;0)
	: ($tipoDocumento=2)  //solo letras
		  //QUERY([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID_Apoderado=[Personas]No;*)
		Case of 
			: ($vt_queryOver="terceros")
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Tercero:18=[ACT_Terceros:138]Id:1;*)
			: ($vt_queryOver="personas")
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=[Personas:7]No:1;*)
			Else 
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=[Personas:7]No:1;*)
		End case 
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-8)
		ORDER BY:C49([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Fecha_Doc:5;>)
		AL_SetColOpts (xALP_DocsenCartera;1;0;1;3;0;0)
End case 
ORDER BY:C49([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Fecha_Doc:5;<)
SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182];aACT_ApdosDCarRecNum;[ACT_Documentos_en_Cartera:182]ID:1;aACT_ApdosDCarID;[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;aACT_ApdosDCarIDDocPago;[ACT_Documentos_en_Cartera:182]Fecha_Doc:5;aACT_ApdosDCarFechaDoc;[ACT_Documentos_en_Cartera:182]Numero_Doc:6;aACT_ApdosDCarNumeroDoc;[ACT_Documentos_en_Cartera:182]Monto_Doc:7;aACT_ApdosDCarMontoDoc;[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8;aACT_ApdosDCarUbicacionDoc)
SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]Estado:9;aACT_ApdosDCarEstado;[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10;aACT_ApdosDCarFechaVenc;[ACT_Documentos_en_Cartera:182]Ch_Protestadoel:11;aACT_ApdosDCarProtestadoel;[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12;aACT_ApdosDCarDepDesde;[ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13;aACT_ApdosDCarDepHasta)
SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]Tipo_Doc:4;aACT_ApdosDCarTipoDoc;[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7;aACT_ApdosDCarBancoDoc)