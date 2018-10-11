//%attributes = {}
  //AS_fAverage

C_REAL:C285($i;$sum;$div;$0)

ARRAY REAL:C219($aReal;0)
COPY ARRAY:C226($1->;$aReal)

If (Size of array:C274($aReal)#0)
	$div:=0
	$sum:=0
	For ($i;1;Size of array:C274($aReal))
		If (($aReal{$i}>=vrNTA_MinimoEscalaReferencia))
			$num:=$aReal{$i}
			If ($num>=vrNTA_MinimoEscalaReferencia)
				$Sum:=$sum+$num
				$div:=$div+1
			End if 
		End if 
	End for 
	If ($div#0)
		$0:=Round:C94($sum/$div;11)
	Else 
		$0:=-10
	End if 
Else 
	$0:=-10
End if 