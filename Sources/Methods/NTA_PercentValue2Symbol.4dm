//%attributes = {}
  //NTA_PercentValue2Symbol

_O_C_STRING:C293(5;$0)
C_LONGINT:C283($k)
C_REAL:C285($1)
$nValue:=Round:C94($1;11)
Case of 
	: ($nValue=-10)
		$0:=""
	: ($nValue=-5)
		$0:=">>>"
	: ($nValue=-4)
		$0:="*"
	: ($nValue=-2)
		$0:="P"
	: ($nValue=-3)
		$0:="X"
	: ($nValue>=vrNTA_MinimoEscalaReferencia)
		
		If (viEVS_EquivalenciasAbsolutas=0)
			$el:=Find in array:C230(aSymbPctEqu;$nValue)
			If ($el>0)
				$0:=aSymbol{$el}
			Else 
				For ($k;1;Size of array:C274(aSymbol)-1)
					If (($nValue>=Round:C94(aSymbPctFrom{$k};11)) & ($nValue<Round:C94(aSymbPctFrom{$k+1};11)))
						$0:=aSymbol{$k}
						$k:=Size of array:C274(aSymbol)
					End if 
				End for 
				If ($0="")
					If (($nValue>=Round:C94(aSymbPctFrom{Size of array:C274(aSymbol)};11)) & ($nValue<=100))
						$0:=aSymbol{Size of array:C274(aSymbol)}
					Else 
						$0:="S?"
					End if 
				End if 
			End if 
			
		Else 
			$el:=Find in array:C230(aSymbPctEqu;$nValue)
			If ($el>0)
				$0:=aSymbol{$el}
			Else 
				
				For ($k;1;Size of array:C274(aSymbol)-1)
					If (($nValue>=aSymbPctEqu{$k}) & ($nValue<=aSymbPctEqu{$k+1}))
						$inferior:=Round:C94(aSymbPctEqu{$k};11)
						$superior:=Round:C94(aSymbPctEqu{$k+1};11)
						$intervalo:=($superior-$inferior)/2
						$mediana:=$inferior+$intervalo
						Case of 
							: ($nValue<$mediana)
								$0:=aSymbol{$k}
							: ($nValue>=$mediana)
								$0:=aSymbol{$k+1}
						End case 
						$k:=Size of array:C274(aSymbol)
					End if 
				End for 
				
			End if 
		End if 
	Else 
		$0:=""
End case 
