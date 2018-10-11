//%attributes = {}
  //NTA_PercentValue2Points

C_REAL:C285($1;$nValue;$Result;$minimum)
C_LONGINT:C283($truncate;$roundTo)
C_BOOLEAN:C305($4;$set2Minimum)
$set2Minimum:=True:C214
$nValue:=$1
$minimum:=vrNTA_MinimoEscalaReferencia
Case of 
	: (Count parameters:C259=5)
		$truncate:=$2
		$roundTo:=$3
		$set2Minimum:=$4
		$minimum:=$5
	: (Count parameters:C259=4)
		$truncate:=$2
		$roundTo:=$3
		$set2Minimum:=$4
	: (Count parameters:C259=3)
		$truncate:=$2
		$roundTo:=$3
	: (Count parameters:C259=2)
		$truncate:=$2
	Else 
		$truncate:=0
End case 

Case of 
	: ($nValue=-10)  //ABK 20071109
		$0:=""
	: ($nValue=-5)
		$0:=">>>"
	: ($nValue=-4)
		$0:="*"
	: ($nValue=-2)
		$0:="P"
	: ($nValue=-3)
		$0:="X"
		  //: ($nValue=-0,1)
		  //If (iConversionTable=1)
		  //$0:=NTA_GetValueFromPctConvTable ($nValue;Puntos )
		  //Else 
		  //$0:=String(0;vs_pointsFormat)
		  //End if 
		  //  `: ($nValue>0)
	: ($nValue>=$minimum)
		If (iConversionTable=1)
			$0:=NTA_GetValueFromPctConvTable ($nValue;Puntos)
		Else 
			If ($roundTo#0)
				$result:=NTA_ConvertNumValue ($nValue;rPointsFrom/rPointsTo*100;rPctMinimum;100;rPointsMinimum;$roundTo;iPointsDec;rPointsFrom;$truncate;$set2Minimum)
				$format:="####0"+<>tXS_RS_DecimalSeparator+("0"*$roundTo)
				$0:=String:C10($result;$format)
			Else 
				$result:=NTA_ConvertNumValue ($nValue;rPointsFrom/rPointsTo*100;rPctMinimum;100;rPointsMinimum;rPointsTo;iPointsDec;rPointsFrom;$truncate;$set2Minimum)
				  //$result:=NTA_adjustInterval ($result;iPointsDec;rPointsInterval)
				$0:=String:C10($result;vs_pointsFormat)
			End if 
		End if 
	Else 
		$0:=""
End case 
