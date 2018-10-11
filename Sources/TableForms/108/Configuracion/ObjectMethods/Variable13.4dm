C_LONGINT:C283($r)
If (modBloqueos)
	$r:=CD_Dlog (0;__ ("¿Desea grabar los bloqueos para el año ")+String:C10(vPrevAñoCierre)+__ ("?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		ACTcm_SaveYear (vPrevAñoCierre)
	End if 
End if 
vPrevAñoCierre:=vAñoCierre
ACTcm_LoadYear (Self:C308->)