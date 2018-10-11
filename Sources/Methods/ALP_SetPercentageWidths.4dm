//%attributes = {}
C_LONGINT:C283($width)
$area:=$1
ARRAY TEXT:C222($columns;0)
ARRAY LONGINT:C221($widths;0)
AL_GetArrayNames ($area;$columns;0)
For ($i;1;Size of array:C274($columns))
	AL_GetWidths ($area;$i;1;$width)
	APPEND TO ARRAY:C911($widths;$width)
End for 
$totalW:=AT_GetSumArray (->$widths)
OBJECT GET COORDINATES:C663(*;"x_AlBrowser";$left;$top;$right;$bottom)
$areaW:=$right-$left-18
ARRAY REAL:C219($percentages;0)
For ($i;1;Size of array:C274($columns))
	$per:=$widths{$i}/$totalW
	APPEND TO ARRAY:C911($percentages;$per)
End for 
ARRAY LONGINT:C221($newWidths;0)
For ($i;1;Size of array:C274($percentages))
	$widthN:=Round:C94($areaW*$percentages{$i};0)
	APPEND TO ARRAY:C911($newWidths;$widthN)
	AL_SetWidths ($area;$i;1;$widthN)
End for 
$totalWN:=AT_GetSumArray (->$newWidths)
$finalDif:=$areaW-$totalWN
If ($finalDif#0)
	$widthN:=$newWidths{Size of array:C274($newWidths)}+$finalDif
	AL_SetWidths ($area;Size of array:C274($newWidths);1;$widthN)
End if 
AL_UpdateArrays ($area;-2)