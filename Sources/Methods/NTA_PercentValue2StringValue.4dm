//%attributes = {}
  //NTA_PercentValue2StringValue

C_LONGINT:C283($2;$3;$convertTo)
C_REAL:C285($percent;$1)
C_TEXT:C284($result;$0)
C_POINTER:C301($4;$conversionPointer)

$result:=""
$roundTo:=0
$percent:=$1
$trunc:=0
Case of 
	: (Count parameters:C259=6)
		$trunc:=$6
		$roundTo:=$5
		$conversionPointer:=$4
		$evStyleID:=$3
		$convertTo:=$2
	: (Count parameters:C259=5)
		$roundTo:=$5
		$conversionPointer:=$4
		$evStyleID:=$3
		$convertTo:=$2
	: (Count parameters:C259=4)
		$conversionPointer:=$4
		$evStyleID:=$3
		$convertTo:=$2
	: (Count parameters:C259=3)
		$evStyleID:=$3
		$convertTo:=$2
	: (Count parameters:C259>=2)
		$evStyleID:=0
		$convertTo:=$2
	: (Count parameters:C259=1)
		$evStyleID:=0
End case 

If ($evStyleID#0)
	EVS_ReadStyleData ($evStyleID)
End if 

If ($convertTo=0)
	Case of 
		: (Count parameters:C259=4)
			$convertTo:=$4->
		: (Count parameters:C259=3)
			$convertTo:=$2
		: (Count parameters:C259>=2)
			$convertTo:=$2
		Else 
			$convertTo:=iEvaluationMode
	End case 
End if 

If (($convertTo=0) & (Not:C34(Is nil pointer:C315($conversionPointer))))
	$convertTo:=$conversionPointer->
End if 

Case of 
		  //: (($percent=0) | ($percent=-1))
	: ($percent=-10)
		$result:=""
	: ($percent=-4)
		$result:="*"
	: ($percent=-3)
		$result:="X"
	: ($percent=-2)
		$result:="P"
	: ($convertTo=Notas)
		$result:=EV2_Real_a_Literal ($percent;$convertTo;iGradesDec;$trunc;$evStyleID)
	: ($convertTo=Puntos)
		$result:=EV2_Real_a_Literal ($percent;$convertTo;iPointsDec;$trunc;$evStyleID)
	: ($convertTo=Porcentaje)
		If ($roundTo=0)
			$roundTo:=1
		End if 
		If ($roundTo=1)
			$result:=String:C10(Round:C94($percent;1);vs_PercentFormat)
		Else 
			$value:=Round:C94($percent;$roundTo)
			$format:="##0"+<>tXS_RS_DecimalSeparator+("0"*$roundTo)+"%"
			$result:=String:C10($value;$format)
		End if 
	: ($convertTo=Simbolos)
		$result:=EV2_Real_a_Simbolo ($percent;$trunc;$roundTo)
End case 

$0:=$result