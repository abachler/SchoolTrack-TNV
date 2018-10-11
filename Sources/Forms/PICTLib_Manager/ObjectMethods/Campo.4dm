  // PictureManager.Campo()
  //
  //
  // creado por: Alberto Bachler Klein: 01-09-16, 13:22:10
  // -----------------------------------------------------------
C_PICTURE:C286($p_Imagen)
C_TEXT:C284($t_extension;$t_rutaArchivo)

ARRAY TEXT:C222($at_codigosCodecs;0)
ARRAY TEXT:C222($at_nombresCodec;0)

Case of 
	: (Form event:C388=On Drop:K2:12)
		
		PICTURE CODEC LIST:C992($at_codigosCodecs;$at_nombresCodec)
		
		$t_rutaArchivo:=IT_archivosArrastrados 
		If ($t_rutaArchivo#"")
			$t_extension:=SYS_extensionDocumento ($t_rutaArchivo)
			If (Find in array:C230($at_codigosCodecs;$t_extension)>0)
				READ PICTURE FILE:C678($t_rutaArchivo;$p_Imagen)
				CONVERT PICTURE:C1002($p_Imagen;".png")
				[xShell_PictLibrary:194]pict:3:=$p_Imagen
				SAVE RECORD:C53([xShell_PictLibrary:194])
			Else 
				ALERT:C41("Formato de imagen no compatible!")
			End if 
		End if 
		
		
End case 