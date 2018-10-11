C_LONGINT:C283(vlADT_YearDeleteArchives)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		bArchive:=1
		bDeleteRejected:=0
		cbDeleteArchive:=1
		vlADT_YearDeleteArchives:=Year of:C25(Current date:C33(*))-2
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
