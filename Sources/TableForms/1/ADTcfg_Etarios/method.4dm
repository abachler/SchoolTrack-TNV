Case of 
	: (Form event:C388=On Load:K2:1)
		VMaximoPostulantesEnterable:=0
		OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)
		OBJECT SET VISIBLE:C603(*;"padlockUnLocked";False:C215)
		OBJECT SET ENTERABLE:C238(iPST_MaxCandidates;False:C215)
		
		XS_SetConfigInterface 
		PST_ReadParameters 
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
