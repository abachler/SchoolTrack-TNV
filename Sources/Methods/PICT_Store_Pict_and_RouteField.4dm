//%attributes = {}
  //PICT_Store_Pict_and_RouteField
  //$1 = puntero sobre el campo de ruta
  //$2 = ID del registro asociado a la imagen
  //$3  tamaño maximo de la imagen

C_POINTER:C301($tablePointer;$field_ruta_img_ptr;$1)
C_PICTURE:C286($picture)
C_LONGINT:C283($table;$id;$data;$maxSize;$3;$2)
C_BOOLEAN:C305($marcar)
C_TEXT:C284($folder;$pictureFormat;$extension;$file_type)

$maxSize:=256
$vl_sizeMax:=500
$field_ruta_img_ptr:=$1
$id:=$2
If (Count parameters:C259=3)
	$maxSize:=$3
End if 
$tablePointer:=Table:C252(Table:C252($field_ruta_img_ptr))
$table:=Table:C252($field_ruta_img_ptr)

$doc:=xfGetFileName ("Seleccione el archivo con la imagen")
If ($doc#"")
	
	$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
	$pictureFormat:=PICT_GetDefaultFormat 
	$extension:=PICT_GetDefaultExtension 
	
	_O_ARRAY STRING:C218(4;$aPictureTypes;0)
	_O_PICTURE TYPE LIST:C681($aPictureTypes)
	$stringTypePictures:=AT_array2text (->$aPictureTypes;"; ")
	
	$file_type:=ST_CleanFileName ((xfGetFileType ($doc)))
	
	If (Find in array:C230($aPictureTypes;$file_type+"@")>0)
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10($id)+$extension
		$size:=Get document size:C479($doc)
		$vb_continuar:=True:C214
		If (($size/1024)>$vl_sizeMax)
			$vb_continuar:=(CD_Dlog (0;__ ("La imagen que intenta agregar tiene un tamaño de ")+String:C10(Round:C94(($size/1024);0))+__ (" Kilobytes.")+__ (" El tamaño recomendado para las imágenes en el sistema es inferior o igual a 500 Kilobytes.")+"\r\r"+__ ("Agregar imágenes grandes puede causar lentitud.")+"\r\r"+__ ("¿Desea agregar la imagen?");"";"Si";"No")=1)
		End if 
		If ($vb_continuar)
			READ PICTURE FILE:C678($doc;$picture)
			
			If (Picture size:C356($picture)>100000)
				$p:=IT_UThermometer (1;0;__ ("Almacenando imagen...");-1)
			End if 
			
			xDOC_WriteExternalPicture ($picture;$folder;$fileName;$pictureFormat;True:C214)
			
			If (Picture size:C356($picture)>100000)
				$p:=IT_UThermometer (-2;$p)
			End if 
			
			$field_ruta_img_ptr->:=$fileName
			CD_Dlog (0;__ ("Imagen almacenada en el Servidor"))
		End if 
	Else 
		CD_Dlog (0;__ ("El formato de imagen no es válido"))
	End if 
End if 