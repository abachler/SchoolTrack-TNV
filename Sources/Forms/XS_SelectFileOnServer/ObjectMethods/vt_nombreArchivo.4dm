  // XS_SelectFileOnServer.vt_nombreArchivo()
  // Por: Alberto Bachler K.: 10-11-14, 07:08:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Mouse Leave:K2:34))
		OBJECT SET ENABLED:C1123(*;"botonGuardar";vt_NombreArchivo#"")
		
	: (Form event:C388=On After Keystroke:K2:26)
		$t_NombreArchivo:=Get edited text:C655
		OBJECT SET ENABLED:C1123(*;"botonGuardar";$t_NombreArchivo#"")
		
	Else 
		
End case 