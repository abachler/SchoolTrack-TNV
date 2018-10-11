//%attributes = {}
  //NTA_GradeValue2Percent

C_REAL:C285($0;$result;$nValue)
C_REAL:C285($vrNTA_MinimoEscalaReferencia)
C_TEXT:C284($1;$stringValue)

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
				$result:=NTA_GetPctValueFromConvTable ($nValue;Notas)
			Else 
				$result:=NTA_ConvertNumValue ($nValue;rGradesFrom;rGradesMinimum;rGradesTo;rPctMinimum;100;11)
			End if 
			$0:=$result
		Else 
			  //If (rGradesFrom>0) 
			If (rGradesFrom>=0)  //JHB 11/2/2008
				$result:=-10
				$0:=$result
			End if 
		End if 
End case 



  //Case of 
  //: ($1="")
  //$0:=-10
  //: ($1="P")
  //$0:=-2
  //: ($1="X")
  //$0:=-3
  //: ($1="*")
  //$0:=-4
  //: ($1=">>>")
  //$0:=-5
  //Else 
  //$nValue:=Num($1)
  //$vrNTA_MinimoEscalaReferencia:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia))  `nueva línea 20071227
  //If ($nValue>=$vrNTA_MinimoEscalaReferencia)  `nueva línea 20071227
  //  `If ($nValue>=vrNTA_MinimoEscalaReferencia) `línea antigua 20071227
  //If (iConversionTable=1)
  //$result:=NTA_GetPctValueFromConvTable ($nValue;Notas )
  //Else 
  //$result:=NTA_ConvertNumValue ($nValue;rGradesFrom;rGradesMinimum;rGradesTo;rPctMinimum;100;11)
  //End if 
  //$0:=$result
  //Else 
  //If (AT_GetSumArray (->arAS_EvalPropPercent)>0)  `nueva línea 20080102
  //If (iConversionTable=1)  `nueva línea 20080102
  //$result:=NTA_GetPctValueFromConvTable ($nValue;Notas )  `nueva línea 20080102
  //Else   `nueva línea 20080102
  //$result:=NTA_ConvertNumValue ($nValue;rGradesFrom;rGradesMinimum;rGradesTo;rPctMinimum;100;11)  `nueva línea 20080102
  //End if   `nueva línea 20080102
  //$0:=$result  `nueva línea 20080102
  //Else   `nueva línea 20080102
  //$0:=-10  `línea antigua 20080102
  //End if   `nueva línea 20080102
  //End if 
  //End case 
