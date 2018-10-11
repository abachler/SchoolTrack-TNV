//%attributes = {}



  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 13/10/16, 17:10:47
  // ----------------------------------------------------
  // Método: UD_v20161013_VerificaDocCargo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_LONGINT:C283($j;$idDocCargo;$i;$l_recnum;$l_proc)

ARRAY LONGINT:C221($al_RecNumCargos;0)
ARRAY LONGINT:C221($al_RecNumDocumento;0)
ARRAY LONGINT:C221($al_IdDocCargo;0)

$l_proc:=IT_UThermometer (1;0;"Verificando los cargos para el año: "+String:C10(<>gyear)+"...")

READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])

QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20>=DT_GetDateFromDayMonthYear (1;1;<>gyear);*)
QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15#0)

CREATE SET:C116([ACT_Documentos_de_Cargo:174];"setDoc1")
KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
CREATE SET:C116([ACT_Documentos_de_Cargo:174];"setDoc2")

DIFFERENCE:C122("setDoc1";"setDoc2";"setDoc1")

READ WRITE:C146([ACT_Documentos_de_Cargo:174])
USE SET:C118("setDoc1")

SET_ClearSets ("setDoc1";"setDoc2")

KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_RecNumCargos;"")
For ($j;1;Size of array:C274($al_RecNumCargos))
	
	$l_recnum:=$al_RecNumCargos{$j}
	If (KRL_GotoRecord (->[ACT_Cargos:173];$l_recnum;True:C214))  //20161012 AS-RCH Cuando se elimina el cargo relacionado se puede eliminar un cargo del for
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
		
		  // Modificado por: Sa˘l Ponce (27-09-2016) Ticket N∫ 168397, para eliminar los cargos relacionados
		  //ARRAY LONGINT($al_IdDocCargo;0)
		  //ACTcar_EliminaCargosRelacionado ([ACT_Cargos]ID;->$al_IdDocCargo;[ACT_Cargos]ID_Documento_de_Cargo;True)
		
		  // Modificado por: Saúl Ponce (22-03-2017) Ticket 177887, ya no se usará el id del documento de cargo, se determina dentro del método
		ARRAY LONGINT:C221($al_IdDocCargo;0)
		ACTcar_EliminaCargosRelacionado ([ACT_Cargos:173]ID:1;->$al_IdDocCargo)
		
		  //20161011 RCH Se perdia cargo de seleccion
		READ WRITE:C146([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$al_RecNumCargos{$j})
		
		If (Not:C34(Locked:C147([ACT_Cargos:173])))
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
				If (Find in array:C230($al_RecNumDocumento;Record number:C243([ACT_Documentos_de_Cargo:174]))=-1)
					APPEND TO ARRAY:C911($al_RecNumDocumento;Record number:C243([ACT_Documentos_de_Cargo:174]))
				End if 
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
	End if 
End for 
For ($i;1;Size of array:C274($al_RecNumDocumento))
	REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
	KRL_GotoRecord (->[ACT_Documentos_de_Cargo:174];$al_RecNumDocumento{$i};True:C214)
	If (ok=1)
		ACTcc_CalculaDocumentoCargo ($al_RecNumDocumento{$i})
	End if 
End for 

IT_UThermometer (-2;$l_proc)