$menu:=AT_array2text (-><>at_Prefijos)
$def:=Find in array:C230(<>at_Prefijos;[ADT_Contactos:95]Prefijo:13)
If ($def=-1)
	$def:=0
End if 
$choice:=Pop up menu:C542($menu;$def)
If ($choice>0)
	[ADT_Contactos:95]Prefijo:13:=<>at_Prefijos{$choice}
	vbSpell_StopChecking:=True:C214
	GOTO OBJECT:C206([ADT_Contactos:95]Prefijo:13)
End if 