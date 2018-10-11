//%attributes = {}
  //PICT_ScalePicture

  // ---------------------------------------------------- 
  // Project Method: u_ScalePicture(->image; max width; max height) 
  // based on  method Util_ScaleImage published at 4D today

  // Parameters: 
  //   $1 : Pointer : A pointer to an image 
  //   $2 : Longint : The desired maximum image width 
  //   $3 : Longint : The desired maximum image height 

  // Returns: 
  //   Directly modifies the image 
  // ---------------------------------------------------- 

C_POINTER:C301($1;$imagePtr)
C_LONGINT:C283($2;$3;$maxWidth;$maxHeight;$width;$height;$vOffset;$hOffset)
C_REAL:C285($scale)

$imagePtr:=$1
$maxWidth:=$2
$maxHeight:=$3

PICTURE PROPERTIES:C457($imagePtr->;$width;$height;$vOffset;$hOffset)
  // The horizontal and vertical offsets are reversed from the documented parameter positions! 

  // Use picture math to set the image's horizontal and vertical offsets to zero. 
$imagePtr->:=$imagePtr->+(0-$hOffset)
$imagePtr->:=$imagePtr->/(0-$vOffset)

If ($width>$maxWidth) | ($height>$maxHeight)  // Only if the picture is too big. 
	If ($width>$height)  // Resize based on the larger of the width or height. 
		$scale:=$maxWidth/$width
	Else 
		$scale:=$maxHeight/$height
	End if 
	$imagePtr->:=$imagePtr->*$scale
End if 

  // Get the updated properties. 
PICTURE PROPERTIES:C457($imagePtr->;$width;$height;$vOffset;$hOffset)
  // The horizontal and vertical offsets are reversed from the documented parameter positions! 

  // Use picture math to center the resized image. 
$hOffset:=($maxWidth-$width)/2
$imagePtr->:=$imagePtr->+$hOffset
$vOffset:=($maxHeight-$height)/2
$imagePtr->:=$imagePtr->/$vOffset