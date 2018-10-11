Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (vlACTp_Cuota<0)
			vlACTp_Cuota:=1
		End if 
		
	: (Form event:C388=On Getting Focus:K2:7)
		OBJECT SET VISIBLE:C603(*;"vt_agregado2";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado2";False:C215)
		
End case 