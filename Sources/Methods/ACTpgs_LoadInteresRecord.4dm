//%attributes = {}
  //ACTpgs_LoadInteresRecord

$readOnlyState:=Read only state:C362([xxACT_Items:179])
READ ONLY:C145([xxACT_Items:179])
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-100)
If (Records in selection:C76([xxACT_Items:179])=0)
	ACTinit_CreateInteresRecord 
End if 
If (Not:C34($readOnlyState))
	READ WRITE:C146([xxACT_Items:179])
End if 