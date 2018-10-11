Case of 
	: (Form event:C388=On Load:K2:1)
		If (vMUmess=__ ("Esperando que el registro sea liberado..."))
			SET TIMER:C645(10)
			OBJECT SET VISIBLE:C603(bWait;False:C215)
			OBJECT SET TITLE:C194(bCancel;__ ("Abortar"))
		End if 
	: (Form event:C388=On Timer:K2:25)
		LOAD RECORD:C52(MUloadFile->)
		If (Not:C34(Locked:C147(MUloadFile->)))
			ACCEPT:C269
		End if 
End case 
