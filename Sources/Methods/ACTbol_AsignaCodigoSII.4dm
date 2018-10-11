//%attributes = {}
  //ACTbol_AsignaCodigoSII
If ([ACT_Boletas:181]codigo_SII:33="")
	Case of 
			  // Modificado por: Saúl Ponce (23/12/2017) Ticket Nº 196102, para que [ACT_Boletas]codigo_SII se asigne correctamente al tratarse de AR.
			  // ([ACT_Boletas]documento_electronico)
		: (([ACT_Boletas:181]documento_electronico:29) | (<>GCOUNTRYCODE="ar"))
			Case of 
				: (<>GCOUNTRYCODE="ar")  //20150626 RCH
					C_TEXT:C284(<>tACT_FEAR_BOLETA_E;<>tACT_FEAR_FACTURA_E;<>tACT_FEAR_NC_E;<>tACT_FEAR_ND_E)
					C_TEXT:C284(<>tACT_FEAR_BOLETA_A;<>tACT_FEAR_FACTURA_A;<>tACT_FEAR_NC_A;<>tACT_FEAR_ND_A)
					If ((<>tACT_FEAR_BOLETA_E="") | (<>tACT_FEAR_FACTURA_E="") | (<>tACT_FEAR_NC_E="") | (<>tACT_FEAR_ND_E="") | (<>tACT_FEAR_BOLETA_A="") | (<>tACT_FEAR_FACTURA_A="") | (<>tACT_FEAR_NC_A="") | (<>tACT_FEAR_ND_A=""))
						ACTinit_LoadPrefs 
					End if 
					If ([ACT_Boletas:181]TasaIVA:16=0)
						Case of 
							: (([ACT_Boletas:181]ID_Categoria:12=-1) | ([ACT_Boletas:181]ID_Categoria:12>0))  //boleta
								[ACT_Boletas:181]codigo_SII:33:=<>tACT_FEAR_BOLETA_E
							: ([ACT_Boletas:181]ID_Categoria:12=-3)  //factura
								[ACT_Boletas:181]codigo_SII:33:=<>tACT_FEAR_FACTURA_E
							: ([ACT_Boletas:181]ID_Categoria:12=-4)  // nota de crédito
								[ACT_Boletas:181]codigo_SII:33:=<>tACT_FEAR_NC_E
							: ([ACT_Boletas:181]ID_Categoria:12=-5)  // nota de débito
								[ACT_Boletas:181]codigo_SII:33:=<>tACT_FEAR_ND_E
						End case 
					Else 
						Case of 
							: (([ACT_Boletas:181]ID_Categoria:12=-1) | ([ACT_Boletas:181]ID_Categoria:12>0))  //boleta
								[ACT_Boletas:181]codigo_SII:33:=<>tACT_FEAR_BOLETA_A
							: ([ACT_Boletas:181]ID_Categoria:12=-3)  //factura
								[ACT_Boletas:181]codigo_SII:33:=<>tACT_FEAR_FACTURA_A
							: ([ACT_Boletas:181]ID_Categoria:12=-4)  // nota de crédito
								[ACT_Boletas:181]codigo_SII:33:=<>tACT_FEAR_NC_A
							: ([ACT_Boletas:181]ID_Categoria:12=-5)  // nota de débito
								[ACT_Boletas:181]codigo_SII:33:=<>tACT_FEAR_ND_A
						End case 
					End if 
					
				Else 
					If ([ACT_Boletas:181]TasaIVA:16=0)
						Case of 
							: (([ACT_Boletas:181]ID_Categoria:12=-1) | ([ACT_Boletas:181]ID_Categoria:12>0))
								[ACT_Boletas:181]codigo_SII:33:="41"
							: ([ACT_Boletas:181]ID_Categoria:12=-3)
								[ACT_Boletas:181]codigo_SII:33:="34"
							: ([ACT_Boletas:181]ID_Categoria:12=-4)
								[ACT_Boletas:181]codigo_SII:33:="61"
							: ([ACT_Boletas:181]ID_Categoria:12=-5)
								[ACT_Boletas:181]codigo_SII:33:="56"
						End case 
					Else 
						Case of 
							: (([ACT_Boletas:181]ID_Categoria:12=-1) | ([ACT_Boletas:181]ID_Categoria:12>0))
								[ACT_Boletas:181]codigo_SII:33:="39"
							: ([ACT_Boletas:181]ID_Categoria:12=-3)
								[ACT_Boletas:181]codigo_SII:33:="33"
							: ([ACT_Boletas:181]ID_Categoria:12=-4)
								[ACT_Boletas:181]codigo_SII:33:="61"
							: ([ACT_Boletas:181]ID_Categoria:12=-5)
								[ACT_Boletas:181]codigo_SII:33:="56"
						End case 
					End if 
					
			End case 
		Else 
			If ([ACT_Boletas:181]TasaIVA:16=0)
				Case of 
					: (([ACT_Boletas:181]ID_Categoria:12=-1) | ([ACT_Boletas:181]ID_Categoria:12>0))
						[ACT_Boletas:181]codigo_SII:33:="38"
					: ([ACT_Boletas:181]ID_Categoria:12=-3)
						[ACT_Boletas:181]codigo_SII:33:="32"
					: ([ACT_Boletas:181]ID_Categoria:12=-4)
						[ACT_Boletas:181]codigo_SII:33:="60"
					: ([ACT_Boletas:181]ID_Categoria:12=-5)
						[ACT_Boletas:181]codigo_SII:33:="55"
				End case 
			Else 
				Case of 
					: (([ACT_Boletas:181]ID_Categoria:12=-1) | ([ACT_Boletas:181]ID_Categoria:12>0))
						[ACT_Boletas:181]codigo_SII:33:="35"
					: ([ACT_Boletas:181]ID_Categoria:12=-3)
						[ACT_Boletas:181]codigo_SII:33:="30"
					: ([ACT_Boletas:181]ID_Categoria:12=-4)
						[ACT_Boletas:181]codigo_SII:33:="60"
					: ([ACT_Boletas:181]ID_Categoria:12=-5)
						[ACT_Boletas:181]codigo_SII:33:="55"
				End case 
			End if 
	End case 
End if 

If ([ACT_Boletas:181]TasaIVA:16=0)
	[ACT_Boletas:181]Monto_Exento:30:=[ACT_Boletas:181]Monto_Total:6
End if 