//%attributes = {}
  //Método: EV2_Num2Literal

$num:=$1
$decimales:=$2
$minimo:=$3
Case of 
	: ($num=-10)
		$0:=""
	: ($num=-3)
		$0:="X"
	: ($num=-2)
		$0:="P"
	: ($num=-4)
		$0:="*"
	: ($num=-1)
		$0:=""
	Else 
		If ($num>=$minimo)
			$intString:=String:C10(Int:C8($num))
			$dec:=Dec:C9($num)
			If (($dec>0) & ($decimales>0))
				$decString:=Substring:C12(String:C10($dec);3)
				$0:=$intString+<>vs_AppDecimalSeparator+Substring:C12($decString+("0"*$decimales);1;$decimales)
			Else 
				If ($decimales>0)
					$0:=$intString+<>vs_AppDecimalSeparator+("0"*$decimales)
				Else 
					$0:=$intString
				End if 
			End if 
		Else 
			$0:=""
		End if 
End case 