C_LONGINT:C283(tempTimeout)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		tempTimeout:=Self:C308->
	: (Form event:C388=On Data Change:K2:15)
		If ((Self:C308->>0) & (Self:C308-><16))
			PREF_Set (0;"TimeoutSTWA";String:C10(Self:C308->*60))
			STWA2_ManejaTiempoDeSesion ("cambioTimeOutGeneral")
			<>vlSTWA2_Timeout:=Self:C308->*60
			VARIABLE TO VARIABLE:C635(-1;<>vlSTWA2_Timeout;<>vlSTWA2_Timeout)
		Else 
			CD_Dlog (0;__ ("Por motivos de seguridad el valor debe estar entre 1 y 15 minutos."))
			Self:C308->:=tempTimeout
		End if 
End case 