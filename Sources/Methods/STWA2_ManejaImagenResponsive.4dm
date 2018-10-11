//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 13-09-17, 08:35:00
  // ----------------------------------------------------
  // Método: STWA2_ManejaImagenResponsive
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_BLOB:C604($xblob)
C_LONGINT:C283($i;$l_alto;$l_cantidad;$l_horizontal;$l_largo;$l_modo;$l_vertical)
C_PICTURE:C286($p_imagen;$p_imagenDefecto)
C_POINTER:C301($y_especificaciones;$y_especificaciones_error;$y_imagen;$y_imagen_1;$y_requerimientos)
C_REAL:C285($r_tamañoImagen)
C_TEXT:C284($t_accion;$t_formato;$t_foto;$t_mensaje;$t_nombreImagen;$t_ruta;$t_rutaEstructura;$t_rutaimagen)
C_OBJECT:C1216($ob_ImagenResponsive)
C_TEXT:C284($t_fotoxdefecto;$t_nombreImagenxdefecto)

ARRAY TEXT:C222($at_formato;0)
ARRAY TEXT:C222($at_imagenesCarpeta;0)
ARRAY TEXT:C222($at_Nombreimagenes;0)
ARRAY TEXT:C222($at_rutaImagen;0)

$t_accion:=$1
Case of 
	: (Count parameters:C259=2)
		$y_imagen:=$2
End case 

