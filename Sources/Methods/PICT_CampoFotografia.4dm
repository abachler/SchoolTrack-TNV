//%attributes = {}
  //`Método: PICT_CampoFotografia


C_POINTER:C301($1;$tablePointer;$picturePointer)
C_PICTURE:C286($picture)
C_LONGINT:C283($table;$id;$data)
C_BOOLEAN:C305($marcar)
$picturePointer:=$1
$tablePointer:=Table:C252(Table:C252($picturePointer))
$maxSize:=768

$vl_sizeMax:=500

  //If (SYS_IsQuickTimeAvailable )

  //para leer el archivo con la foto almacenada externamente
$table:=Table:C252($picturePointer)
$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")


$pictureFormat:=PICT_GetDefaultFormat 
$extension:=PICT_GetDefaultExtension 

Case of 
	: ($table=Table:C252(->[Alumnos:2]))
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Alumnos:2]numero:1)+$extension
		$id:=[Alumnos:2]numero:1
		$data:=SN3_DTi_Alumnos
		$marcar:=True:C214
	: ($table=Table:C252(->[Profesores:4]))
		
		If (KRL_isSameField ($picturePointer;->[Profesores:4]Firma:15))
			$fileName:=<>gCountryCode+"."+<>gRolBD+".SIGN."+String:C10([Profesores:4]Numero:1)+$extension
		Else 
			$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Profesores:4]Numero:1)+$extension
		End if 
		$id:=[Profesores:4]Numero:1
		$data:=SN3_DTi_Profesores
		$marcar:=True:C214
	: ($table=Table:C252(->[Personas:7]))
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Personas:7]No:1)+$extension
		$id:=[Personas:7]No:1
		$marcar:=True:C214
		$data:=SN3_DTi_RelacionesFamiliares
	: ($table=Table:C252(->[BBL_Lectores:72]))
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([BBL_Lectores:72]ID:1)+$extension
		$marcar:=False:C215
	: ($table=Table:C252(->[Familia:78]))
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Familia:78]Numero:1)+$extension
		$marcar:=False:C215
	: ($table=Table:C252(->[MPA_DefinicionCompetencias:187]))
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([MPA_DefinicionCompetencias:187]ID:1)+$extension
		$marcar:=False:C215
	: ($table=Table:C252(->[MPA_DefinicionDimensiones:188]))
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([MPA_DefinicionDimensiones:188]ID:1)+$extension
		$marcar:=False:C215
	: ($table=Table:C252(->[MPA_DefinicionEjes:185]))
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([MPA_DefinicionEjes:185]ID:1)+$extension
		$marcar:=False:C215
End case 
  // //

_O_ARRAY STRING:C218(4;$aPictureTypes;0)
PICTURE CODEC LIST:C992($aPictureTypes)
$stringTypePictures:=AT_array2text (->$aPictureTypes;"; ")


If (Count parameters:C259=2)
	$maxSize:=$2
End if 

