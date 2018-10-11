//%attributes = {}
  // DOCL_MenuContextualObjeto()
  // Por: Alberto Bachler: 17/09/13, 13:42:42
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_guardaDocumento)
C_LONGINT:C283($l_abajo;$l_alto;$l_ancho;$l_arriba;$l_derecha;$l_indexObjeto;$l_itemSeleccionado;$l_izquierda;$l_recNum)
C_TIME:C306($h_RefDocumento)
C_PICTURE:C286($p_Imagen;$p_pdfGenerico)
C_POINTER:C301($y_Miniatura)
C_TEXT:C284($t_extension;$t_nombreArchivoArrastrado;$t_nombreArchivoLibreria;$t_nombreArchivoOriginal;$t_NombreDocumento;$t_NombreObjeto;$t_rutaArchivo;$t_rutaArchivoTemporal;$t_tiposDocumento;$t_UUID)

ARRAY TEXT:C222($at_codigosCodecs;0)
ARRAY TEXT:C222($at_firma;0)
ARRAY TEXT:C222($at_formatoNativo;0)
ARRAY TEXT:C222($at_itemsMenu;0)
ARRAY TEXT:C222($at_nombresCodecs;0)
ARRAY TEXT:C222($at_rutaDocumentos;0)

  // obtengo nombre y propiedades de objeto
