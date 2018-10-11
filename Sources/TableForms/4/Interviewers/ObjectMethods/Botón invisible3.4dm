$menu:=AT_array2text (-><>at_Prefijos)
$def:=Find in array:C230(<>at_Prefijos;[Profesores:4]Prefijo:72)
If ($def=-1)
	$def:=0
End if 
$choice:=Pop up menu:C542($menu;$def)
If ($choice>0)
	[Profesores:4]Prefijo:72:=<>at_Prefijos{$choice}
	vbSpell_StopChecking:=True:C214
	GOTO OBJECT:C206([Profesores:4]Prefijo:72)
End if 