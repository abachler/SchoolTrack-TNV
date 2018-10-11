If (Form event:C388=On Data Change:K2:15)  //MONO TICKET 210959
	If (Self:C308->>999)
		Self:C308->:=999
	End if 
End if 