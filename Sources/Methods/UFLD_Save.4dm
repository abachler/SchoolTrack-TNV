//%attributes = {}
  //UFLD_Save

If (([xShell_Userfields:76]UserFieldName:1#"") & ([xShell_Userfields:76]FileNo:6#0))
	BLOB_Variables2Blob (->[xShell_Userfields:76]xListOfValues:9;0;-><>aUFValues)
	If (Size of array:C274(<>aUFvalues)>0)
		[xShell_Userfields:76]ListOfValues:4:=True:C214
	Else 
		[xShell_Userfields:76]ListOfValues:4:=False:C215
	End if 
	ACCEPT:C269
Else 
	BEEP:C151
End if 