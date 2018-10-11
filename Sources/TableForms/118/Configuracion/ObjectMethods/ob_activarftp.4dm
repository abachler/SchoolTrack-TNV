Case of 
	: (Form event:C388=On Clicked:K2:4)
		  // Declaraciones 
		C_POINTER:C301($y_activarftp;$y_activarnombre)
		C_BOOLEAN:C305($b_editar)
		
		  // Punteros a controles de formulario
		$y_activarftp:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_activarftp")
		
		  // Control de edicion 
		If ($y_activarftp->=1)
			$b_editar:=True:C214
		Else 
			$b_editar:=False:C215
		End if 
		OBJECT SET ENABLED:C1123(*;"ob_host";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_puerto";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_usuario";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_password";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_mostrarpwd";$b_editar)
		OBJECT SET ENABLED:C1123(*;"conexionpasiva_ob";$b_editar)
		OBJECT SET ENABLED:C1123(*;"conexionactiva_ob";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_rutaexterna";$b_editar)
End case 
