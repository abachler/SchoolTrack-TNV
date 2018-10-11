Case of 
	: (Form event:C388=On Load:K2:1)
		  //pagina 1
		ARRAY DATE:C224(adACT_FechaHR;0)
		ARRAY TEXT:C222(atACT_EstadoHR;0)
		ARRAY REAL:C219(arACT_MontoHR;0)
		ARRAY TEXT:C222(atACT_FormaHR;0)
		ARRAY TEXT:C222(atACT_BancoHR;0)
		ARRAY TEXT:C222(atACT_SerieHR;0)
		
		  //pagina 2
		ARRAY TEXT:C222(atACT_BancoHRazo;0)
		ARRAY TEXT:C222(atACT_SerieHRazo;0)
		ARRAY TEXT:C222(atACT_FormaHRazo;0)
		ARRAY DATE:C224(adACT_FechaHRazo;0)
		ARRAY REAL:C219(arACT_MontoHRazo;0)
		ARRAY TEXT:C222(atACT_EstadoHRazo;0)
		
		ARRAY TEXT:C222(atACT_BancoHRado;0)
		ARRAY TEXT:C222(atACT_SerieHRado;0)
		ARRAY TEXT:C222(atACT_FormaHRado;0)
		ARRAY DATE:C224(adACT_FechaHRado;0)
		ARRAY REAL:C219(arACT_MontoHRado;0)
		ARRAY TEXT:C222(atACT_EstadoHRado;0)
		
		C_LONGINT:C283($vl_idDcto)
		C_BOOLEAN:C305(vbACT_buscaReemplazadores)
		
		C_LONGINT:C283(vl_reemplazado;vl_reemplazo)
		
		$vl_idDcto:=[ACT_Documentos_de_Pago:176]ID:1
		$vl_idDctoRela:=[ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55
		vl_reemplazado:=[ACT_Documentos_de_Pago:176]id_reemplazado:62
		vl_reemplazo:=[ACT_Documentos_de_Pago:176]id_reemplazador:63
		
		If ((vl_reemplazado=0) & (vl_reemplazo=0))
			CREATE EMPTY SET:C140([ACT_Documentos_de_Pago:176];"setDctoPago")
			READ ONLY:C145([ACT_Documentos_de_Pago:176])
			If (vbACT_buscaReemplazadores)
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55=$vl_idDcto)
				CREATE SET:C116([ACT_Documentos_de_Pago:176];"setDctoPago")
			Else 
				CREATE EMPTY SET:C140([ACT_Documentos_de_Pago:176];"setDctoPago")
				While ($vl_idDctoRela#0)
					QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=$vl_idDctoRela)
					$vl_idDctoRela:=[ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55
					If (Records in selection:C76([ACT_Documentos_de_Pago:176])>0)
						ADD TO SET:C119([ACT_Documentos_de_Pago:176];"setDctoPago")
					End if 
				End while 
			End if 
			
			USE SET:C118("setDctoPago")
			SET_ClearSets ("setDctoPago")
			ORDER BY:C49([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13;<)
			SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]Fecha:13;adACT_FechaHR;[ACT_Documentos_de_Pago:176]Estado:14;atACT_EstadoHR;[ACT_Documentos_de_Pago:176]MontoPago:6;arACT_MontoHR;[ACT_Documentos_de_Pago:176]Tipodocumento:5;atACT_FormaHR)
			SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]Ch_BancoNombre:7;atACT_BancoHR;[ACT_Documentos_de_Pago:176]NoSerie:12;atACT_SerieHR)
			
			FORM GOTO PAGE:C247(1)
		Else 
			  //pagina 2
			If (vl_reemplazo#0)
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_reemplazado:62=vl_reemplazo)
				ORDER BY:C49([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13;<)
				SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]Fecha:13;adACT_FechaHRazo;[ACT_Documentos_de_Pago:176]Estado:14;atACT_EstadoHRazo;[ACT_Documentos_de_Pago:176]MontoPago:6;arACT_MontoHRazo;[ACT_Documentos_de_Pago:176]Tipodocumento:5;atACT_FormaHRazo)
				SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]Ch_BancoNombre:7;atACT_BancoHRazo;[ACT_Documentos_de_Pago:176]NoSerie:12;atACT_SerieHRazo)
			End if 
			
			If (vl_reemplazado#0)
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_reemplazador:63=vl_reemplazado)
				ORDER BY:C49([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13;<)
				SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]Fecha:13;adACT_FechaHRado;[ACT_Documentos_de_Pago:176]Estado:14;atACT_EstadoHRado;[ACT_Documentos_de_Pago:176]MontoPago:6;arACT_MontoHRado;[ACT_Documentos_de_Pago:176]Tipodocumento:5;atACT_FormaHRado)
				SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176]Ch_BancoNombre:7;atACT_BancoHRado;[ACT_Documentos_de_Pago:176]NoSerie:12;atACT_SerieHRado)
			End if 
			
			FORM GOTO PAGE:C247(2)
		End if 
		vbACT_buscaReemplazadores:=False:C215
		
		  //ASM 20140320 Para cargar las formas de pagos de los reemplazos de documentos (imprimir)
		ACTdc_CargaArregloFDP ("CargaArreglos")
		If (Records in selection:C76([ACT_Documentos_de_Pago:176])>0)
			LOAD RECORD:C52([ACT_Documentos_de_Pago:176])
			vlACT_ReempPor:=Find in array:C230(alACT_IDFormasdePago;[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
		Else 
			vlACT_ReempPor:=-1
		End if 
		
	: (Form event:C388=On Unload:K2:2)
		ARRAY DATE:C224(adACT_FechaHR;0)
		ARRAY TEXT:C222(atACT_EstadoHR;0)
		ARRAY REAL:C219(arACT_MontoHR;0)
		ARRAY TEXT:C222(atACT_FormaHR;0)
		ARRAY TEXT:C222(atACT_BancoHR;0)
		ARRAY TEXT:C222(atACT_SerieHR;0)
		
		  //pagina 2
		ARRAY TEXT:C222(atACT_BancoHRazo;0)
		ARRAY TEXT:C222(atACT_SerieHRazo;0)
		ARRAY TEXT:C222(atACT_FormaHRazo;0)
		ARRAY DATE:C224(adACT_FechaHRazo;0)
		ARRAY REAL:C219(arACT_MontoHRazo;0)
		ARRAY TEXT:C222(atACT_EstadoHRazo;0)
		
		ARRAY TEXT:C222(atACT_BancoHRado;0)
		ARRAY TEXT:C222(atACT_SerieHRado;0)
		ARRAY TEXT:C222(atACT_FormaHRado;0)
		ARRAY DATE:C224(adACT_FechaHRado;0)
		ARRAY REAL:C219(arACT_MontoHRado;0)
		ARRAY TEXT:C222(atACT_EstadoHRado;0)
End case 