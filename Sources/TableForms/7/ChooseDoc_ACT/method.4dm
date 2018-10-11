Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALSet_ACT_DispDocs 
		AL_SetLine (xALP_DispDocs;1)
		vlACT_DocID:=alACT_DocsAfectosIDs{1}
	: (Form event:C388=On Close Box:K2:21)
		ACCEPT:C269
End case 
