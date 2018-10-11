//%attributes = {}
  //NTA_GetPctValueFromConvTable

C_REAL:C285($result;$0)
$value:=$1
$from:=$2


Case of 
	: ($from=Puntos)
		$el:=Find in array:C230(arEVS_ConvPoints;$value)
	: ($from=Notas)
		$el:=Find in array:C230(arEVS_ConvGrades;$value)
End case 

If ($el>0)
	Case of 
		: (iEvaluationMode=Puntos)
			$result:=arEVS_ConvPointsPercent{$el}
		: (iEvaluationMode=Notas)
			$result:=arEVS_ConvGradesPercent{$el}
		Else 
			$result:=-10
	End case 
Else 
	$result:=-10
End if 

$0:=$result