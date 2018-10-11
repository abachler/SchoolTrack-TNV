$docRef:=Open document:C264("";"";Get pathname:K24:6)
If (document#"")
	AT_Insert (0;1;->atEM4D_Attachments_paths)
	AT_Insert (0;1;->atEM4D_Attachments)
	atEM4D_Attachments_paths{Size of array:C274(atEM4D_Attachments_paths)}:=document
	atEM4D_Attachments{Size of array:C274(atEM4D_Attachments)}:=SYS_Path2FileName (document)
End if 