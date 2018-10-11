//%attributes = {}
  //IN_LoadDefaultPreferences


$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Preferencias.txt"
SET CHANNEL:C77(10;$file)
If (ok=1)
	$Process:=IT_UThermometer (1;0;__ ("Cargando el archivo de preferencias por defecto…"))
	READ WRITE:C146([xShell_Prefs:46])
	RECEIVE VARIABLE:C81(nbRecords)
	For ($k;1;nbrecords)
		RECEIVE RECORD:C79([xShell_Prefs:46])
		  //sf_CLR SUBFILE (->[Niveles]AñosAnteriores)
		SAVE RECORD:C53([xShell_Prefs:46])
	End for 
	SET CHANNEL:C77(11)
	READ ONLY:C145([xShell_Prefs:46])
	IT_UThermometer (-2;$Process)
Else 
	$r:=CD_Dlog (1;__ ("El archivo que contiene las preferencias por defecto no pudo ser cargado."))
End if 