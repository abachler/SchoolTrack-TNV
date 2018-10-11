//%attributes = {}
  //ACTipc_DeleteNullYears
  //Quita todos los años IPC inválidos

READ WRITE:C146([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="ACT_IPC 0")
DELETE SELECTION:C66([xShell_Prefs:46])
KRL_UnloadReadOnly (->[xShell_Prefs:46])