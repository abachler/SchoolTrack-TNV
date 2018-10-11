  // [Profesores].Input.Field23()
  // Por: Alberto Bachler K.: 31-03-14, 17:17:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($l_altoImagen;$l_anchoImagen;$l_itemSeleccionado)
C_PICTURE:C286($p_Imagen)
C_POINTER:C301($y_objetoActual)
C_REAL:C285($r_factor)
C_TEXT:C284($t_rutaArchivo;$t_tiposDocumento)

ARRAY TEXT:C222($at_firma;0)
ARRAY TEXT:C222($at_formatoNativo;0)
ARRAY TEXT:C222($at_rutaDocumento;0)

$y_objetoActual:=OBJECT Get pointer:C1124(Object current:K67:2)

Case of 
	: (Form event:C388=On Drop:K2:12)
		$t_rutaArchivo:=IT_archivosArrastrados 
		If ($t_rutaArchivo#"")
			READ PICTURE FILE:C678($t_rutaArchivo;$p_Imagen)
		End if 
		
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		  //ARRAY TEXT($at_itemsMenu;9)
		ARRAY TEXT:C222($at_itemsMenu;6)  //20170301 RCH
		GET PASTEBOARD DATA TYPE:C958($at_firma;$at_formatoNativo)
		If (Picture size:C356($y_objetoActual->)>0)
			$at_itemsMenu{1}:=__ ("Cortar")
			$at_itemsMenu{2}:=__ ("Copiar")
			$at_itemsMenu{4}:=__ ("Borrar")
		Else 
			$at_itemsMenu{1}:="("+__ ("Cortar")
			$at_itemsMenu{2}:="("+__ ("Copiar")
			$at_itemsMenu{4}:="("+__ ("Borrar")
		End if 
		Case of 
			: (Find in array:C230($at_firma;"com.4d.private.picture@")>0)
				$at_itemsMenu{3}:=__ ("Pegar")
			Else 
				$at_itemsMenu{3}:="("+__ ("Pegar")
		End case 
		$at_itemsMenu{5}:="(-"
		$at_itemsMenu{6}:=__ ("Importar...")
		$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_itemsMenu)
		
		Case of 
			: ($l_itemSeleccionado=1)
				SET PICTURE TO PASTEBOARD:C521($y_objetoActual->)
				$y_objetoActual->:=$y_objetoActual->*0
				
			: ($l_itemSeleccionado=4)  // cortar o borrar
				$y_objetoActual->:=$y_objetoActual->*0
				
			: ($l_itemSeleccionado=2)  // copiar
				SET PICTURE TO PASTEBOARD:C521($y_objetoActual->)
				
			: ($l_itemSeleccionado=3)  // pegar
				GET PICTURE FROM PASTEBOARD:C522($p_Imagen)
				CONVERT PICTURE:C1002($p_imagen;".png")
				
			: ($l_itemSeleccionado=6)  // importar
				If (SYS_IsWindows )
					$t_tiposDocumento:="bmp;png;ico;jpg;gif;tiff;wdp"
					document:=Select document:C905(1;$t_tiposDocumento;"Seleccione un documento de tipo imagen...";0;$at_rutaDocumento)
					If (document#"")
						READ PICTURE FILE:C678($at_rutaDocumento{1};$p_Imagen)
					End if 
				Else 
					READ PICTURE FILE:C678("";$p_Imagen)
				End if 
				
		End case 
End case 

If (Picture size:C356($p_Imagen)>0)
	  // REDIMENSIONAMIENTO DE LA FIRMA
	  // El tamaño máximo de los objetos firma en los formularios de impresión es 240*80
	  // la imagen puede ser redimensionada a ese tamaño
	PICTURE PROPERTIES:C457($p_Imagen;$l_anchoImagen;$l_altoImagen)
	If ($l_anchoImagen>240)
		  // si el ancho es superior a 240px lom reduzco a 240px
		$r_factor:=240/$l_anchoImagen
		TRANSFORM PICTURE:C988($p_Imagen;Scale:K61:2;$r_factor;$r_Factor)
		PICTURE TO BLOB:C692($p_Imagen;$x_blob;".png")
		BLOB TO PICTURE:C682($x_blob;$p_Imagen;".png")
	End if 
	
	PICTURE PROPERTIES:C457($p_Imagen;$l_anchoImagen;$l_altoImagen)
	If ($l_altoImagen>80)
		  // si el alto es superior a 80px, lo reduzco a 80px
		$r_factor:=80/$l_altoImagen
		TRANSFORM PICTURE:C988($p_Imagen;Scale:K61:2;$r_factor;$r_Factor)
		PICTURE TO BLOB:C692($p_Imagen;$x_blob;".png")
		BLOB TO PICTURE:C682($x_blob;$p_Imagen;".png")
	End if 
	
	  // en pruebas realizadas con imagenes...
	  // -  .png de 5686px de ancho y 2826 (48MB) la imagen escalada se reduce a 30Kb
	  // -  .tiff de 6757px de ancho y 2953 de alto (60MB) la imagen escalada se reduce a 29KB
	
	$y_objetoActual->:=$p_Imagen
End if 