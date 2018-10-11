//%attributes = {}
  //NTA_PointValue2Percent

C_REAL:C285($0;$result;$nValue)
C_TEXT:C284($1;$stringValue)
  //If ($1#"")
Case of 
	: ($1="")
		$0:=-10
	: ($1="P")
		$0:=-2
	: ($1="X")
		$0:=-3
	: ($1="*")
		$0:=-4
	: ($1=">>>")
		$0:=-5
	Else 
		$stringValue:=$1
		$stringValue:=EV2_Literal_Sistema ($stringValue)
		$nValue:=Num:C11($stringValue)
		If ($nValue>=0)
			If (iConversionTable=1)
				$result:=NTA_GetPctValueFromConvTable ($nValue;Puntos)
			Else 
				$result:=NTA_ConvertNumValue ($nValue;rPointsFrom;rPointsMinimum;rPointsTo;rPctMinimum;100;11)
			End if 
			$0:=$result
		Else 
			  //If (rPointsFrom>0)
			If (rPointsFrom>0)
				$0:=-10
			End if 
		End if 
End case 
  //End if 
