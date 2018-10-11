  //20120322 RCH Se encuentran problemas al eliminar cargos proyectados para terceros. Se modifica codigo
$item:=Selected list items:C379(hlTab_ACT_Transacciones)
$RNCta:=Record number:C243([ACT_Terceros:138])
$vb_actualizaArea:=False:C215
Case of 
	: ($item=3)
		  //elimina cargos proyectados
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		$line:=AL_GetLine (xALP_Transacciones)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=alACT_ItemIDs{$line})
		LOG_RegisterEvt ("Eliminación de cargo proyectado para Tercero: "+[ACT_Terceros:138]Nombre_Completo:9+". Glosa cargo: "+[ACT_Cargos:173]Glosa:12+", ID: "+String:C10([ACT_Cargos:173]ID:1)+".")
		ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos:173]ID_Apoderado:18)
		ACTcc_EliminaCargosLoop 
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
		$vb_actualizaArea:=True:C214
		
	: ($item=2)
		$line:=AL_GetLine (xALP_Transacciones)
		$vl_idCargo:=alACT_ItemIDs{$line}
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
		$vl_retorno:=ACTcar_Delete (Record number:C243([ACT_Cargos:173]))
		If ($vl_retorno=0)
			$vb_actualizaArea:=True:C214
		End if 
End case 

If ($vb_actualizaArea)
	KRL_GotoRecord (->[ACT_Terceros:138];$RNCta;True:C214)
	AL_UpdateArrays (xALP_Transacciones;0)
	ACTter_LoadTransacciones ($item)
	AL_UpdateArrays (xALP_Transacciones;-2)
	AL_SetLine (xALP_Transacciones;0)
End if 