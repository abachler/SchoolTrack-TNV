//%attributes = {}
  //BWR_OnDeleteRecord

C_LONGINT:C283($deleted;$0)
$deleted:=dhBWR_OnDeleteRecord 

If ($deleted=-1)
	DELETE RECORD:C58(yBWR_currentTable->)
	LOG_RegisterEvt ("Eliminación de un registro de la tabla "+API Get Virtual Table Name (Table:C252(yBWR_currentTable));Table:C252(yBWR_currentTable))
End if 

dhBWR_ActualizaSetLocal   //20170801 RCH Workaround problema con set local

$0:=$deleted