Case of 
	: ($t_accion="UD_Handler")
		C_BLOB:C604($xblob)
		C_PICTURE:C286($p_imagenDefecto;$p_imagen)
		C_TEXT:C284($t_fotoColegio;$t_nombreImagenColegio;$t_foto;$t_nombreImagen)
		C_OBJECT:C1216($ob_ImagenResponsive)
		
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaImagen:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images_mobile"+SYS_FolderDelimiterOnServer +"screen-default-stwa.jpg"
		$x_blob:=KRL_GetFileFromServer ($t_rutaImagen)
		BLOB TO PICTURE:C682($x_blob;$p_imagenDefecto;".jpg")
		$t_nombreImagen:=Get picture file name:C1171($p_imagenDefecto)
		PICTURE TO BLOB:C692($p_imagenDefecto;$xblob;".jpg")
		BASE64 ENCODE:C895($xblob;$t_foto)
		
		  //verifico si existe la preferencia
		$ob_ImagenResponsive:=PREF_fGetObject (0;"ImagenFondoResponsive")
		If (Not:C34(OB Is defined:C1231($ob_ImagenResponsive)))
			$ob_ImagenResponsive:=OB_Create 
			OB_SET ($ob_ImagenResponsive;->$t_foto;"fotoxdefecto")
			OB_SET ($ob_ImagenResponsive;->$t_nombreImagen;"nombrexdefecto")
			OB_SET ($ob_ImagenResponsive;->$t_foto;"foto")
			OB_SET ($ob_ImagenResponsive;->$t_nombreImagen;"nombre")
			PREF_SetObject (0;"ImagenFondoResponsive";$ob_ImagenResponsive)
		Else 
			OB_SET ($ob_ImagenResponsive;->$t_foto;"fotoxdefecto")
			OB_SET ($ob_ImagenResponsive;->$t_nombreImagen;"nombrexdefecto")
			PREF_SetObject (0;"ImagenFondoResponsive";$ob_ImagenResponsive)
		End if 
		
		
		  //verifico si el colegio está usando una imagen personalizada
		OB_GET ($ob_ImagenResponsive;->$t_fotoColegio;"foto")
		OB_GET ($ob_ImagenResponsive;->$t_nombreImagenColegio;"nombre")
		
		  //cambio la imagen por la que está utilizando el colegio
		If ($t_nombreImagenColegio#"")
			BASE64 DECODE:C896($t_fotoColegio;$xblob)
			BLOB TO PICTURE:C682($xblob;$p_imagen)
			SET PICTURE FILE NAME:C1172($p_imagen;$t_nombreImagenColegio)
			$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images_mobile"+SYS_FolderDelimiterOnServer 
			$t_rutaimagen:=$t_rutaEstructura+"screen-default-stwa.jpg"
			PICTURE TO BLOB:C692($p_imagen;$x_blob;".jpg")
			KRL_SendFileToServer ($t_rutaimagen;$x_blob;True:C214)
		End if 
		
	: ($t_accion="guardarImagen")
		
		$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_principal")
		$t_nombreImagen:=Get picture file name:C1171($y_imagen->)
		PICTURE TO BLOB:C692($y_imagen->;$xblob;".jpg")
		BASE64 ENCODE:C895($xblob;$t_foto)
		
		
		  //antes de guardar leo la preferencia
		$ob_ImagenResponsive:=PREF_fGetObject (0;"ImagenFondoResponsive")
		OB_SET ($ob_ImagenResponsive;->$t_foto;"foto")
		OB_SET ($ob_ImagenResponsive;->$t_nombreImagen;"nombre")
		PREF_SetObject (0;"ImagenFondoResponsive";$ob_ImagenResponsive)
		
		  //guardo una copia de la imagen en la carpeta del usuario para entregarala como opción
		$t_ruta:=System folder:C487(Documents folder:K41:18)
		$t_rutaimagen:=Replace string:C233($t_ruta;"Documents";"Pictures")+$t_nombreImagen
		
		DOCUMENT LIST:C474($t_ruta;$at_imagenesCarpeta)
		If (Find in array:C230($at_imagenesCarpeta;$t_nombreImagen)=-1)
			WRITE PICTURE FILE:C680($t_rutaimagen;$y_imagen->;".jpg")
		End if 
		
		  //cambio la imagen de la carpeta web
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images_mobile"+SYS_FolderDelimiterOnServer 
		$t_rutaimagen:=$t_rutaEstructura+"screen-default-stwa.jpg"
		PICTURE TO BLOB:C692($y_imagen->;$x_blob;".jpg")
		KRL_SendFileToServer ($t_rutaimagen;$x_blob;True:C214)
		
		OBJECT SET RGB COLORS:C628(*;"t_usarFoto";0x00ABA7A7;0x00ABA7A7)
		OBJECT SET ENABLED:C1123(*;"btn_usar";False:C215)
		
		OBJECT SET TITLE:C194(*;"t_mensajeOK";"Imagen actualizada correctamente.")
		
	: ($t_accion="cargaImagenxDefecto")
		
		$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_principal")
		$ob_ImagenResponsive:=PREF_fGetObject (0;"ImagenFondoResponsive")
		OB_GET ($ob_ImagenResponsive;->$t_fotoxdefecto;"fotoxdefecto")
		OB_GET ($ob_ImagenResponsive;->$t_nombreImagenxdefecto;"nombrexdefecto")
		BASE64 DECODE:C896($t_fotoxdefecto;$xblob)
		BLOB TO PICTURE:C682($xblob;$p_imagenDefecto)
		SET PICTURE FILE NAME:C1172($p_imagenDefecto;$t_nombreImagenxdefecto)
		$y_imagen->:=$p_imagenDefecto
		
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaImagen:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images_mobile"+SYS_FolderDelimiterOnServer 
		$t_rutaimagen:=$t_rutaimagen+"screen-default-stwa.jpg"
		PICTURE TO BLOB:C692($y_imagen->;$x_blob;".jpg")
		KRL_SendFileToServer ($t_rutaimagen;$x_blob;True:C214)
		
	: ($t_accion="init")
		C_OBJECT:C1216($ob_ImagenResponsive)
		  //cargo la imagen desde la carpeta web
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaImagen:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images_mobile"+SYS_FolderDelimiterOnServer +"screen-default-stwa.jpg"
		READ PICTURE FILE:C678($t_rutaImagen;$p_imagenDefecto)
		$t_nombreImagen:=Get picture file name:C1171($p_imagenDefecto)
		PICTURE TO BLOB:C692($p_imagenDefecto;$xblob;".jpg")
		BASE64 ENCODE:C895($xblob;$t_foto)
		
		  //creo el objeto por si no existe imagen seleccionada cargar y guardar la imagen por defecto
		  //verifico si existe la preferencia
		$ob_ImagenResponsive:=PREF_fGetObject (0;"ImagenFondoResponsive")
		If (Not:C34(OB Is defined:C1231($ob_ImagenResponsive)))
			$ob_ImagenResponsive:=OB_Create 
			OB_SET ($ob_ImagenResponsive;->$t_foto;"fotoxdefecto")
			OB_SET ($ob_ImagenResponsive;->$t_nombreImagen;"nombrexdefecto")
			OB_SET ($ob_ImagenResponsive;->$t_foto;"foto")
			OB_SET ($ob_ImagenResponsive;->$t_nombreImagen;"nombre")
			PREF_SetObject (0;"ImagenFondoResponsive";$ob_ImagenResponsive)
		Else 
			OB_SET ($ob_ImagenResponsive;->$t_foto;"fotoxdefecto")
			OB_SET ($ob_ImagenResponsive;->$t_nombreImagen;"nombrexdefecto")
			PREF_SetObject (0;"ImagenFondoResponsive";$ob_ImagenResponsive)
		End if 
		
		
		  //verifico si el colegio está usando una imagen personalizada
		OB_GET ($ob_ImagenResponsive;->$t_foto;"foto")
		OB_GET ($ob_ImagenResponsive;->$t_nombreImagen;"nombre")
		
		
		BASE64 DECODE:C896($t_foto;$xblob)
		BLOB TO PICTURE:C682($xblob;$p_imagen)
		SET PICTURE FILE NAME:C1172($p_imagen;$t_nombreImagen)
		$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_principal")
		$y_imagen->:=$p_imagen
		
		STWA2_ManejaImagenResponsive ("CargaEspecificacionesFoto";$y_imagen)
		
		  //Selecciono la imagen por defecto y la dejo siempre como opción para ser seleccionada
		OB_GET ($ob_ImagenResponsive;->$t_fotoxdefecto;"fotoxdefecto")
		OB_GET ($ob_ImagenResponsive;->$t_nombreImagenxdefecto;"nombrexdefecto")
		BASE64 DECODE:C896($t_fotoxdefecto;$xblob)
		BLOB TO PICTURE:C682($xblob;$p_imagenDefecto)
		SET PICTURE FILE NAME:C1172($p_imagenDefecto;$t_nombreImagenxdefecto)
		
		$y_imagen_1:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_1")
		$y_imagen_1->:=$p_imagenDefecto
		
		  // deshabilito el botón para guardar la fotografía
		OBJECT SET RGB COLORS:C628(*;"t_usarFoto";0x00ABA7A7;0x00ABA7A7)
		OBJECT SET ENABLED:C1123(*;"btn_usar";False:C215)
		
		  //Busco las imagenes almacenadas en el computador del servidor para mostrarlas como opciones validas para cargar
		$t_ruta:=System folder:C487(Documents folder:K41:18)
		$t_ruta:=Replace string:C233($t_ruta;"Documents";"Pictures")
		DOCUMENT LIST:C474($t_ruta;$at_Nombreimagenes)
		
		$l_cantidad:=2
		For ($i;1;Size of array:C274($at_Nombreimagenes))
			$t_rutaImagen:=$t_ruta+$at_Nombreimagenes{$i}
			If (Is picture file:C1113($t_rutaImagen))
				READ PICTURE FILE:C678($t_rutaImagen;$p_imagen)
				$r_tamañoImagen:=Picture size:C356($p_imagen)
				PICTURE PROPERTIES:C457($p_imagen;$l_largo;$l_alto)
				If (($l_largo>=1024) & ($l_alto>=768) & (Round:C94(($r_tamañoImagen/1000);0)<=250))
					$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_"+String:C10($l_cantidad))
					If ($l_cantidad<=5)
						$y_imagen->:=$p_imagen
						$l_cantidad:=$l_cantidad+1
					End if 
				End if 
			End if 
		End for 
		
		  //verifico que todos las opciones esten con imagen
		
		For ($i;1;5)
			$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_"+String:C10($i))
			If (Picture size:C356($y_imagen->)=0)
				OBJECT SET ENABLED:C1123($y_imagen->;False:C215)
			End if 
		End for 
		
		
		$y_requerimientos:=OBJECT Get pointer:C1124(Object named:K67:5;"t_requerimientos")
		$y_requerimientos->:="Formato: JPG\r\rTamaño : 250 KB Máx.\r\rDimensiones: 1024 x 768 Min."
		
		
	: ($t_accion="CargaImagen")
		$y_imagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen_fondo_principal")
		$t_nombreImagen:=Select document:C905("";".jpg";"Selecciona imagen";Alias selection:K24:10;$at_rutaImagen)
		If ($t_nombreImagen#"")
			READ PICTURE FILE:C678($at_rutaImagen{1};$y_imagen->)
		End if 
	: ($t_accion="CargaEspecificacionesFoto")
		
		OBJECT SET TITLE:C194(*;"t_mensajeOK";"")
		
		If (Picture size:C356($y_imagen->)>0)
			$r_tamañoImagen:=Picture size:C356($y_imagen->)
			PICTURE PROPERTIES:C457($y_imagen->;$l_largo;$l_alto;$l_horizontal;$l_vertical;$l_modo)
			GET PICTURE FORMATS:C1406($y_imagen->;$at_formato)
			$t_nombreImagen:=Get picture file name:C1171($y_imagen->)
			$t_formato:=Uppercase:C13($at_formato{1})
		End if 
		
		$t_mensaje:=$t_nombreImagen+"\r\r"
		$t_mensaje:=$t_mensaje+"Imagen "+$t_formato+" - "+String:C10(Round:C94(($r_tamañoImagen/1000);0))+" KB"+"\r\r"
		$t_mensaje:=$t_mensaje+"Dimensiones: "+String:C10($l_largo)+" x "+String:C10($l_alto)
		
		$y_especificaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"t_especificaciones")
		$y_especificaciones->:=$t_mensaje
		
		If (($l_largo>=1024) & ($l_alto>=768) & (Round:C94(($r_tamañoImagen/1000);0)<=250))
			OBJECT SET RGB COLORS:C628(*;"t_especificaciones_error";0x0020C050;0x0020C050)
			$y_especificaciones_error:=OBJECT Get pointer:C1124(Object named:K67:5;"t_especificaciones_error")
			$y_especificaciones_error->:="La imagen cumple los requerimientos para poder ser utilizada."
			
			OBJECT SET RGB COLORS:C628(*;"t_usarFoto";0x0000;0x0000)
			OBJECT SET ENABLED:C1123(*;"btn_usar";True:C214)
		Else 
			OBJECT SET RGB COLORS:C628(*;"t_especificaciones_error";0x00FF0000;0x00FFFFFF)
			$y_especificaciones_error:=OBJECT Get pointer:C1124(Object named:K67:5;"t_especificaciones_error")
			$y_especificaciones_error->:="La imagen no cumple los requerimientos para poder ser utilizada."
			
			OBJECT SET RGB COLORS:C628(*;"t_usarFoto";0x00ABA7A7;0x00ABA7A7)
			OBJECT SET ENABLED:C1123(*;"btn_usar";False:C215)
		End if 
		
End case 


