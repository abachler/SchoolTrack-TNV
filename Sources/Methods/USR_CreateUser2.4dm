//%attributes = {}
  //USR_CreateUser2

C_TEXT:C284($str)
READ WRITE:C146([xShell_Users:47])
FORM SET INPUT:C55([xShell_Users:47];"Input2")
WDW_OpenFormWindow (->[xShell_Users:47];"Input2";-1;Palette form window:K39:9;__ ("Nuevo usuario"))
ADD RECORD:C56([xShell_Users:47];*)
CLOSE WINDOW:C154
If (ok=1)
	USR_GetUserLists 
End if 
KRL_UnloadReadOnly (->[xShell_Users:47])