$t_NombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
$y_Miniatura:=OBJECT Get pointer:C1124(Object current:K67:2)
OBJECT GET COORDINATES:C663($y_Miniatura->;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
$l_indexObjeto:=Num:C11($t_NombreObjeto)
$l_ancho:=$l_derecha-$l_izquierda+1
$l_alto:=$l_abajo-$l_arriba+1

If (at_UUID_Documento{$l_indexObjeto}#"")
	$t_UUID:=at_UUID_Documento{$l_indexObjeto}
	$t_extension:=KRL_GetTextFieldData (->[DocumentLibrary:234]Auto_UUID:2;->$t_UUID;->[DocumentLibrary:234]Extension:6)
	$t_NombreDocumento:=KRL_GetTextFieldData (->[DocumentLibrary:234]Auto_UUID:2;->$t_UUID;->[DocumentLibrary:234]Document_name:7)
	$t_nombreArchivoLibreria:=$t_UUID+$t_extension
End if 

PICTURE CODEC LIST:C992($at_codigosCodecs;$at_nombresCodecs)

Case of 
	: (Form event:C388=On Drop:K2:12)
		$t_rutaArchivo:=IT_archivosArrastrados 
		If ($t_rutaArchivo#"")
			$t_extension:=SYS_extensionDocumento ($t_rutaArchivo)
			If (SYS_IsWindows  & ($t_extension=".pdf"))
				$h_RefDocumento:=Open document:C264($t_rutaArchivo;Read mode:K24:5)
				$b_guardaDocumento:=True:C214
				If (Find in array:C230($at_codigosCodecs;"@pdf@")>0)
					READ PICTURE FILE:C678($t_rutaArchivo;$p_Imagen)
				End if 
			Else 
				READ PICTURE FILE:C678($t_rutaArchivo;$p_Imagen)
				If (Picture size:C356($p_Imagen)>0)
					DOCUMENT TO BLOB:C525($t_rutaArchivo;$x_blob)
					$b_guardaDocumento:=True:C214
				End if 
			End if 
		End if 
		
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		$x_blob:=DOCL_documento_a_Blob ($t_UUID)
		If (BLOB size:C605($x_blob)>0)
			WEBarea_MuestraDocumento_blob ($x_blob;$t_extension;$t_NombreDocumento)
		End if 
		
	: (Form event:C388=On Mouse Enter:K2:33)
		If (at_UUID_Documento{$l_indexObjeto}#"")
			$t_UUID:=at_UUID_Documento{$l_indexObjeto}
			$t_NombreDocumento:=KRL_GetTextFieldData (->[DocumentLibrary:234]Auto_UUID:2;->$t_UUID;->[DocumentLibrary:234]Document_name:7)
			If ($t_NombreDocumento="")
				$t_extension:=KRL_GetTextFieldData (->[DocumentLibrary:234]Auto_UUID:2;->$t_UUID;->[DocumentLibrary:234]Extension:6)
				$t_NombreDocumento:=$t_UUID+$t_extension
			End if 
			IT_MuestraTip ($t_NombreDocumento)
		Else 
			IT_MuestraTip (__ ("sin imagen ni documento"))
		End if 
		
		
		
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		ARRAY TEXT:C222($at_itemsMenu;9)
		GET PASTEBOARD DATA TYPE:C958($at_firma;$at_formatoNativo)
		If (at_UUID_Documento{$l_indexObjeto}#"")
			$at_itemsMenu{1}:=__ ("Cortar")
			$at_itemsMenu{2}:=__ ("Copiar")
			$at_itemsMenu{4}:=__ ("Borrar")
			$at_itemsMenu{8}:=__ ("Guardar como...")
			$at_itemsMenu{9}:=__ ("Ver Documento...")
		Else 
			$at_itemsMenu{1}:="("+__ ("Cortar")
			$at_itemsMenu{2}:="("+__ ("Copiar")
			$at_itemsMenu{4}:="("+__ ("Borrar")
			$at_itemsMenu{8}:="("+__ ("Guardar como...")
			$at_itemsMenu{9}:="("+__ ("Ver documento...")
		End if 
		Case of 
			: (Find in array:C230($at_firma;"com.4d.private.picture@")>0)
				$at_itemsMenu{3}:=__ ("Pegar")
			: (Find in array:C230($at_firma;"com.4d.private.file.url")>0)
				$t_nombreArchivoArrastrado:=IT_archivosArrastrados 
				If ($t_nombreArchivoArrastrado="@.pdf")
					$at_itemsMenu{3}:=__ ("Pegar")
				End if 
			Else 
				$at_itemsMenu{3}:="("+__ ("Pegar")
		End case 
		$at_itemsMenu{5}:="(-"
		$at_itemsMenu{7}:="(-"
		$at_itemsMenu{6}:=__ ("Importar...")
		$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_itemsMenu)
		
		Case of 
			: (($l_itemSeleccionado=1) | ($l_itemSeleccionado=4))  // cortar o borrar
				If ($l_itemSeleccionado=1)
					$x_blob:=DOCL_documento_a_Blob ($t_UUID)
					If ($t_extension#".pdf")
						BLOB TO PICTURE:C682($x_blob;$p_imagen)
						SET PICTURE TO PASTEBOARD:C521($p_imagen)
					Else 
						$t_rutaArchivoTemporal:=Temporary folder:C486+$t_nombreDocumento
						If (Test path name:C476($t_rutaArchivoTemporal)=Is a document:K24:1)
							DELETE DOCUMENT:C159($t_rutaArchivoTemporal)
						End if 
						$h_refDocumento:=Create document:C266($t_rutaArchivoTemporal;".pdf")
						CLOSE DOCUMENT:C267($h_RefDocumento)
						BLOB TO DOCUMENT:C526(document;$x_blob)
						SET FILE TO PASTEBOARD:C975(document)
					End if 
				End if 
				
				$l_recNum:=Find in field:C653([DocumentLibrary:234]Auto_UUID:2;at_UUID_Documento{$l_indexObjeto})
				KRL_GotoRecord (->[DocumentLibrary:234];$l_recNum;True:C214)
				If (OK=1)
					START TRANSACTION:C239
					DELETE RECORD:C58([DocumentLibrary:234])
					If (OK=1)
						$y_Miniatura->:=PICT_GetNoPictureImage 
						OK:=DOCL_eliminaDocumento (->[BBL_Items:61];String:C10([BBL_Items:61]Numero:1);$t_nombreArchivoLibreria)
					End if 
					If (OK=1)
						VALIDATE TRANSACTION:C240
						at_UUID_Documento{$l_indexObjeto}:=""
					Else 
						CANCEL TRANSACTION:C241
					End if 
				End if 
				
			: ($l_itemSeleccionado=2)  // copiar
				  //SET PICTURE TO PASTEBOARD($y_Miniatura->)
				$x_blob:=DOCL_documento_a_Blob ($t_UUID)
				If ($t_extension#".pdf")
					BLOB TO PICTURE:C682($x_blob;$p_imagen)
					SET PICTURE TO PASTEBOARD:C521($p_imagen)
				Else 
					$t_rutaArchivoTemporal:=Temporary folder:C486+$t_nombreDocumento
					If (Test path name:C476($t_rutaArchivoTemporal)=Is a document:K24:1)
						DELETE DOCUMENT:C159($t_rutaArchivoTemporal)
					End if 
					$h_refDocumento:=Create document:C266($t_rutaArchivoTemporal;".pdf")
					CLOSE DOCUMENT:C267($h_RefDocumento)
					BLOB TO DOCUMENT:C526(document;$x_blob)
					SET FILE TO PASTEBOARD:C975(document)
				End if 
				
			: ($l_itemSeleccionado=3)  // pegar
				$t_nombreArchivoArrastrado:=IT_archivosArrastrados 
				If ($t_nombreArchivoArrastrado#"")
					READ PICTURE FILE:C678($t_nombreArchivoArrastrado;$p_Imagen)
					If (Picture size:C356($p_Imagen)>0)
						$t_extension:=SYS_extensionDocumento ($t_nombreArchivoArrastrado)
						DOCUMENT TO BLOB:C525($t_nombreArchivoArrastrado;$x_blob)
						$b_guardaDocumento:=True:C214
					End if 
				Else 
					GET PICTURE FROM PASTEBOARD:C522($p_Imagen)
					CONVERT PICTURE:C1002($p_imagen;".jpg")
					$t_nombreArchivoArrastrado:=Generate UUID:C1066+".jpg"
					$t_nombreArchivoArrastrado:=Temporary folder:C486+$t_nombreArchivoArrastrado
					WRITE PICTURE FILE:C680($t_nombreArchivoArrastrado;$p_imagen)
					If (Picture size:C356($p_Imagen)>0)
						$b_guardaDocumento:=True:C214
					End if 
				End if 
				
			: ($l_itemSeleccionado=6)  // importar
				If (SYS_IsWindows )
					$t_tiposDocumento:="bmp;png;ico;jpg;gif;tiff;wdp;pdf"
					document:=Select document:C905(1;$t_tiposDocumento;"Seleccione un documento de tipo imagen o pdf...";0;$at_rutaDocumentos)
					If (document#"")
						READ PICTURE FILE:C678($at_rutaDocumentos{1};$p_Imagen)
					End if 
				Else 
					READ PICTURE FILE:C678("";$p_Imagen)
				End if 
				$b_guardaDocumento:=True:C214
				
			: ($l_itemSeleccionado=8)  // Guardar como
				$x_blob:=DOCL_documento_a_Blob ($t_UUID)
				If (BLOB size:C605($x_blob)>0)
					$h_refDocumento:=Create document:C266("";$t_extension)
					CLOSE DOCUMENT:C267($h_refDocumento)
					BLOB TO DOCUMENT:C526(document;$x_blob)
				End if 
				
			: ($l_itemSeleccionado=9)  // Ver documento
				$x_blob:=DOCL_documento_a_Blob ($t_UUID)
				If (BLOB size:C605($x_blob)>0)
					WEBarea_MuestraDocumento_blob ($x_blob;$t_extension;$t_NombreDocumento)
				End if 
		End case 
End case 

  // 
If ($b_guardaDocumento)
	$t_nombreArchivoOriginal:=SYS_Path2FileName (document)
	
	If ($t_nombreArchivoOriginal#"")
		$t_extension:=SYS_extensionDocumento (document)
		DOCUMENT TO BLOB:C525(document;$x_blob)
		If ((SYS_IsWindows ) & ($t_extension=".pdf"))
			READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"img"+Folder separator:K24:12+"pdf_generico.png";$p_pdfGenerico)
			$y_miniatura->:=$p_pdfGenerico
		Else 
			CREATE THUMBNAIL:C679($p_Imagen;$y_miniatura->;$l_ancho;$l_alto;Scaled to fit prop centered:K6:6)
		End if 
		
		$t_UUID:=DOCL_guardaDocumento (->[BBL_Items:61];String:C10([BBL_Items:61]Numero:1);at_UUID_Documento{$l_indexObjeto};$x_blob;$t_nombreArchivoOriginal;$y_miniatura)
		If ($t_UUID#"")
			at_UUID_Documento{$l_indexObjeto}:=$t_UUID
		End if 
	End if 
	
End if 


