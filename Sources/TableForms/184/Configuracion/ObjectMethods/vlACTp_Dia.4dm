Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (vlACTp_Dia<0)
			vlACTp_Dia:=1
		Else 
			If (vlACTp_Dia>31)
				vlACTp_Dia:=31
			End if 
		End if 
		
	: (Form event:C388=On Getting Focus:K2:7)
		OBJECT SET VISIBLE:C603(*;"vt_agregado1";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado1";False:C215)
		
End case 