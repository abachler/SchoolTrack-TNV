//%attributes = {}
  //0xDev_ReplaceExpresion_inCC4D

C_BLOB:C604($xCode;$xTextBlob)
C_TEXT:C284($string2Replace;$replacementString)
ARRAY LONGINT:C221($aMethodsIDs;0)
ARRAY LONGINT:C221($aMethodsID2;0)
ARRAY TEXT:C222($aMethodText;0)
_O_ARRAY STRING:C218(31;$aMethodName;0)
ARRAY LONGINT:C221($aArrayMatches;0)
C_POINTER:C301($1;$aStrings2Replace)
C_POINTER:C301($2;$aReplacementStrings)
$aStrings2Replace:=$1
$aReplacementStrings:=$2

$replacements:=0
If (Count parameters:C259=3)
	$apiRef:=$3
Else 
	$apiRef:=0
End if 

4D_GetMethodList (->$aMethodName;->$aMethodsID2)
$error:=API Get Resource ID List ("CC4D";$aMethodsIDs;$apiRef)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Remplazando Código..."))
$found:=0
For ($i;1;Size of array:C274($aMethodsIDs))
	$el:=Find in array:C230($aMethodsID2;$aMethodsIDs{$i})
	If ($el>0)
		$methodName:=$aMethodName{$el}
	Else 
		$methodName:="Objeto de formulario: "+String:C10($aMethodsIDs{$i})
	End if 
	
	If (($methodName#"zz_CambiosEnNiveles") & ($methodName#"UD_v20071008_Niveles"))
		$err:=API Get Resource ("CC4D";$aMethodsIDs{$i};$xCode;$apiRef)
		
		$xTextBlob:=4D_GetMethodTextBlob_By_CC4D_ID ($aMethodsIDs{$i};$apiRef)
		AT_BlobText2Array (->$aMethodText;$xTextBlob;"\r")
		
		For ($i_Replacements;1;Size of array:C274($aStrings2Replace->))
			$string2Replace:=$aStrings2Replace->{$i_Replacements}
			$replacementString:=$aReplacementStrings->{$i_Replacements}
			$aMethodText{0}:=$string2Replace
			AT_SearchArray (->$aMethodText;"@";->$aArrayMatches)
			If (Size of array:C274($aArrayMatches)>0)
				$found:=$found+1
				For ($i_Matches;1;Size of array:C274($aArrayMatches))
					$aMethodText{$aArrayMatches{$i_Matches}}:=Replace string:C233($aMethodText{$aArrayMatches{$i_Matches}};$string2Replace;$replacementString)
					$replacements:=$replacements+1
				End for 
				4D_SaveMTextFromArray_By_CC4D_I ($aMethodsIDs{$i};->$aMethodText;$apiRef)
			End if 
		End for 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aMethodsIDs);__ ("Remplazando Código..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

ALERT:C41("Procesamiento terminado\rReemplazos efectuados: "+String:C10($replacements))

