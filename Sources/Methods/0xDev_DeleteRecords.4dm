//%attributes = {}
  //0xDev_DeleteRecords

$n:=0xdev_SelectTable 
If (($n#0) & (ok=1))
	CONFIRM:C162("Eliminar "+String:C10(Records in selection:C76(Table:C252($n)->))+" registros del archivo "+Table name:C256(Table:C252($n))+" ?")
	If (Ok=1)
		READ WRITE:C146(Table:C252($n)->)
		DELETE SELECTION:C66(Table:C252($n)->)
		READ ONLY:C145(Table:C252($n)->)
	End if 
End if 