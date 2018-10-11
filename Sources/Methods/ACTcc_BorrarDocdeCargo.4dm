//%attributes = {}
  //ACTcc_BorrarDocdeCargo
  //20111116 RCH Se agrega else para que recalcule el documento de cargo si es que no se elimina

$idDocdeCargo:=Num:C11($1)
$0:=True:C214
READ ONLY:C145([ACT_Cargos:173])
KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$idDocdeCargo;True:C214)
If (ok=1)
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
	If (Records in selection:C76([ACT_Cargos:173])=0)
		DELETE RECORD:C58([ACT_Documentos_de_Cargo:174])
	Else 
		$vl_id:=ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
	End if 
Else 
	If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)  //20180411 RCH Ticket 204028
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])