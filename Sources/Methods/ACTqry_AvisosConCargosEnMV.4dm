//%attributes = {}
  //ACTqry_AvisosConCargosEnMV
SRACT_SelFecha (7)
If (ok=1)
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Transacciones:178])
	If (cb_Archivo=1)
		CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alBWR_recordNumber)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=vd_fecha1;*)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=vd_fecha2)
	Else 
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=vd_fecha1;*)
		QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=vd_fecha2)
	End if 
	KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";"))
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1)
	KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10)
	  //CREATE SET(yBWR_currentTable->;"RecordSet_Table"+String(Table(yBWR_currentTable)))
	  //BWR_SelectTableData 
End if 
