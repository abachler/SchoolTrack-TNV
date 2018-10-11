//%attributes = {}
  //ACTqry_PagosSinDocsTribsAsoc

SRACT_SelFecha (7)
If (ok=1)
	READ ONLY:C145([ACT_Pagos:172])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Boletas:181])
	
	If (cb_Archivo=1)
		C_TEXT:C284($set)
		CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];alBWR_recordNumber)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_fecha1;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=vd_fecha2;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
	Else 
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_fecha1;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=vd_fecha2;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
	End if 
	
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;__ ("Buscando transacciones..."))
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;__ ("Buscando cargos..."))
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]No_Incluir_en_DocTrib:50=False:C215)
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;__ ("Buscando transacciones..."))
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;__ ("Buscando pagos..."))
	CREATE SET:C116([ACT_Pagos:172];"setPagos1")
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;__ ("Buscando transacciones..."))
	KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;__ ("Buscando documentos tributarios..."))
	KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;__ ("Buscando transacciones..."))
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;__ ("Buscando pagos..."))
	CREATE SET:C116([ACT_Pagos:172];"setPagos2")
	DIFFERENCE:C122("setPagos1";"setPagos2";"setPagos1")
	USE SET:C118("setPagos1")
	SET_ClearSets ("setPagos1";"setPagos2")
End if 