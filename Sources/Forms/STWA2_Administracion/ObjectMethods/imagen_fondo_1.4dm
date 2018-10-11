Case of 
	: (Form event:C388=On Clicked:K2:4)
		$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_principal")
		$y_imagen->:=Self:C308->
		STWA2_ManejaImagenResponsive ("CargaEspecificacionesFoto";$y_imagen)
End case 