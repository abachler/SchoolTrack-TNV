//%attributes = {}
  //DT_ReturnAgeLongString

C_DATE:C307($Date;$comparisonDate;$1;$2)
C_LONGINT:C283($Months;$years)
C_TEXT:C284($0)
$Date:=$1
If (Count parameters:C259=2)
	If ($2#!00-00-00!)
		$comparisonDate:=$2
	Else 
		$comparisonDate:=Current date:C33(*)
	End if 
Else 
	$comparisonDate:=Current date:C33(*)
End if 


$months:=DT_ReturnAgeInMonths ($date;$comparisonDate)
$ageString:=""

$años:=Int:C8($months/12)
$meses:=$months/12
$meses:=Round:C94($meses*12;0)
$meses:=$meses-($años*12)
Case of 
	: ($Date>$comparisonDate)
		$ageString:="Por nacer"
	: (($años=0) & ($meses=0))
		$ageString:="Recién nacido"
	: (($años=0) & ($meses#0))
		If ($meses>1)
			$ageString:=String:C10($meses)+" meses"
		Else 
			$ageString:=String:C10($meses)+" mes"
		End if 
	: (($años#0) & ($meses=0))
		$ageString:=String:C10($años)+" años"
	: (($años>1) & ($meses<12))
		If ($meses>1)
			$ageString:=String:C10($años)+" años y "+String:C10($meses)+" meses"
		Else 
			$ageString:=String:C10($años)+" años y "+String:C10($meses)+" mes"
		End if 
	Else 
		If ($años=1)
			$ageString:=String:C10($años)+" año"
		Else 
			$ageString:=String:C10($años)+" años"
		End if 
End case 

$0:=$ageString