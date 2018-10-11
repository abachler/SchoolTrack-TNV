//%attributes = {}
  //ACTbol_BuscaCargosCargaSet

C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($vb_readOnlyState)
C_LONGINT:C283($vl_idBoleta)
C_TEXT:C284($vt_set)

$vt_set:=$1
$vl_idBoleta:=$2

$vb_readOnlyState:=Read only state:C362([ACT_Boletas:181])

READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

If ($vl_idBoleta#0)
	  //transacciones de la boleta
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$vl_idBoleta)
	CREATE SET:C116([ACT_Transacciones:178];$vt_set)
	
	  // transacciones de boletas asociadas
	If ([ACT_Boletas:181]ID:1#$vl_idBoleta)
		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idBoleta)
	End if 
	
	CREATE SET:C116([ACT_Boletas:181];"setBoletasOrg")
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$vl_idBoleta;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
	QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=-4)  //20171115 RCH Solo se considera la NC
	
	CREATE SET:C116([ACT_Boletas:181];"setBoletasTodasConNC")
	UNION:C120("setBoletasOrg";"setBoletasTodasConNC";"setBoletasTodasConNC")
	
	  //filtro que sean solo documentos que afecten los montos.
	QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214;*)
	QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]codigo_referencia:31=2)  //corrige textos
	CREATE SET:C116([ACT_Boletas:181];"setBoletasAQuitarNCT2")
	
	DIFFERENCE:C122("setBoletasTodasConNC";"setBoletasAQuitarNCT2";"setBoletasTodasConNC")
	SET_UseSet ("setBoletasTodasConNC")
	SET_ClearSets ("setBoletasTodasConNC";"setBoletasAQuitarNCT2";"setBoletasOrg")
	KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
	CREATE SET:C116([ACT_Transacciones:178];"Transacciones2")
	
	  // uno para quedarme con todas las transacciones
	UNION:C120($vt_set;"Transacciones2";$vt_set)
	
	  //20140422 RCH Cuando las NC estaban asociadas a cargos con monto 0, no aparecian bien. busco las transacciones asociadas a descuentos...
	READ ONLY:C145([ACT_Transacciones:178])
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_DctoRelacionado:15;->[ACT_Boletas:181]ID:1;"")
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Debito:6=0;*)
	QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Credito:7=0)
	CREATE SET:C116([ACT_Transacciones:178];"Transacciones2")
	UNION:C120($vt_set;"Transacciones2";$vt_set)
	
	USE SET:C118($vt_set)
	
	  // busco los cargos de las transacciones asociadas
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	
	  // filtro que los cargos no sean cargos de descuento nc
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-127;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-128;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129)
	
	If (Num:C11(PREF_fGet (0;"ACT_ORDENACARGOS_DTE";"1"))=1)
		ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]ID:1;>)
	End if 
	
	SET_ClearSets ("Transacciones2")
	
	  // recargo registro en el modo que estaba
	KRL_ResetPreviousRWMode (->[ACT_Boletas:181];$vb_readOnlyState)
	KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idBoleta)
End if 