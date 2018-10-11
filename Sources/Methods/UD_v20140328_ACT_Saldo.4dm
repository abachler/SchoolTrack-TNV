//%attributes = {}
  //UD_v20140328_ACT_Saldo

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($l_indice;$l_proc)
	C_BOOLEAN:C305($b_mostrarThermo)
	
	READ ONLY:C145([ACT_Pagos:172])
	
	$l_proc:=IT_UThermometer (1;0;"Verificando saldos...")
	
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]FechaIngreso:24>=DT_GetDateFromDayMonthYear (1;7;13))
	QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30;=-4;*)
	QUERY SELECTION:C341([ACT_Pagos:172]; | ;[ACT_Pagos:172]id_forma_de_pago:30=-8)
	
	DISTINCT VALUES:C339([ACT_Pagos:172]ID_Apoderado:3;aQR_Longint1)
	DISTINCT VALUES:C339([ACT_Pagos:172]ID_Tercero:26;aQR_Longint2)
	ACTcc_OpcionesCalculoCtaCte ("InitArrays")
	For ($l_indice;1;Size of array:C274(aQR_Longint1))
		If (Find in array:C230(alACTpp_idsPersonas;aQR_Longint1{$l_indice})=-1) & (aQR_Longint1{$l_indice}#0)
			APPEND TO ARRAY:C911(alACTpp_idsPersonas;aQR_Longint1{$l_indice})
		End if 
	End for 
	For ($l_indice;1;Size of array:C274(aQR_Longint2))
		If (Find in array:C230(alACTter_idsTerceros;aQR_Longint2{$l_indice})=-1) & (aQR_Longint2{$l_indice}#0)
			APPEND TO ARRAY:C911(alACTter_idsTerceros;aQR_Longint2{$l_indice})
		End if 
	End for 
	$b_mostrarThermo:=True:C214
	ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$b_mostrarThermo)
	
	IT_UThermometer (-2;$l_proc)
	
End if 
