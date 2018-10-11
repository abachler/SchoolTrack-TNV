Case of 
	: (Form event:C388=On Load:K2:1)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		If ([xxSTR_Horarios:40]Hasta:3<=[xxSTR_Horarios:40]Desde:2)
			BEEP:C151
			[xxSTR_Horarios:40]Hasta:3:=[xxSTR_Horarios:40]Desde:2+(45*60)
		End if 
	: (Form event:C388=On Unload:K2:2)
End case 