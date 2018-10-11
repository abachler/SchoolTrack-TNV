
If (Form event:C388=On Load:K2:1)
	ARRAY TEXT:C222(<>aListValues;0)
	BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;-><>aListValues)
	QUERY:C277([xShell_List_FieldRefs:236];[xShell_List_FieldRefs:236]ListName:4=[xShell_List:39]Listname:1)
	
End if 
