//%attributes = {}
  //DT_ReturnAge

C_DATE:C307($Date;$comparisonDate;$1;$2)
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
If ($Date#!00-00-00!)
	$diff:=$comparisonDate-$date
	If ($diff>0)
		$0:=String:C10(Int:C8($diff/365))+":"+String:C10(Int:C8(Dec:C9($diff/365)*12))
	Else 
		$0:="000:00"
	End if 
Else 
	$0:=""
End if 