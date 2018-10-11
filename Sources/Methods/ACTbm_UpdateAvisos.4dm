//%attributes = {}
  //ACTbm_UpdateAvisos

C_LONGINT:C283($vl_idApdo;$vl_idTercero)

ARRAY LONGINT:C221($al_recNumsAvisos;0)
ARRAY LONGINT:C221($al_idsApoderados;0)
ARRAY LONGINT:C221($al_idsTerceros;0)
ARRAY LONGINT:C221($al_difference;0)

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])

  //busco los cargos en moneda variable, con saldo y emitidos para recalcularlos
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";");*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!)
If (Records in selection:C76([ACT_Cargos:173])>0)
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
	KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumsAvisos)
	AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_Apoderado:18;->$al_idsApoderados)
	AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_Tercero:54;->$al_idsTerceros)
	
	For ($i;1;Size of array:C274($al_idsApoderados))
		$vl_idApdo:=$al_idsApoderados{$i}
		$vl_idTercero:=0
		ACTeod_EjecutaTareas ("AgregaElemento";->$vl_idApdo;->$vl_idTercero)
	End for 
	For ($i;1;Size of array:C274($al_idsTerceros))
		$vl_idApdo:=0
		$vl_idTercero:=$al_idsTerceros{$i}
		ACTeod_EjecutaTareas ("AgregaElemento";->$vl_idApdo;->$vl_idTercero)
	End for 
	
	ACTmnu_RecalcularSaldosAvisos (->$al_recNumsAvisos;Current date:C33(*);False:C215;False:C215;True:C214)
End if 
