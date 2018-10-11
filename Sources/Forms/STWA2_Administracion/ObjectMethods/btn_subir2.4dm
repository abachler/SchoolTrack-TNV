Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_PICTURE:C286($p_imagen)
		$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_principal")
		$p_imagen:=$y_imagen->
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaImagen:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"Vista_Previa"+SYS_FolderDelimiterOnServer 
		$t_rutaimagen:=$t_rutaimagen+"screen-default-stwa.jpg"
		PICTURE TO BLOB:C692($p_imagen;$x_blob;".jpg")
		KRL_SendFileToServer ($t_rutaimagen;$x_blob;True:C214)
		
		$l_refVentana:=Open form window:C675("STWA_WebArea";Plain form window:K39:10+_o_Compositing mode form window:K39:13;Horizontally centered:K39:1;Vertically centered:K39:4;*)
		DIALOG:C40("STWA_WebArea")
		CLOSE WINDOW:C154
		
End case 
