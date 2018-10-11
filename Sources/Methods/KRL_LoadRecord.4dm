//%attributes = {}
  //KRL_LoadRecord



READ WRITE:C146($1->)
ok:=1
LOAD RECORD:C52($1->)
If ((Locked:C147($1->)) & (ok=1))
	MUloadFile:=$1
	LOCKED BY:C353(MUloadFile->;$procID;$user;$station;$procName)
	vMUmess:=__ ("El registro está siendo utilizado por:\rUsuario: ˆ0\rComputador: ˆ1\rEn el proceso: ˆ2")
	VMUmess:=vMUmess+"\r"+__ ("¿Desea esperar que sea liberado?")
	vMUmess:=Replace string:C233(vMUmess;"ˆ0";$user)
	vMUmess:=Replace string:C233(vMUmess;"ˆ1";$station)
	vMUmess:=Replace string:C233(vMUmess;"ˆ2";$procName)
	WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_LockedRecord";0;-Palette form window:K39:9)
	DIALOG:C40([xShell_Dialogs:114];"XS_LockedRecord")
	If (bWait=1)
		vMUmess:=__ ("Esperando que el registro sea liberado...")
		DIALOG:C40([xShell_Dialogs:114];"XS_LockedRecord")
	End if 
	CLOSE WINDOW:C154
End if 
$0:=OK