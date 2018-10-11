//%attributes = {}
  //PICT_GetDefaultExtension

C_TEXT:C284($extension;$pictureFormat;<>vs_PictureFileExtension)

$pictureFormat:=PICT_GetDefaultFormat 
Case of 
	: ($pictureFormat=".SGI")
		$extension:=".sgi"
	: ($pictureFormat="8BPS")
		$extension:=".psd"
	: ($pictureFormat="BMPf")
		$extension:=".bmp"
	: ($pictureFormat="JPEG")
		$extension:=".jpg"
	: ($pictureFormat="PICT")
		$extension:=".pic"
	: ($pictureFormat="PNGf")
		$extension:=".png"
	: ($pictureFormat="PNTG")
		$extension:=".pnt"
	: ($pictureFormat="TIFF")
		$extension:=".tif"
	: ($pictureFormat="TPIC")
		$extension:=".tga"
	: ($pictureFormat="jp2 ")
		$extension:=".jp2"
	: ($pictureFormat="qtif")
		$extension:=".qti"
	Else 
		$pictureFormat:="JPEG"
		$extension:=".jpg"
End case 
<>vs_PictureFileExtension:=$extension
$0:=$pictureFormat


$0:=<>vs_PictureFileExtension