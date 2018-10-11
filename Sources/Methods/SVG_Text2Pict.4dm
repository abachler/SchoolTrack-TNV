//%attributes = {}
  //SVG_Text2Pict


  // ----------------------------------------------------
  // User name (OS): Alberto Bachler
  // Date and time: 25/09/09, 16:19:44
  // ----------------------------------------------------
  // Method: SVG_Text2Pict
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------


  // Saúl Ponce O. Ticket N° 152721 (17/11/2015) 
  // Los parámetros estaban mal enumerados produciendo errores; especificamente en el parámetro #7

  // C_LONGINT($2;$heigth;$3;$width;$5;$style;$5;$size;$6;$align;$9;$rotation;$10;$breakAt)

  //C_LONGINT($2;$heigth;$3;$width;$5;$style;$6;$size;$7;$align;$9;$rotation;$10;$breakAt)

C_REAL:C285($7;$align)
C_LONGINT:C283($2;$heigth;$3;$width;$5;$style;$6;$size;$9;$rotation;$10;$breakAt)
C_TEXT:C284($1;$text;$4;$font;$8;$color)
C_PICTURE:C286($picture;$0)
vb_Modificado_4Dv11:=True:C214

$text:=$1
$height:=$2
$width:=$3
$font:=$4
$size:=$5
$style:=$6
$align:=$7
$color:=$8
$rotation:=$9

If (Count parameters:C259=10)
	$breakAt:=$10
End if 
If ($breakAt>0)
	If (Length:C16($text)>$breakAt)
		For ($i;$breakAt;1;-1)
			If ($text[[$i]]=" ")
				$breakAt:=$i-1
				$i:=0
				$line1:=Substring:C12($text;1;$breakAt)
				$line2:=Substring:C12($text;$breakAt+2)
				$text:=$line1+"\r"+$line2
			End if 
		End for 
	End if 
End if 
  //$area:=hmRep_New Offscreen Area (120;120)
  //hmRep_GET TEXT MEASURES ($area;$text;$font;$size;$style;$widthText;$heightText;$as;$des)
  //hmRep_DELETE OFFSCREEN AREA ($area)
Case of 
	: ($size=4)
		$heightText:=4.828125
	: ($size=5)
		$heightText:=6.035156
	: ($size=6)
		$heightText:=7.242188
End case 
$lines:=ST_CharOcurr ("\r";$text;1)+1
$heightText:=($heightText)*$lines
$svgReference:=SVG_New ($width;$height)
$w:=Int:C8($width/2)
$h:=Int:C8($height/2)
$textReference:=SVG_New_text ($svgReference;$text;$w;$h;$font;$size;$style;$align;$color;0)
SVG_SET_TRANSFORM_ROTATE ($svgReference;$rotation;$w;$h)
SVG_SET_TRANSFORM_TRANSLATE ($svgReference;0;-($heightText/2))
$picture:=SVG_Export_to_picture ($svgReference)
SVG_CLEAR ($svgReference)
$0:=$picture