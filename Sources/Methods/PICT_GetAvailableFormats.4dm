//%attributes = {}
  //PICT_GetAvailableFormats


C_BOOLEAN:C305($vb_ReadingPictureFormat;<>vb_ReadingPictureFormat)
_O_ARRAY STRING:C218(4;<>aPictureFormats;0)
ARRAY TEXT:C222(<>aPictureFormatNames;0)
If (Application type:C494=4D Remote mode:K5:5)
	$vb_ReadingPictureFormat:=True:C214
	$p:=Execute on server:C373(Current method name:C684;Pila_256K;"Formatos imagen disponibles")
	While ($vb_ReadingPictureFormat)
		GET PROCESS VARIABLE:C371(-1;<>vb_ReadingPictureFormat;$vb_ReadingPictureFormat)
		DELAY PROCESS:C323(Current process:C322;10)
	End while 
	GET PROCESS VARIABLE:C371(-1;<>aPictureFormats;<>aPictureFormats)
	GET PROCESS VARIABLE:C371(-1;<>aPictureFormatNames;<>aPictureFormatNames)
Else 
	_O_PICTURE TYPE LIST:C681(<>aPictureFormats;<>aPictureFormatNames)
	<>vb_ReadingPictureFormat:=False:C215
End if 

$text:=AT_array2text (-><>aPictureFormats;"\")"+"\r"+":($format=\"")
SET TEXT TO PASTEBOARD:C523($text)