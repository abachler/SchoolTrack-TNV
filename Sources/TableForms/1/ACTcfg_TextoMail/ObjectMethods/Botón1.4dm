$resp:=CD_Dlog (0;__ ("Desea cargar el texto por defecto. Si existen cambios se perderán.\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
If ($resp=1)
	ACTcfg_OpcionesTextoMail ("InitVars")
End if 