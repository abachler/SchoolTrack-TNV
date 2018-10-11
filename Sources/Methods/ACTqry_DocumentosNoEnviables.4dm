//%attributes = {}
  //ACTqry_DocumentosNoEnviables

SRACT_SelFecha (4)
If (ok=1)
	ARRAY LONGINT:C221($alACT_idsPersonas;0)
	ARRAY LONGINT:C221($alACT_idsTerceros;0)
	
	READ ONLY:C145([ACT_Boletas:181])
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_Terceros:138])
	
	  //se buscan los documentos electrónicos que no serían enviados por mail
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=vd_fecha1;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=vd_fecha2;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
	
	If (Records in selection:C76([ACT_Boletas:181])>0)
		
		CREATE SET:C116([ACT_Boletas:181];"boletasPeriodo")
		
		KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Boletas:181]ID:1;"")
		QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_DTE_Enviar_Mail:110=False:C215)
		SELECTION TO ARRAY:C260([Personas:7]No:1;$alACT_idsPersonas)
		
		KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;"")
		QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]DTE_enviar_por_mail:74=False:C215)
		SELECTION TO ARRAY:C260([ACT_Terceros:138]Id:1;$alACT_idsTerceros)
		
		USE SET:C118("boletasPeriodo")
		QUERY SELECTION WITH ARRAY:C1050([ACT_Boletas:181]ID_Apoderado:14;$alACT_idsPersonas)
		CREATE SET:C116([ACT_Boletas:181];"setApdos")
		
		DIFFERENCE:C122("boletasPeriodo";"setApdos";"boletasPeriodo")
		
		USE SET:C118("boletasPeriodo")
		QUERY SELECTION WITH ARRAY:C1050([ACT_Boletas:181]ID_Tercero:21;$alACT_idsTerceros)
		CREATE SET:C116([ACT_Boletas:181];"setTerceros")
		
		UNION:C120("setApdos";"setTerceros";"boletas")
		USE SET:C118("boletas")
		If (Records in selection:C76([ACT_Boletas:181])=0)
			CD_Dlog (0;"No hay Documentos Tributarios Electrónicos no nulos para apoderados ni terceros que no tengan marcada la opción de enviar dtes por email.")
		End if 
		SET_ClearSets ("setApdos";"setTerceros";"boletasPeriodo";"boletas")
	Else 
		CD_Dlog (0;"No hay Documentos Tributarios Electrónicos no nulos para el período seleccionado.")
	End if 
End if 