Case of 
	: (Form event:C388=On Clicked:K2:4)
		$size:=Pasteboard data size:C400(Picture data:K20:3)
		If ($size>0)
			$paste:=__ ("Pegar;")
		Else 
			$paste:=__ ("(Pegar;")
		End if 
		If (Picture size:C356($picturePointer->)>0)
			$copy_cut:=__ ("Cortar;Copiar;")
			$clear:=__ ("Borrar;")
			If (Screen height:C188<768)
				$resize:=__ ("Tamaño real;128 x 128;256 x 256;512 x 512;(768 x 768;(1024 x 1024")
			Else 
				$resize:=__ ("Tamaño real;128 x 128;256 x 256;512 x x512;768 x 768;1024 x 1024")
			End if 
		Else 
			$copy_cut:=__ ("(Cortar;(Copiar;")
			$clear:=__ ("(Borrar;")
			$resize:=__ ("(Tamaño real;(128 x 128;(256 x 256;(512 x 512;(768 x 768;(1024 x 1024")
		End if 
		$menu:=$copy_cut+$paste+$clear+__ ("(-;Insertar desde archivo")
		$menu:=$menu+";(-;"+$resize+__ (";(-;Comprimir;(-;(Guardar como...; ")+$stringTypePictures
		
		$userChoice:=Pop up menu:C542($menu)
		Case of 
			: ($userChoice>=18)
				  //If (SYS_IsQuickTimeAvailable )
				$picture:=xDOC_ReadExternalPicture ($folder;$fileName)
				If (Picture size:C356($picture)>0)
					$format:=$aPictureTypes{$userChoice-17}
					WRITE PICTURE FILE:C680("";$picture;$format)
				Else 
					CD_Dlog (0;__ ("No se encontró la fotografía original."))
				End if 
				  //End if 
				
			: ($userChoice=15)  //comprimir
				$picture:=xDOC_ReadExternalPicture ($folder;$fileName)
				If (Picture size:C356($picture)>0)
					
					$picturePointer->:=$picture
					xDOC_Picture_SetMaxSize ($picturePointer;$maxSize)
					xDOC_WriteExternalPicture ($picturePointer->;$folder;$fileName;$pictureFormat;True:C214)
					CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
					$picturePointer->:=$thumbnail
					If ($marcar)
						SN3_MarcarRegistros ($data;0;$id)
					End if 
				Else 
					CD_Dlog (0;__ ("No se encontró la fotografía original."))
				End if 
				  //Else 
				  //$msg:="QuickTime no está instalado.\rSchoolTrack comprime las imagenes utilizando QuickTi"+"me\r\rSchoolTrack no puede procesar las imagenes sin QuickTime instalado."
				  //$msg:=$msg+"\rDescargue QuickTime (HTTP://www.apple.com/quicktime/downlo"+"a"+"d) e instálelo en su computador (una vez instalado deber· reiniciar SchoolTrack)"+"."
				  //$result:=CD_Dlog (0;$msg;"";"Descargar";"Cancelar")
				  //If ($result=1)
				  //OPEN WEB URL("HTTP://www.apple.com/la/quicktime/download")
				  //End if 
				  //End if 
				
				
			: ($userChoice=1)
				$picture:=xDOC_ReadExternalPicture ($folder;$fileName)
				SET PICTURE TO PASTEBOARD:C521($picture)
				$picturePointer->:=$picturePointer->*0
				xDOC_RemoveExternalPicture ($folder;$fileName)
				
			: ($userChoice=2)
				$picture:=xDOC_ReadExternalPicture ($folder;$fileName)
				SET PICTURE TO PASTEBOARD:C521($picture)
				
			: ($userChoice=3)
				$vb_continuar:=True:C214
				
				If ($vb_continuar)
					GET PICTURE FROM PASTEBOARD:C522($picture)
					$picturePointer->:=$picture
					
					If (Picture size:C356($picture)>100000)
						$p:=IT_UThermometer (1;0;__ ("Almacenando fotografía...");-1)
					End if 
					xDOC_Picture_SetMaxSize ($picturePointer;$maxSize)
					xDOC_WriteExternalPicture ($picturePointer->;$folder;$fileName;$pictureFormat;True:C214)
					If (Picture size:C356($picture)>100000)
						$p:=IT_UThermometer (-2;$p)
					End if 
					CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
					$picturePointer->:=$thumbnail
					If ($marcar)
						SN3_MarcarRegistros ($data;0;$id)
					End if 
				End if 
			: ($userChoice=4)
				$picturePointer->:=$picturePointer->*0
				xDOC_RemoveExternalPicture ($folder;$fileName)
				If ($marcar)
					SN3_MarcarRegistros ($data;0;$id)
				End if 
			: ($userChoice=5)
				  //          
			: ($userChoice=6)
				$doc:=xfGetFileName ("Seleccione el archivo con la imagen")
				  //10-05-2011 AS. Se agrega validacion para cuando se cancela al ingresar una imagen desde archivo.
				If ($doc="")
					$vb_continuar:=False:C215
				Else 
					$size:=Get document size:C479($doc)
					$vb_continuar:=True:C214
				End if 
				
				If ($vb_continuar)
					READ PICTURE FILE:C678($doc;$picture)
					$picturePointer->:=$picture
					
					If (Picture size:C356($picture)>100000)
						$p:=IT_UThermometer (1;0;__ ("Almacenando fotografía...");-1)
					End if 
					
					xDOC_Picture_SetMaxSize ($picturePointer;$maxSize)
					xDOC_WriteExternalPicture ($picturePointer->;$folder;$fileName;$pictureFormat;True:C214)
					
					If (Picture size:C356($picture)>100000)
						$p:=IT_UThermometer (-2;$p)
					End if 
					
					CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
					$picturePointer->:=$thumbnail
					If ($marcar)
						SN3_MarcarRegistros ($data;0;$id)
					End if 
				End if 
				
			: ($userChoice=8)
				vp_Picture:=xDOC_ReadExternalPicture ($folder;$fileName)
				If (Picture size:C356(vp_Picture)>0)
					PICTURE PROPERTIES:C457(vp_Picture;$Width;$Height)
					WDW_Open ($Width;$Height;8;1)
					DIALOG:C40([xShell_Dialogs:114];"XS_ShowPicture")
					CLOSE WINDOW:C154
				Else 
					CD_Dlog (0;__ ("No se encontró la fotografía original."))
				End if 
				
			: ($userChoice>8)
				vp_Picture:=xDOC_ReadExternalPicture ($folder;$fileName)
				If (Picture size:C356(vp_Picture)>0)
					PICTURE PROPERTIES:C457(vp_Picture;$pWidth;$pHeight)
					Case of 
						: ($userChoice=9)
							$size:=128
							
						: ($userChoice=10)
							$size:=256
							
						: ($userChoice=11)
							$size:=512
							
						: ($userChoice=12)
							$size:=768
							
						: ($userChoice=13)
							$size:=1024
							
					End case 
					Case of 
						: (($pheight<$size) & ($pheight>$pwidth))
							$percent:=$size/$pheight
							vp_Picture:=vp_Picture*$percent
						: (($pwidth<$size) & ($pheight<$pwidth))
							$percent:=$size/$pwidth
							vp_Picture:=vp_Picture*$percent
						: (($pheight>$size) & ($pheight>$pwidth))
							$percent:=$size/$pheight
							vp_Picture:=vp_Picture*$percent
						: (($pwidth>$size) & ($pwidth>$pheight))
							$percent:=$size/$pwidth
							vp_Picture:=vp_Picture*$percent
					End case 
					WDW_Open ($size;$size;1;1)
					DIALOG:C40([xShell_Dialogs:114];"XS_ShowPicture")
					CLOSE WINDOW:C154
					vp_Picture:=vp_Picture*0
				Else 
					CD_Dlog (0;__ ("No se encontró la fotografía original."))
				End if 
		End case 
		
	: (Form event:C388=On Double Clicked:K2:5)
		vp_Picture:=xDOC_ReadExternalPicture ($folder;$fileName)
		If (Picture size:C356(vp_Picture)>0)
			PICTURE PROPERTIES:C457(vp_Picture;$Width;$Height)
			WDW_Open ($Width;$Height;0;1)
			DIALOG:C40([xShell_Dialogs:114];"XS_ShowPicture")
			CLOSE WINDOW:C154
		Else 
			CD_Dlog (0;__ ("No se encontró la fotografía original."))
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		
End case 
  //Else 
  //$text:=ST_GetWord (Get text resource(20002);2;"%")
  //CD_Dlog (0;$text)
  //End if 
