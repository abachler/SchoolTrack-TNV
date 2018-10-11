Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALSet_STR_AsistenteCursos 
		If (vb_FirstInstall)
			OBJECT SET VISIBLE:C603(*;"FirstInstall@";True:C214)
			OBJECT SET VISIBLE:C603(*;"finish@";False:C215)
			OBJECT SET TITLE:C194(bTerminar;__ ("Terminar ahora"))
		Else 
			OBJECT SET VISIBLE:C603(*;"FirstInstall@";False:C215)
			OBJECT SET VISIBLE:C603(*;"finish@";True:C214)
			OBJECT SET TITLE:C194(bTerminar;__ ("Terminar"))
		End if 
		POST KEY:C465(Character code:C91("+");256)
		
	: (Form event:C388=On Clicked:K2:4)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
