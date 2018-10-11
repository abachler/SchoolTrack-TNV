//%attributes = {}
  //EVS_GetFormat

$evstyleID:=$1
$mode:=$2
If (Count parameters:C259=3)
	$modePointer:=$3
End if 
If ($mode=0)
	$mode:=$modePointer->
End if 

EVS_ReadStyleData ($evStyleID)
If ($mode=0)
	$mode:=iPrintMode
End if 
Case of 
	: ($mode=Notas)
		$format:=vs_GradesFormat
	: ($mode=Puntos)
		$format:=vs_pointsFormat
	: ($mode=Porcentaje)
		$format:=vs_percentFormat
	: ($mode=Simbolos)
		$length:=0
		For ($i;1;Size of array:C274(aSymbol))
			If (Length:C16(aSymbol{$i})>$length)
				$length:=Length:C16(aSymbol{$i})
			End if 
		End for 
		$format:=" "*$length
End case 
$0:=$format
