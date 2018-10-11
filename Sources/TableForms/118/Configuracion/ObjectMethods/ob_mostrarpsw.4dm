  // Declaracion
C_POINTER:C301($y_activarftp)
$y_activarftp:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_activarftp")
  //  Se realiza validacion global de eventos para controlar el mostrar la contraseña solo cuando esta activo la opcion FTP
If ($y_activarftp->=1)
	Case of 
		: (Form event:C388=On Clicked:K2:4)  // Se muestra la contraseña
			OBJECT SET FONT:C164(*;"ob_password";"Tahoma")
		: (Form event:C388=On Mouse Enter:K2:33)  // Hover, tambien se muestra la contraseña
			OBJECT SET FONT:C164(*;"ob_password";"Tahoma")
		: (Form event:C388=On Mouse Leave:K2:34)  // Cuando el Hover termina se oculta la contraseña
			OBJECT SET FONT:C164(*;"ob_password";"%password")
	End case 
End if 
