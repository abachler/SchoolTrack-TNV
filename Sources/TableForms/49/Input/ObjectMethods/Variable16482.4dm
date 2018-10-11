$line:=AL_GetLine (xALP_Connexions)
If ($line>0)
	vb_ConnectionsModified:=True:C214
	DELETE FROM ARRAY:C228(at_Connexions;$line)
	If (at_auto_uuid{$line}#"")
		APPEND TO ARRAY:C911(at_auto_uuid_a_eliminar;at_auto_uuid{$line})  //MONO CONEXIONES
	End if 
	AL_UpdateArrays (xALP_Connexions;-2)
	AL_SetLine (xALP_Connexions;0)
	_O_DISABLE BUTTON:C193(bDelConnexion)
End if 