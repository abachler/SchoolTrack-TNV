[ADT_Contactos:95]RUT:11:=CTRY_CL_VerifRUT ([ADT_Contactos:95]RUT:11)
If ([ADT_Contactos:95]RUT:11#"")
	If (KRL_RecordExists (->[ADT_Contactos:95]RUT:11))
		CD_Dlog (0;__ ("Ya existe un contacto con este RUT."))
		[ADT_Contactos:95]RUT:11:=""
		GOTO OBJECT:C206([ADT_Contactos:95]RUT:11)
	End if 
Else 
	GOTO OBJECT:C206([ADT_Contactos:95]RUT:11)
End if 
ADTcon_SetIdentificadorPrincipa 