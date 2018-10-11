Case of 
	: (Form event:C388=On Clicked:K2:4)
		$vt_tipo:=ST_GetWord (at_tipoDocumento{at_tipoDocumento};1;":")
		If (($vt_tipo="61") | ($vt_tipo="56"))
			_O_ENABLE BUTTON:C192(*;"referencia@")
		Else 
			_O_DISABLE BUTTON:C193(*;"referencia@")
			vt_referencia:=""
		End if 
End case 