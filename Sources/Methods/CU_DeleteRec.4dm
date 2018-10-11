//%attributes = {}
  // CU_DeleteRec 
  // 20110518 RCH Este metodo se llama desde CU_Delete y CU_DeleteSelection
C_BOOLEAN:C305($vb_deleteSelection;$1)
C_LONGINT:C283($0)

$vb_deleteSelection:=$1
If ($vb_deleteSelection)
	KRL_DeleteSelection (->[Cursos:3])
Else 
	DELETE RECORD:C58([Cursos:3])
End if 
CU_LoadArrays 
KRL_ExecuteOnConnectedClients ("CU_LoadArrays")
$0:=1