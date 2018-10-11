//%attributes = {}
  // MÉTODO: xDOC_Picture_Resize
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/11, 13:06:51
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // xDOC_Picture_Resize()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_POINTER:C301($1;$yPicturePointer)
C_LONGINT:C283($2;$resizeWidth;$3;$resizeheight;$width;$height)
C_REAL:C285($scaleWidth;$scaleHeight)
$yPicturePointer:=$1


  // CODIGO PRINCIPAL
Case of 
	: (Count parameters:C259=3)
		$resizeWidth:=$2
		$resizeheight:=$3
	: (Count parameters:C259=2)
		$resizeWidth:=$2
End case 

PICTURE PROPERTIES:C457($yPicturePointer->;$width;$height)
Case of 
	: (($resizeWidth<=0) & ($resizeheight<=0))
		$scaleWidth:=1
		$scaleHeight:=1
	: (($resizeWidth>0) & ($resizeheight<=0))
		$scaleWidth:=$resizeWidth/$width
		$scaleHeight:=$scaleWidth
	: (($resizeWidth<=0) & ($resizeheight>0))
		$scaleHeight:=$resizeheight/$height
		$scaleWidth:=$scaleHeight
End case 

TRANSFORM PICTURE:C988($yPicturePointer->;Scale:K61:2;$scaleWidth;$scaleHeight)
