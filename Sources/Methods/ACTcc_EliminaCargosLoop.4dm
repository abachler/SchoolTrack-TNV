//%attributes = {}
  //ACTcc_EliminaCargosLoop
C_BOOLEAN:C305($b_ErrorAlEliminar)

If (False:C215)
	  //Elimina una seleccion de cargos eliminando y recalculando lo que sea necesario. La seleccion debe ser generada antes de llamar este metodo
End if 

ARRAY LONGINT:C221($aRNCargos;0)
ARRAY LONGINT:C221($al_recNumDCargo;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNCargos;"")
For ($j;1;Size of array:C274($aRNCargos))
	  //READ WRITE([ACT_Cargos])
	  //GOTO RECORD([ACT_Cargos];$aRNCargos{$j})
	$l_recnum:=$aRNCargos{$j}
	If (KRL_GotoRecord (->[ACT_Cargos:173];$l_recnum;True:C214))  //20161012 AS-RCH Cuando se elimina el cargo relacionado se puede eliminar un cargo del for
		
		
		If (ACTcar_EsCargoEliminable ([ACT_Cargos:173]ID:1))  //201704256 RCH
			
			ARRAY LONGINT:C221($alACT_recNumAC;0)
			$b_ErrorAlEliminar:=ACTcar_EliminaCargosRelacionado ([ACT_Cargos:173]ID:1;->$alACT_recNumAC;[ACT_Cargos:173]ID_Documento_de_Cargo:3;True:C214)
			If (Not:C34($b_ErrorAlEliminar))
				
				KRL_GotoRecord (->[ACT_Cargos:173];$l_recnum;True:C214)  //20170615 RCH
				
				$idDocCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
				READ WRITE:C146([ACT_Transacciones:178])
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
				If (Not:C34(Locked:C147([ACT_Transacciones:178])))
					DELETE RECORD:C58([ACT_Transacciones:178])
				Else 
					BM_CreateRequest ("ACT_BorrarTransaccion";String:C10([ACT_Transacciones:178]ID_Transaccion:1))
				End if 
				KRL_UnloadReadOnly (->[ACT_Transacciones:178])
				READ WRITE:C146([xxACT_DesctosXItem:103])
				QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
				If (Not:C34(Locked:C147([xxACT_DesctosXItem:103])))
					DELETE RECORD:C58([xxACT_DesctosXItem:103])
				Else 
					BM_CreateRequest ("ACT_BorrarDescto";String:C10([xxACT_DesctosXItem:103]ID:1))
				End if 
				KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])
				
				  // Modificado por: Saùl Ponce (27-09-2016) Ticket Nº 168397, para eliminar los cargos relacionados
				  //ARRAY LONGINT($alACT_recNumAC;0)
				  //ACTcar_EliminaCargosRelacionado ([ACT_Cargos]ID;->$alACT_recNumAC;[ACT_Cargos]ID_Documento_de_Cargo;True)
				
				  // Modificado por: Saúl Ponce (22-03-2017) Ticket 177887, ya no se usará el id del documento de cargo, se determina dentro del método
				ARRAY LONGINT:C221($alACT_recNumAC;0)
				ACTcar_EliminaCargosRelacionado ([ACT_Cargos:173]ID:1;->$alACT_recNumAC)
				
				  //20161011 RCH Se perdia cargo de seleccion
				If (KRL_GotoRecord (->[ACT_Cargos:173];$l_recnum;True:C214))
					DELETE RECORD:C58([ACT_Cargos:173])
				Else 
					BM_CreateRequest ("ACT_BorrarCargo";String:C10([ACT_Cargos:173]ID:1))
				End if 
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
				READ WRITE:C146([ACT_Documentos_de_Cargo:174])
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$idDocCargo)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
				If (Records in selection:C76([ACT_Cargos:173])=0)
					If (Not:C34(Locked:C147([ACT_Documentos_de_Cargo:174])))
						DELETE RECORD:C58([ACT_Documentos_de_Cargo:174])
					Else 
						BM_CreateRequest ("ACT_BorrarDocdeCargo";String:C10([ACT_Documentos_de_Cargo:174]ID_Documento:1))
					End if 
				Else 
					If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=1)
						If (Find in array:C230($al_recNumDCargo;Record number:C243([ACT_Documentos_de_Cargo:174]))=-1)
							APPEND TO ARRAY:C911($al_recNumDCargo;Record number:C243([ACT_Documentos_de_Cargo:174]))
						End if 
					End if 
				End if 
				KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
			End if 
		End if 
		
	End if 
End for 
For ($i;1;Size of array:C274($al_recNumDCargo))
	REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
	KRL_GotoRecord (->[ACT_Documentos_de_Cargo:174];$al_recNumDCargo{$i};True:C214)
	If (ok=1)
		ACTcc_CalculaDocumentoCargo ($al_recNumDCargo{$i})
	End if 
End for 