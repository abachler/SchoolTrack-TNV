//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 21-12-15, 17:06:25
  // ----------------------------------------------------
  // Método: STsvg_EscalarRotarImagen
  // Descripción
  //  
  // Método para rotar y escalar un imagen. 
  //
  // Parámetros
  // ----------------------------------------------------


C_BOOLEAN:C305($b_rotarImagen)
C_LONGINT:C283($l_escalaX;$l_escalaY;$l_gradoRotar;$l_rotarX;$l_rotarY)
C_PICTURE:C286($p_imagen)
C_TEXT:C284($refGrafico;$refSvg)

$p_imagen:=$1

$l_gradoRotar:=90
$l_rotarX:=300
$l_rotarY:=300
$b_rotarImagen:=False:C215
$l_escalaX:=10
$l_escalaY:=50


Case of 
	: (Count parameters:C259=2)
		$l_escalaX:=$2
	: (Count parameters:C259=3)
		$l_escalaX:=$2
		$l_escalaY:=$3
	: (Count parameters:C259=4)
		$l_escalaX:=$2
		$l_escalaY:=$3
		$b_rotarImagen:=$4
	: (Count parameters:C259=5)
		$l_escalaX:=$2
		$l_escalaY:=$3
		$b_rotarImagen:=$4
		$l_gradoRotar:=$5
	: (Count parameters:C259=6)
		$l_escalaX:=$2
		$l_escalaY:=$3
		$b_rotarImagen:=$4
		$l_gradoRotar:=$5
		$l_rotarX:=$6
	: (Count parameters:C259=7)
		$l_escalaX:=$2
		$l_escalaY:=$3
		$b_rotarImagen:=$4
		$l_gradoRotar:=$5
		$l_rotarX:=$6
		$l_rotarY:=$7
End case 

$refSvg:=SVG_New 
$refGrafico:=SVG_New_embedded_image ($refSvg;$p_imagen)
SVG_SET_TRANSFORM_SCALE ($refGrafico;$l_escalaX;$l_escalaY)
If ($b_rotarImagen)
	SVG_SET_TRANSFORM_ROTATE ($refGrafico;$l_gradoRotar;$l_rotarX;$l_rotarY)
End if 
$0:=SVG_Export_to_picture ($refGrafico;0)
SVG_CLEAR ($refGrafico)