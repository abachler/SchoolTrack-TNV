Case of 
	: ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Data Change:K2:15))
		Self:C308->:=ST_ClearExtraCR (Self:C308->)
End case 