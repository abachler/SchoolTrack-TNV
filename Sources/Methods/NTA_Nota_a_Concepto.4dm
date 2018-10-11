//%attributes = {}
  //NTA_Nota_a_Concepto

C_REAL:C285($1)
_O_C_STRING:C293(2;$0)
If ($1>0)
	If ($1>10)
		$1:=$1/10
	End if 
	Case of 
		: (($1>=1) & ($1<=3.9))
			$0:="I"
		: (($1>=4) & ($1<=4.9))
			$0:="S"
		: (($1>=5) & ($1<=5.9))
			$0:="B"
		: (($1>=6) & ($1<=7))
			$0:="MB"
	End case 
End if 