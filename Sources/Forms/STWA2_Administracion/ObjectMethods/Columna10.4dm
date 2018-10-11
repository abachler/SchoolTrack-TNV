
Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (alSTWA2_minutos{Self:C308->}>0)
			STWA2_ManejaTiempoDeSesion ("SetTimeOut")
		Else 
			CD_Dlog (0;__ ("Por motivos de seguridad el valor debe ser superior a cero."))
			alSTWA2_minutos{Self:C308->}:=alSTWA2_minutos{0}
		End if 
End case 