$menu:=AT_array2text (->atADT_NivName)
$def:=Find in array:C230(aiADT_NivNo;vProsNivelNum)
If ($def=-1)
	$def:=1
End if 
$choice:=Pop up menu:C542($menu;$def)
If ($choice>0)
	vProsNivelNum:=aiADT_NivNo{$choice}
	vProsNivel:=atADT_NivName{$choice}
End if 