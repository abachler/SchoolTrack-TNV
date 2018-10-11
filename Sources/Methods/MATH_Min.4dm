//%attributes = {}
  //MATH_Min

C_REAL:C285($r_minimo;$0)
C_REAL:C285($r_valor)
C_REAL:C285(${1})
  //$r_minimo:=500

If (Count parameters:C259>0)
	$r_minimo:=$1
	For ($i;1;Count parameters:C259)
		$r_valor:=${$i}
		If ($r_valor<$r_minimo)
			$r_minimo:=$r_valor
		End if 
	End for 
	$0:=$r_minimo
End if 