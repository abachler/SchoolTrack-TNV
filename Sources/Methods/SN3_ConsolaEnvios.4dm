//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 10-03-17, 13:01:28
  // ----------------------------------------------------
  // Método: SN3_ConsolaEnvios
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_BOOLEAN:C305($b_isServidor)
C_TEXT:C284($t_accion)
C_TEXT:C284($1)

$t_accion:=$1
$b_isServidor:=(Application type:C494=4D Server:K5:6)
If (Not:C34($b_isServidor))
	Case of 
		: ($t_accion="OpenForm")
			WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"Console";0;Palette form window:K39:9;__ ("Transferencia de datos a SchoolNet"))
			FORM SET INPUT:C55([SN3_PublicationPrefs:161];"Console")
			DISPLAY RECORD:C105([SN3_PublicationPrefs:161])
		: ($t_accion="display")
			DISPLAY RECORD:C105([SN3_PublicationPrefs:161])
		: ($t_accion="closeWindows")
			CLOSE WINDOW:C154
	End case 
End if 

