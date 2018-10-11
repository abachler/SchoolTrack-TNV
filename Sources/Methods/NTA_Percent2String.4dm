//%attributes = {}
  //NTA_Percent2String



Case of 
		
	: ($1=Notas)
		For ($j;1;Size of array:C274(aNtaRealArrPointers))
			AT_DimArrays (Size of array:C274(aNtaRealArrPointers{$j}->);aNtaStrArrPointers{$j})
			$realPointer:=aNtaRealArrPointers{$j}
			$stringPointer:=aNtaStrArrPointers{$j}
			For ($i;1;Size of array:C274($realPointer->))
				$x:=$realPointer->{$i}
				If ($x>=vrNTA_MinimoEscalaReferencia)
					$StringPointer->{$i}:=NTA_PercentValue2Grade ($x)
				Else 
					Case of 
						: ($x=-10)
							$StringPointer->{$i}:=""
						: ($x=-1)
							$StringPointer->{$i}:=""
						: ($x=-2)
							$StringPointer->{$i}:="P"
						: ($x=-3)
							$StringPointer->{$i}:="X"
					End case 
				End if 
			End for 
		End for 
		
	: ($1=Puntos)
		For ($j;1;Size of array:C274(aNtaRealArrPointers))
			AT_DimArrays (Size of array:C274(aNtaRealArrPointers{$j}->);aNtaStrArrPointers{$j})
			$realPointer:=aNtaRealArrPointers{$j}
			$stringPointer:=aNtaStrArrPointers{$j}
			For ($i;1;Size of array:C274($realPointer->))
				$x:=$realPointer->{$i}
				If ($x>=vrNTA_MinimoEscalaReferencia)
					$StringPointer->{$i}:=NTA_PercentValue2Points ($x)
				Else 
					Case of 
						: ($x=-10)
							$StringPointer->{$i}:=""
						: ($x=-1)
							$StringPointer->{$i}:=""
						: ($x=-2)
							$StringPointer->{$i}:="P"
						: ($x=-3)
							$StringPointer->{$i}:="X"
					End case 
				End if 
			End for 
		End for 
		
	: ($1=Porcentaje)
		For ($j;1;Size of array:C274(aNtaRealArrPointers))
			AT_DimArrays (Size of array:C274(aNtaRealArrPointers{$j}->);aNtaStrArrPointers{$j})
			$realPointer:=aNtaRealArrPointers{$j}
			$stringPointer:=aNtaStrArrPointers{$j}
			For ($i;1;Size of array:C274($realPointer->))
				$x:=Round:C94($realPointer->{$i};1)
				If ($x>=vrNTA_MinimoEscalaReferencia)
					$stringPointer->{$i}:=String:C10($x;vs_PercentFormat)
				Else 
					Case of 
						: ($x=-10)
							$StringPointer->{$i}:=""
						: ($x=-1)
							$StringPointer->{$i}:=""
						: ($x=-2)
							$StringPointer->{$i}:="P"
						: ($x=-3)
							$StringPointer->{$i}:="X"
					End case 
				End if 
			End for 
		End for 
		
	: ($1=Simbolos)
		For ($j;1;Size of array:C274(aNtaRealArrPointers))
			AT_DimArrays (Size of array:C274(aNtaRealArrPointers{$j}->);aNtaStrArrPointers{$j})
			$realPointer:=aNtaRealArrPointers{$j}
			$stringPointer:=aNtaStrArrPointers{$j}
			For ($i;1;Size of array:C274($realPointer->))
				$x:=Round:C94($realPointer->{$i};12)
				Case of 
					: ($x=-10)
						$StringPointer->{$i}:=""
					: ($x=-1)
						$StringPointer->{$i}:=""
					: ($x=-2)
						$StringPointer->{$i}:="P"
					: ($x=-3)
						$StringPointer->{$i}:="X"
					: ($x>=vrNTA_MinimoEscalaReferencia)
						$stringPointer->{$i}:=NTA_PercentValue2Symbol ($x)
				End case 
			End for 
		End for 
End case 