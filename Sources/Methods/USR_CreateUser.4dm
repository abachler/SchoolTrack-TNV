//%attributes = {}
  //USR_CreateUser

C_TEXT:C284($str)
READ WRITE:C146([xShell_Users:47])
FORM SET INPUT:C55([xShell_Users:47];"Input2")
WDW_OpenFormWindow (->[xShell_Users:47];"Input2";0;4;__ ("Nuevo usuario"))
ADD RECORD:C56([xShell_Users:47];*)
CLOSE WINDOW:C154
If (ok=1)
	USR_GetUserLists 
End if 
UNLOAD RECORD:C212([xShell_Users:47])
READ ONLY:C145([xShell_Users:47])