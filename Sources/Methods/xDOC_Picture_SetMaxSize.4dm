//%attributes = {}
  // MÉTODO: xDOC_Picture_SetMaxSize
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/11, 17:15:56
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // xDOC_Picture_SetMaxSize()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_POINTER:C301($1;$yPicture)
C_LONGINT:C283($2;$maxSize;$width;$height)
$yPicture:=$1
$maxSize:=$2



  // CODIGO PRINCIPAL
PICTURE PROPERTIES:C457($yPicture->;$width;$height)
Case of 
	: (($width>$maxSize) & ($height<$width))
		xDOC_Picture_Resize ($yPicture;$maxSize)
	: (($height>$maxSize) & ($height>$width))
		xDOC_Picture_Resize ($yPicture;0;$maxSize)
End case 