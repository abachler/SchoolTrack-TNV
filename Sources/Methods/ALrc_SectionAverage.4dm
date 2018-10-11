//%attributes = {}
  //ALrc_SectionAverage

C_POINTER:C301($1)
C_LONGINT:C283($2;$3)
$sum:=0
$div:=0
For ($i;$2;$3)
	$num:=$1->{$i}
	If (($num>0) & (aIncide{$i}))
		$pct:=Round:C94($Num;11)
		$sum:=$sum+$pct
		$div:=$div+1
	End if 
End for 
If ($sum>0)
	$r:=Round:C94($sum/$div;11)
	$0:=EV2_Real_a_Literal ($r;iPrintMode)
Else 
	$0:=""
End if 