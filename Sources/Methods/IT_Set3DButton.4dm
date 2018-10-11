//%attributes = {}
  //IT_Set3DButton

C_POINTER:C301($1;$button)
C_TEXT:C284($2;$buttonText;$3;$icon;$4;$background;$5;$font)
C_LONGINT:C283($6;$size;$7;$style;$8;$color)

C_TEXT:C284($format)

$button:=$1
$buttonText:=$2
$icon:=$3
$background:=$4

$font:="tahoma"
$size:=9
$style:=Plain:K14:1
$color:=1

Case of 
	: (Count parameters:C259=5)
		$font:=$5
	: (Count parameters:C259=6)
		$font:=$5
		$size:=$6
	: (Count parameters:C259=7)
		$font:=$5
		$size:=$6
		$style:=$7
	: (Count parameters:C259=8)
		$font:=$5
		$size:=$6
		$style:=$7
		$color:=$8
End case 

$format:=$buttonText+";?"+$icon+";?"+$background+";3;1;1;4;0;0;0;0"

OBJECT SET FORMAT:C236($button->;$format)
OBJECT SET FONT:C164($button->;$font)
OBJECT SET FONT SIZE:C165($button->;$size)
OBJECT SET FONT STYLE:C166($button->;$style)
OBJECT SET COLOR:C271($button->;$color)