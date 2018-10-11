$menu:=AT_array2text (-><>at_Prefijos)
$def:=Find in array:C230(<>at_Prefijos;[Personas:7]Prefijo:90)
If ($def=-1)
	$def:=0
End if 
$choice:=Pop up menu:C542($menu;$def)
If ($choice>0)
	[Personas:7]Prefijo:90:=<>at_Prefijos{$choice}
	vbSpell_StopChecking:=True:C214
	GOTO OBJECT:C206([Personas:7]Prefijo:90)
End if 