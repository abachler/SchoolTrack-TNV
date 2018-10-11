//%attributes = {}
  //ACTdc_ImprimirReemplazos
C_LONGINT:C283($vl_idReemp)
If (Count parameters:C259>=1)
	$vl_idReemp:=$1
End if 
If ($vl_idReemp#0)
	READ ONLY:C145([ACT_ReemplazosDC:292])
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_Terceros:138])
	READ ONLY:C145([ACT_Documentos_en_Cartera:182])
	READ ONLY:C145([ACT_Documentos_de_Pago:176])
	
	QUERY:C277([ACT_ReemplazosDC:292];[ACT_ReemplazosDC:292]id:1=$vl_idReemp)
	QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_ReemplazosDC:292]id_apoderado:2)
	QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_ReemplazosDC:292]id_tercero:3)
	
	vlACTreemp_Modo:=[ACT_ReemplazosDC:292]id_modoReemplazo:6
End if 
  //If (vlACT_ReempPor<=8) `20100518 RCH Ticket 86330. No se por que estaba esta restriccion
$r:=CD_Dlog (0;__ ("¿Desea imprimir un comprobante de este reemplazo?");__ ("");__ ("Si");__ ("No"))
If ($r=1)
	If (vlACTreemp_Modo=1)
		  //QUERY([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID=[ACT_ReemplazosDC]id_doc_cartera)
		  //KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago]ID;->[ACT_Documentos_en_Cartera]ID_DocdePago)
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_reemplazado:62=[ACT_ReemplazosDC:292]id:1)
		KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1)
		FORM SET OUTPUT:C54([ACT_Documentos_en_Cartera:182];"ComprobanteReemplazo")
	Else 
		
		If ($vl_idReemp>0)
			ARRAY LONGINT:C221(alACT_idPago;0)
			ARRAY TEXT:C222(atACT_Apdo;0)
			ARRAY TEXT:C222(atACT_TipoDoc;0)
			ARRAY REAL:C219(arACT_Monto;0)
			ARRAY TEXT:C222(atACT_Dato;0)
			ARRAY LONGINT:C221($al_IDFP;0)
			ARRAY LONGINT:C221($alACT_IdApdo;0)
			ARRAY LONGINT:C221($alACT_Id;0)
			
			  //documentos reemplazadores 
			QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_reemplazador:63=$vl_idReemp)
			  //ORDER BY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]ID;>)
			ORDER BY:C49([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Tipodocumento:5;>;[ACT_Documentos_de_Pago:176]Fecha:13;>;[ACT_Documentos_de_Pago:176]NoSerie:12;>;[ACT_Documentos_de_Pago:176]ID:1;>)
			SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]id_forma_de_pago:51;$al_IDFP;[ACT_Documentos_de_Pago:176]MontoPago:6;arACT_Monto;\
				[ACT_Documentos_de_Pago:176]Tipodocumento:5;atACT_TipoDoc;[ACT_Documentos_de_Pago:176]ID_Apoderado:2;$alACT_IdApdo;\
				[ACT_Documentos_de_Pago:176]ID:1;$alACT_Id)
			
			For ($i;1;Size of array:C274($alACT_Id))
				APPEND TO ARRAY:C911(alACT_idPago;KRL_GetNumericFieldData (->[ACT_Pagos:172]ID_DocumentodePago:6;->$alACT_Id{$i};->[ACT_Pagos:172]ID:1))
				APPEND TO ARRAY:C911(atACT_Apdo;KRL_GetTextFieldData (->[Personas:7]No:1;->$alACT_IdApdo{$i};->[Personas:7]Apellidos_y_nombres:30))
				Case of 
					: ($al_IDFP{$i}=-4)
						APPEND TO ARRAY:C911(atACT_Dato;KRL_GetTextFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->$alACT_Id{$i};->[ACT_Documentos_de_Pago:176]NoSerie:12))
					: ($al_IDFP{$i}=-6)
						APPEND TO ARRAY:C911(atACT_Dato;KRL_GetTextFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->$alACT_Id{$i};->[ACT_Documentos_de_Pago:176]TC_NoDocumento:25))
					: ($al_IDFP{$i}=-7)
						APPEND TO ARRAY:C911(atACT_Dato;KRL_GetTextFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->$alACT_Id{$i};->[ACT_Documentos_de_Pago:176]R_NoDocumento:33))
					: ($al_IDFP{$i}=-8)
						APPEND TO ARRAY:C911(atACT_Dato;KRL_GetTextFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->$alACT_Id{$i};->[ACT_Documentos_de_Pago:176]NoSerie:12))
					Else 
						APPEND TO ARRAY:C911(atACT_Dato;"")
				End case 
			End for 
			
			QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_reemplazado:62=$vl_idReemp)
			KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
			
			ORDER BY:C49([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Tipo_Doc:4;>;[ACT_Documentos_en_Cartera:182]Fecha_Doc:5;>;[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10;>;[ACT_Documentos_en_Cartera:182]Numero_Doc:6;>;[ACT_Documentos_en_Cartera:182]ID:1;>)
			
			FIRST RECORD:C50([ACT_Documentos_en_Cartera:182])
			
			  //vars del informe
			C_TEXT:C284(vtACT_FirmaReemp)
			C_TEXT:C284(vtACT_ApoderadoReemp;vtACT_INApdoReemp)
			
			vtACT_FirmaReemp:="p.p. "+<>gCustom
			vtACT_ApoderadoReemp:=Choose:C955(([ACT_ReemplazosDC:292]id_apoderado:2#0);[Personas:7]Apellidos_y_nombres:30;[ACT_Terceros:138]Nombre_Completo:9)
			vtACT_INApdoReemp:=Choose:C955(([ACT_ReemplazosDC:292]id_apoderado:2#0);[Personas:7]RUT:6;[ACT_Terceros:138]RUT:4)
			
			ARRAY TEXT:C222($atACT_TipoDoc;0)
			COPY ARRAY:C226(atACT_TipoDoc;$atACT_TipoDoc)
			AT_DistinctsArrayValues (->$atACT_TipoDoc)
			vsACT_DocsReemp:=AT_array2text (->$atACT_TipoDoc;" - ")
			
			FORM SET OUTPUT:C54([ACT_Documentos_en_Cartera:182];"ComprobanteReemplazo2")
		Else 
			ok:=0
		End if 
	End if 
	PRINT SETTINGS:C106
	If (ok=1)
		PRINT RECORD:C71([ACT_Documentos_en_Cartera:182];>)
	End if 
End if 
  //End if