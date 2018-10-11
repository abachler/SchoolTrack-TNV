
Case of 
	: (Form event:C388=On Clicked:K2:4)
		  // Declaraciones 
		C_POINTER:C301($y_activarnombre)
		C_BOOLEAN:C305($b_editar)
		  // Punteros a controles de formulario
		$y_activarnombre:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_activarnombre")
		  // Control de edicion 
		If ($y_activarnombre->=1)
			$b_editar:=True:C214
		Else 
			$b_editar:=False:C215
		End if 
		OBJECT SET ENABLED:C1123(*;"ob_prefijo";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_sufijo";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_extensiones";$b_editar)
		
End case 
