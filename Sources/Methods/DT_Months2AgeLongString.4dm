//%attributes = {}
  //DT_Months2AgeLongString

C_LONGINT:C283($1;$months)
$ageString:=""
$months:=$1

$años:=Int:C8($months/12)
$meses:=$months/12
$meses:=Round:C94($meses*12;0)
$meses:=$meses-($años*12)
Case of 
	: (($años=0) & ($meses=0))
		$ageString:="Recién nacido"
	: (($años=0) & ($meses#0))
		If ($meses>1)
			$ageString:=String:C10($meses)+" meses"
		Else 
			$ageString:=String:C10($meses)+" mes"
		End if 
	: (($años#0) & ($meses=0))
		If ($años=1)
			$ageString:=String:C10($años)+" año"
		Else 
			$ageString:=String:C10($años)+" años"
		End if 
	: (($años>1) & ($meses<12))
		If ($meses>1)
			$ageString:=String:C10($años)+" años y "+String:C10($meses)+" meses"
		Else 
			$ageString:=String:C10($años)+" años y "+String:C10($meses)+" mes"
		End if 
	Else 
		If ($años=1)
			If ($meses>1)
				$ageString:=String:C10($años)+" año y "+String:C10($meses)+" meses"
			Else 
				$ageString:=String:C10($años)+" año y "+String:C10($meses)+" mes"
			End if 
		Else 
			If ($meses>1)
				$ageString:=String:C10($años)+" años y "+String:C10($meses)+" meses"
			Else 
				$ageString:=String:C10($años)+" años y "+String:C10($meses)+" mes"
			End if 
		End if 
End case 

$0:=$ageString