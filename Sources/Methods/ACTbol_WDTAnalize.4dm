//%attributes = {}
  //ACTbol_WDTAnalize

$proc:=IT_UThermometer (1;0;__ ("Analizando datos...");-1)
$value:=0
COPY ARRAY:C226(alACT_WDTNumero;$aTempNumeros)
ARRAY LONGINT:C221($aTempPosNum;Size of array:C274(alACT_WDTNumero))
For ($i;1;Size of array:C274(alACT_WDTNumero))
	$aTempPosNum{$i}:=$i
End for 
SORT ARRAY:C229($aTempNumeros;$aTempPosNum;>)
ARRAY LONGINT:C221($aDuplicates;0)
ARRAY LONGINT:C221($aFaltaSincro;0)
$value:=$aTempNumeros{1}
For ($i;2;Size of array:C274(alACT_WDTNumero))
	$currentValue:=$aTempNumeros{$i}
	If ($currentValue=$value)
		INSERT IN ARRAY:C227($aDuplicates;Size of array:C274($aDuplicates)+1;2)
		$aDuplicates{Size of array:C274($aDuplicates)-1}:=$aTempPosNum{$i-1}
		$aDuplicates{Size of array:C274($aDuplicates)}:=$aTempPosNum{$i}
	Else 
		If ($currentValue#($value+1))
			INSERT IN ARRAY:C227($aFaltaSincro;Size of array:C274($aFaltaSincro)+1;1)
			$aFaltaSincro{Size of array:C274($aFaltaSincro)}:=$aTempPosNum{$i}
		End if 
	End if 
	$value:=$aTempNumeros{$i}
End for 

COPY ARRAY:C226(adACT_WDTFecha;$aTempFechas)
COPY ARRAY:C226(alACT_WDTNumero;$aTempNumeros)
ARRAY LONGINT:C221($aTempPosFecha;Size of array:C274(adACT_WDTFecha))
For ($i;1;Size of array:C274(adACT_WDTFecha))
	$aTempPosFecha{$i}:=$i
End for 
SORT ARRAY:C229($aTempNumeros;$aTempFechas;$aTempPosFecha;>)
ARRAY LONGINT:C221($aBadDates;0)
$prevDate:=$aTempFechas{1}
For ($i;2;Size of array:C274(alACT_WDTNumero))
	$currDate:=$aTempFechas{$i}
	If ($currDate<$prevDate)
		INSERT IN ARRAY:C227($aBadDates;Size of array:C274($aBadDates)+1;1)
		$aBadDates{Size of array:C274($aBadDates)}:=$aTempPosFecha{$i}
	End if 
	$prevDate:=$aTempFechas{$i}
End for 

AL_GetSort (xALP_WizDocTrib;$c1;$c2)
AL_UpdateArrays (xALP_WizDocTrib;0)
For ($i;1;Size of array:C274(asACT_WDT_Duplis))
	If (Find in array:C230($aDuplicates;$i)#-1)
		asACT_WDT_Duplis{$i}:=Char:C90(165)
	Else 
		asACT_WDT_Duplis{$i}:=""
	End if 
	If (Find in array:C230($aBadDates;$i)#-1)
		asACT_WDT_Dates{$i}:=Char:C90(165)
	Else 
		asACT_WDT_Dates{$i}:=""
	End if 
	If (Find in array:C230($aFaltaSincro;$i)#-1)
		asACT_WDT_Sincro{$i}:=Char:C90(165)
	Else 
		asACT_WDT_Sincro{$i}:=""
	End if 
	If (abACT_WDTNulas{$i})
		AL_SetRowColor (xALP_WizDocTrib;$i;"";15*16+8)
		AL_SetRowStyle (xALP_WizDocTrib;$i;2)
	Else 
		AL_SetRowColor (xALP_WizDocTrib;$i;"";16)
		AL_SetRowStyle (xALP_WizDocTrib;$i;0)
	End if 
End for 
AL_UpdateArrays (xALP_WizDocTrib;-2)
AL_SetSort (xALP_WizDocTrib;$c1;$c2)
AL_SetLine (xALP_WizDocTrib;0)
For ($i;1;Size of array:C274(abACT_WDTNulas))
	If (abACT_WDTNulas{$i})
		AL_SetRowColor (xALP_WizDocTrib;$i;"";15*16+8)
		AL_SetRowStyle (xALP_WizDocTrib;$i;2)
	Else 
		AL_SetRowColor (xALP_WizDocTrib;$i;"";16)
		AL_SetRowStyle (xALP_WizDocTrib;$i;0)
	End if 
End for 
IT_UThermometer (-2;$proc)