//%attributes = {}
  //ALP_DefaultColSettings

$area:=$1
$col:=$2
$array:=$3
$colheader:=""
$width:=0
$format:=""
$colJust:=0
$HeadJust:=0
$enterable:=0
Case of 
	: (Count parameters:C259=4)
		$colheader:=$4
	: (Count parameters:C259=5)
		$colheader:=$4
		$width:=$5
	: (Count parameters:C259=6)
		$colheader:=$4
		$width:=$5
		$format:=$6
	: (Count parameters:C259=7)
		$colheader:=$4
		$width:=$5
		$format:=$6
		$colJust:=$7
	: (Count parameters:C259=8)
		$colheader:=$4
		$width:=$5
		$format:=$6
		$colJust:=$7
		$HeadJust:=$8
	: (Count parameters:C259=9)
		$colheader:=$4
		$width:=$5
		$format:=$6
		$colJust:=$7
		$HeadJust:=$8
		$enterable:=$9
End case 
$Error:=AL_SetArraysNam ($area;$col;1;$array)
If ($error=0)
	AL_SetHeaders ($area;$col;1;$colheader)
	AL_SetFormat ($area;$col;$format;$colJust;$HeadJust;0;0)
	AL_SetWidths ($area;$col;1;$width)
	AL_SetHdrStyle ($area;$col;"Tahoma";9;1)
	AL_SetFtrStyle ($area;$col;"Tahoma";9;0)
	AL_SetStyle ($area;$col;"Tahoma";9;0)
	AL_SetForeColor ($area;$col;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor ($area;$col;"White";0;"White";0;"White";0)
	AL_SetEnterable ($area;$col;$enterable)
	AL_SetEntryCtls ($area;$col;0)
End if 
$0:=$error