If (Selected record number:C246(Current form table:C627->)<0)
	vNumReg:=""
Else 
	vNumReg:=String:C10(Selected record number:C246(Current form table:C627->))+" de "+String:C10(Records in selection:C76(Current form table:C627->))
End if 