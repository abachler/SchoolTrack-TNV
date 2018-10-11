ARRAY TEXT:C222($at_rutaImagen;0)
C_PICTURE:C286($p_imagen)
C_TEXT:C284($t_especificaciones)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_principal")
		STWA2_ManejaImagenResponsive ("CargaImagen")
		STWA2_ManejaImagenResponsive ("CargaEspecificacionesFoto";$y_imagen)
End case 
