C_BOOLEAN:C305($vb_todo)
If (vi_todo=1)
	$vb_todo:=True:C214
End if 
AT_Populate (->ab_transferir;->$vb_todo)