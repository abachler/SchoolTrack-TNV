//%attributes = {}
  //MATH_Max

C_REAL:C285($r_maximo;$0)
C_REAL:C285($r_valor)
C_REAL:C285(${1})

  //$r_maximo:=1.7^-308

If (Count parameters:C259>0)
	$r_maximo:=$1
	For ($i;1;Count parameters:C259)
		$r_valor:=${$i}
		If ($r_valor>$r_maximo)
			$r_maximo:=$r_valor
		End if 
	End for 
End if 
$0:=$r_maximo