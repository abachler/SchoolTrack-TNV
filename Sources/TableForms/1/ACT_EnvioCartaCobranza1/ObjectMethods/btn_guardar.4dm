If ((cs_ACTecc_EnvioAutomaticoOrg=0) & (cs_ACTecc_EnvioAutomatico=1))
	CD_Dlog (0;__ ("Para programar un envío automático debe presionar el botón ")+ST_Qte ("Programar")+".")
Else 
	ACTecc_OpcionesGenerales ("GuardaBlob")
	CANCEL:C270
End if 
