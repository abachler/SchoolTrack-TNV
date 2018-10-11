//%attributes = {}
  //DT_ReturnAgeInMonths

C_DATE:C307($Date;$comparisonDate;$1;$2)
C_LONGINT:C283($Months;$years;$0)
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

$age:=DT_ReturnAge ($Date;$comparisonDate)
$years:=Num:C11(Substring:C12($age;1;Position:C15(":";$age)-1))
$months:=Num:C11(Substring:C12($age;Position:C15(":";$age)+1))
$months:=$months+($years*12)

$0:=$months