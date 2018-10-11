//%attributes = {}
  //NTA_PercentArray2StrGradeArray

C_LONGINT:C283($evaluationStyle;$mode;$4;$3)

If (Count parameters:C259>=3)
	$mode:=$3
Else 
	$mode:=IViewMode
End if 

If (Count parameters:C259=4)
	$evaluationStyle:=$4
	EVS_ReadStyleData ($evaluationStyle)
End if 

  //ASM Ticket 216848
If (Count parameters:C259=5)
	$l_decimales:=$5
Else 
	$l_decimales:=iGradesDec
End if 

Case of 
		  //: (iResults=3)
		  //at_ResizeArrays ($2;Size of array($1->))
	: ($mode=Notas)
		AT_ResizeArrays ($2;Size of array:C274($1->))
		For ($i;1;Size of array:C274($1->))
			If ($1->{$i}#-10)
				Case of 
					: ($1->{$i}=-10)
						$2->{$i}:=""
					: ($1->{$i}=-9)
						$2->{$i}:="ERR"
					: ($1->{$i}=-5)
						$2->{$i}:=">>>"
					: ($1->{$i}=-4)
						$2->{$i}:="*"
					: ($1->{$i}=-3)
						$2->{$i}:="X"
					: ($1->{$i}=-2)
						$2->{$i}:="P"
					: ($1->{$i}=-1)
						$2->{$i}:="NE"
					: ($1->{$i}=-0.1)
						$2->{$i}:=String:C10(0;vs_percentFormat)
					Else 
						If (iConversionTable=1)
							$2->{$i}:=NTA_GetValueFromPctConvTable ($1->{$i};$mode)
						Else 
							  //$2->{$i}:=EV2_Real_a_Literal ($1->{$i};Notas)
							$2->{$i}:=EV2_Real_a_Literal ($1->{$i};Notas;$l_decimales)  //ASM Ticket 216848
						End if 
				End case 
			Else 
				$2->{$i}:=""
			End if 
		End for 
	: ($mode=Puntos)
		AT_ResizeArrays ($2;Size of array:C274($1->))
		For ($i;1;Size of array:C274($1->))
			If ($1->{$i}#-10)
				Case of 
					: ($1->{$i}=-10)
						$2->{$i}:=""
					: ($1->{$i}=-9)
						$2->{$i}:="ERR"
					: ($1->{$i}=-5)
						$2->{$i}:=">>>"
					: ($1->{$i}=-4)
						$2->{$i}:="*"
					: ($1->{$i}=-3)
						$2->{$i}:="X"
					: ($1->{$i}=-2)
						$2->{$i}:="P"
					: ($1->{$i}=-1)
						$2->{$i}:="NE"
					: ($1->{$i}=-0.1)
						$2->{$i}:=String:C10(0;vs_percentFormat)
					Else 
						$value:=$1->{$i}
						If (iConversionTable=1)
							$2->{$i}:=NTA_GetValueFromPctConvTable ($value;$mode)
						Else 
							$2->{$i}:=EV2_Real_a_Literal ($value;Puntos)
						End if 
				End case 
			Else 
				$2->{$i}:=""
			End if 
		End for 
	: ($mode=Porcentaje)
		AT_ResizeArrays ($2;Size of array:C274($1->))
		For ($i;1;Size of array:C274($1->))
			Case of 
				: ($1->{$i}=-10)
					$2->{$i}:=""
				: ($1->{$i}=-9)
					$2->{$i}:="ERR"
				: ($1->{$i}=-5)
					$2->{$i}:=">>>"
				: ($1->{$i}=-4)
					$2->{$i}:="*"
				: ($1->{$i}=-3)
					$2->{$i}:="X"
				: ($1->{$i}=-2)
					$2->{$i}:="P"
				: ($1->{$i}=-1)
					$2->{$i}:="NE"
				: ($1->{$i}=-0.1)
					$2->{$i}:=String:C10(0;vs_percentFormat)
				Else 
					If ($1->{$i}>0)
						$2->{$i}:=String:C10(Round:C94($1->{$i};1);vs_percentFormat)
					Else 
						$2->{$i}:=""
					End if 
			End case 
		End for 
	: ($mode=Simbolos)
		AT_ResizeArrays ($2;Size of array:C274($1->))
		For ($i;1;Size of array:C274($1->))
			If ($1->{$i}#-10)
				Case of 
					: ($1->{$i}=-9)
						$2->{$i}:="ERR"
					: ($1->{$i}=-5)
						$2->{$i}:=">>>"
					: ($1->{$i}=-4)
						$2->{$i}:="*"
					: ($1->{$i}=-3)
						$2->{$i}:="X"
					: ($1->{$i}=-2)
						$2->{$i}:="P"
					: ($1->{$i}=-1)
						$2->{$i}:="NE"
					: ($1->{$i}=-0.1)
						$2->{$i}:=String:C10(0;vs_percentFormat)
					Else 
						$2->{$i}:=EV2_Real_a_Simbolo ($1->{$i})
				End case 
			Else 
				$2->{$i}:=""
			End if 
		End for 
End case 
