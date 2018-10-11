//%attributes = {}
  //UD_v20140516_ACT_BoletasIVA

If (ACT_AccountTrackInicializado )
	ACTcfg_LoadConfigData (8)
	ACTcfg_LoadConfigData (6)
	READ ONLY:C145([ACT_Boletas:181])
	C_LONGINT:C283($l_indice;$l_proc)
	C_TEXT:C284($t_numerosBoleta)
	ARRAY LONGINT:C221($alACT_indicesAfectos;0)
	ARRAY LONGINT:C221($alACT_idsAfectos;0)
	ARRAY LONGINT:C221($alACT_recNumsBoletas;0)
	$l_proc:=IT_UThermometer (1;0;"Verificando iva en D.T...")
	abACT_Afecta{0}:=True:C214
	AT_SearchArray (->abACT_Afecta;"=";->$alACT_indicesAfectos)
	For ($l_indice;1;Size of array:C274($alACT_indicesAfectos))
		APPEND TO ARRAY:C911($alACT_idsAfectos;alACT_IDDT{$alACT_indicesAfectos{$l_indice}})
	End for 
	QUERY WITH ARRAY:C644([ACT_Boletas:181]ID_Documento:13;$alACT_idsAfectos)
	QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=!2014-05-05!;*)
	QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Monto_IVA:5=0;*)
	QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]TasaIVA:16=0;*)
	QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$alACT_recNumsBoletas;"")
	For ($l_indice;1;Size of array:C274($alACT_recNumsBoletas))
		READ WRITE:C146([ACT_Boletas:181])
		GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNumsBoletas{$l_indice})
		[ACT_Boletas:181]Monto_Afecto:4:=Round:C94([ACT_Boletas:181]Monto_Total:6/<>vrACT_FactorIVA;<>vlACT_Decimales)
		[ACT_Boletas:181]Monto_IVA:5:=[ACT_Boletas:181]Monto_Total:6-[ACT_Boletas:181]Monto_Afecto:4
		[ACT_Boletas:181]TasaIVA:16:=<>vrACT_TasaIVA
		SAVE RECORD:C53([ACT_Boletas:181])
		$t_numerosBoleta:=Choose:C955($t_numerosBoleta="";"";$t_numerosBoleta+", ")+[ACT_Boletas:181]TipoDocumento:7+" "+String:C10([ACT_Boletas:181]Numero:11)
		KRL_UnloadReadOnly (->[ACT_Boletas:181])
	End for 
	LOG_RegisterEvt ("Validación de montos IVA realizada para los números de documento: "+$t_numerosBoleta+".")
	IT_UThermometer (-2;$l_proc)
End if 