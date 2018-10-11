Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If ([xShell_Documents:91]RefType:10="URL")
			FORM GOTO PAGE:C247(2)
			If (([xShell_Documents:91]RefType:10="URL") & ([xShell_Documents:91]URL:11=""))
				[xShell_Documents:91]URL:11:="http://"
			End if 
			HIGHLIGHT TEXT:C210([xShell_Documents:91]URL:11;Length:C16([xShell_Documents:91]URL:11)+1;Length:C16([xShell_Documents:91]URL:11)+1)
		End if 
End case 
