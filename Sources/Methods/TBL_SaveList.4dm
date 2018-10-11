//%attributes = {}
  //TBL_SaveList

C_TEXT:C284(theText)
theText:=""
If (changed=True:C214)
	READ WRITE:C146([xShell_List:39])
	BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;->sElements)
	SAVE RECORD:C53([xShell_List:39])
	UNLOAD RECORD:C212([xShell_List:39])
	READ ONLY:C145([xShell_List:39])
End if 
UNLOAD RECORD:C212([xShell_List:39])
READ ONLY:C145([xShell_List:39])
  //TBL_LoadListsArrays 
  //20140107 ASM Ticket  128514
KRL_ExecuteEverywhere ("TBL_LoadListsArrays")