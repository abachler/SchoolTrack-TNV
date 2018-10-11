Case of 
	: (Form event:C388=On Data Change:K2:15)
		[xxSTR_JustificacionAtrasos:227]valido:4:=True:C214
		SAVE RECORD:C53([xxSTR_JustificacionAtrasos:227])
		KRL_ReloadAsReadOnly (->[xxSTR_JustificacionAtrasos:227])
End case 
