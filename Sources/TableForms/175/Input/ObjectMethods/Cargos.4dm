$item:=Selected list items:C379(hlTab_ACT_Transacciones)
$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
Case of 
	: ($item=3)
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		READ WRITE:C146([ACT_Cargos:173])
		READ WRITE:C146([ACT_Transacciones:178])
		READ WRITE:C146([ACT_Documentos_de_Cargo:174])
		READ WRITE:C146([xxACT_DesctosXItem:103])
		$line:=AL_GetLine (xALP_Transacciones)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aACT_ItemIDs{$line})
		QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
		DELETE RECORD:C58([xxACT_DesctosXItem:103])
		ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos:173]ID_Apoderado:18)
		If (Not:C34(Locked:C147([ACT_Cargos:173])))
			LOG_RegisterEvt ("Eliminación de cargo proyectado "+[ACT_Cargos:173]Glosa:12+" para "+[Alumnos:2]apellidos_y_nombres:40+".")
			$DocdeCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
			DELETE RECORD:C58([ACT_Cargos:173])
		Else 
			BM_CreateRequest ("ACT_BorrarCargo";String:C10([ACT_Cargos:173]ID:1))
		End if 
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=aACT_ItemIDs{$line})
		If (Not:C34(Locked:C147([ACT_Transacciones:178])))
			DELETE RECORD:C58([ACT_Transacciones:178])
		Else 
			BM_CreateRequest ("ACT_BorrarTransaccion";String:C10([ACT_Transacciones:178]ID_Transaccion:1))
		End if 
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$DocdeCargo)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
		If (Records in selection:C76([ACT_Cargos:173])>0)
			If (Records in selection:C76([ACT_Documentos_de_Cargo:174])>0)
				$RecNumDC:=Record number:C243([ACT_Documentos_de_Cargo:174])
				ACTcc_CalculaDocumentoCargo ($RecNumDC)
			End if 
		Else 
			If (Not:C34(Locked:C147([ACT_Documentos_de_Cargo:174])))
				DELETE RECORD:C58([ACT_Documentos_de_Cargo:174])
			Else 
				BM_CreateRequest ("ACT_BorrarDocdeCargo";String:C10([ACT_Documentos_de_Cargo:174]ID_Documento:1))
			End if 
		End if 
		
		  // Modificado por: Saùl Ponce (27-09-2016) Ticket Nº 168397, para eliminar los cargos relacionados
		  //ARRAY LONGINT($alACT_recNumAC;0)
		  //ACTcar_EliminaCargosRelacionado (aACT_ItemIDs{$line};->$alACT_recNumAC;$DocdeCargo;True)
		
		  // Modificado por: Saúl Ponce (22-03-2017) Ticket 177887, ya no se usará el id del documento de cargo, se determina dentro del método
		ARRAY LONGINT:C221($alACT_recNumAC;0)
		ACTcar_EliminaCargosRelacionado (aACT_ItemIDs{$line};->$alACT_recNumAC)
		
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
		KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
		KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$RNCta;True:C214)
		[ACT_CuentasCorrientes:175]ID:1:=[ACT_CuentasCorrientes:175]ID:1  //to force modified record
		AL_UpdateArrays (xALP_Transacciones;0)
		ACTcc_LoadTransacciones 
		AL_UpdateArrays (xALP_Transacciones;-2)
		AL_SetLine (xALP_Transacciones;0)
	: ($item=2)
		$line:=AL_GetLine (xALP_Transacciones)
		$idCta:=[ACT_CuentasCorrientes:175]ID:1
		$vl_idCargo:=aACT_ItemIDs{$line}
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
		$vl_retorno:=ACTcar_Delete (Record number:C243([ACT_Cargos:173]))
		KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$RNCta;True:C214)
		If ($vl_retorno=0)
			$ref:=Selected list items:C379(hlTab_ACT_Transacciones)
			AL_UpdateArrays (xALP_Transacciones;0)
			ACTcc_LoadTransacciones ($ref)
			AL_UpdateArrays (xALP_Transacciones;-2)
			AL_SetLine (xALP_Transacciones;0)
		End if 
End case 