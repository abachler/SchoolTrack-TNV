//%attributes = {}
  //MATH_ArrayAverage

C_POINTER:C301($array)
C_LONGINT:C283($i;$size;$option)
C_REAL:C285($sum;$divider;$average;$0)

$array:=$1
$option:=0
If (Count parameters:C259=2)
	$option:=$2
End if 

$arrayType:=Type:C295($array->)
$size:=Size of array:C274($array->)
$sum:=0
$divider:=0
For ($i;1;$size)
	If ($arrayType>16)
		$value:=Num:C11($array->{$i})
	Else 
		$value:=$array->{$i}
	End if 
	Case of 
		: ($value>0)  //positive value ($option not relevant)
			$sum:=$sum+$value
			$divider:=$divider+1
		: (($option=1) & ($value=0))  //$option=1, zero values included in average calculation
			$sum:=$sum+$value
			$divider:=$divider+1
		: (($option=2) & ($value<0))  //$option=2, negative values included in average calculation
			$sum:=$sum+$value
			$divider:=$divider+1
	End case 
	
End for 

$average:=$sum/$divider

$0:=$average
