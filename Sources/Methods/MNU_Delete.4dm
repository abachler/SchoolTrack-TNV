//%attributes = {}

  //MNU_Delete

If (vb_RecordInInputForm)
	bBWR_Delete:=1
	BWR_DispatchButtonActions 
Else 
	MNU_DeleteSelection 
End if 