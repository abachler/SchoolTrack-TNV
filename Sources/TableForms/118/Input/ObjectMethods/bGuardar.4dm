If (KRL_RegistroFueModificado (->[xxACT_ArchivosBancarios:118]))
	$nombreError:=Not:C34([xxACT_ArchivosBancarios:118]Nombre:3#"")
	$tipoError:=Not:C34([xxACT_ArchivosBancarios:118]Tipo:6#"")
	$msg:=""
	$msgC:="Debe dar un nombre al archivo."
	$msgD:="Debe definir el tipo de archivo."
	Case of 
		: (($nombreError) & ($tipoError))
			$msg:=$msgC+"\r"+$msgD
		: ($nombreError)
			$msg:=$msgC
		: ($tipoError)
			$msg:=$msgD
	End case 
	If ($msg#"")
		CD_Dlog (0;$msg)
	Else 
		ACCEPT:C269
	End if 
Else 
	CANCEL:C270
End if 