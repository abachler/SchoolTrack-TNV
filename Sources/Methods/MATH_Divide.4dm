//%attributes = {}
  //MATH_Divide
  //evita que la división por 0 genere un NAN


C_REAL:C285($1;$2;$0)

If ($2#0)
	$0:=$1/$2
Else 
	$0:=$1
End if 