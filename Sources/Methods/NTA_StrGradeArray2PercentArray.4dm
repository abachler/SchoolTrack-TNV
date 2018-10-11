//%attributes = {}
  //NTA_StrGradeArray2PercentArray

C_LONGINT:C283($evaluationStyle;$mode;$4;$3)

If (Count parameters:C259>=3)
	$sourceMode:=$3
Else 
	$sourceMode:=iEvaluationMode
End if 

If (Count parameters:C259=4)
	$evaluationStyle:=$4
	$el:=Find in array:C230(aEvStyleId;$evaluationStyle)
	If ($el>0)
		GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];aEvStyleRecNo{$el})
		EVS_ReadStyleData 
	End if 
End if 


Case of 
		  //: (iResults=3)
		  //at_DimArrays (Size of array($1->);$2)
	: ($sourceMode=Notas)
		AT_ResizeArrays ($2;Size of array:C274($1->))
		For ($i;1;Size of array:C274($1->))
			Case of 
				: ($1->{$i}="ERR")
					$2->{$i}:=-9
				: ($1->{$i}=">>>")
					$2->{$i}:=-5
				: ($1->{$i}="*")
					$2->{$i}:=-4
				: ($1->{$i}="X")
					$2->{$i}:=-3
				: ($1->{$i}="P")
					$2->{$i}:=-2
				: ($1->{$i}="NE")
					$2->{$i}:=-1
				: ($1->{$i}="")
					$2->{$i}:=-10
				Else 
					If (iConversionTable=1)
						$2->{$i}:=NTA_GetPctValueFromConvTable (Num:C11($1->{$i});$sourceMode)
					Else 
						$2->{$i}:=NTA_GradeValue2Percent ($1->{$i})
					End if 
			End case 
		End for 
	: ($sourceMode=Puntos)
		AT_ResizeArrays ($2;Size of array:C274($1->))
		For ($i;1;Size of array:C274($1->))
			Case of 
				: ($1->{$i}="ERR")
					$2->{$i}:=-9
				: ($1->{$i}=">>>")
					$2->{$i}:=-5
				: ($1->{$i}="*")
					$2->{$i}:=-4
				: ($1->{$i}="X")
					$2->{$i}:=-3
				: ($1->{$i}="P")
					$2->{$i}:=-2
				: ($1->{$i}="NE")
					$2->{$i}:=-1
				: ($1->{$i}="")
					$2->{$i}:=-10
				Else 
					If (iConversionTable=1)
						$2->{$i}:=NTA_GetPctValueFromConvTable (Num:C11($1->{$i});$sourceMode)
					Else 
						$2->{$i}:=NTA_PointValue2Percent ($1->{$i})
					End if 
			End case 
		End for 
	: ($sourceMode=Porcentaje)
		AT_ResizeArrays ($2;Size of array:C274($1->))
		For ($i;1;Size of array:C274($1->))
			Case of 
				: ($1->{$i}="ERR")
					$2->{$i}:=-9
				: ($1->{$i}=">>>")
					$2->{$i}:=-5
				: ($1->{$i}="*")
					$2->{$i}:=-4
				: ($1->{$i}="X")
					$2->{$i}:=-3
				: ($1->{$i}="P")
					$2->{$i}:=-2
				: ($1->{$i}="NE")
					$2->{$i}:=-1
				: ($1->{$i}="0")
					$2->{$i}:=0
				: ($1->{$i}="")
					$2->{$i}:=-10
				Else 
					$2->{$i}:=Num:C11($1->{$i})
			End case 
		End for 
		
	: ($sourceMode=Simbolos)
		AT_ResizeArrays ($2;Size of array:C274($1->))
		For ($i;1;Size of array:C274($1->))
			Case of 
				: ($1->{$i}="ERR")
					$2->{$i}:=-9
				: ($1->{$i}=">>>")
					$2->{$i}:=-5
				: ($1->{$i}="*")
					$2->{$i}:=-4
				: ($1->{$i}="X")
					$2->{$i}:=-3
				: ($1->{$i}="P")
					$2->{$i}:=-2
				: ($1->{$i}="NE")
					$2->{$i}:=-1
				: ($1->{$i}="0")
					$2->{$i}:=0
				Else 
					$2->{$i}:=NTA_SymbolValue2Percent ($1->{$i})
			End case 
		End for 
End case 


