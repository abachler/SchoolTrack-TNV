//%attributes = {}
  //ALP_RemoveAllArrays

C_LONGINT:C283($1;$areaRef)
ARRAY TEXT:C222($aArrayNames;0)

$areaRef:=$1
If ($areaRef#0)
	$error:=AL_GetHeaders ($areaRef;$aArrayNames;1)
	If (($error=-2) | (Size of array:C274($aArrayNames)=0))
		  // no hay nada que remover
	Else 
		AL_RemoveArrays ($areaRef;1;Size of array:C274($aArrayNames))
	End if 
End if 