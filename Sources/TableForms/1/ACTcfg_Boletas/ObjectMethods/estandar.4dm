C_LONGINT:C283($table)
$readOnlyState:=Read only state:C362([xShell_Reports:54])
$line:=AL_GetLine (xAL_Modelos)
READ WRITE:C146([xShell_Reports:54])
$table:=Table:C252(->[ACT_Boletas:181])*-1
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosDocID{$line})
[xShell_Reports:54]IsStandard:38:=(Self:C308->=1)
SAVE RECORD:C53([xShell_Reports:54])
If ($readOnlyState)
	KRL_UnloadReadOnly (->[xShell_Reports:54])
Else 
	UNLOAD RECORD:C212([xShell_Reports:54])
End if 
ACTcfg_LeeConfEnNuevoProc ("GuardaConfiguracion")
ACTcfg_LoadConfigData (8)
AL_UpdateArrays (xAL_Modelos;-2)
ACTcfg_MarkStandardDTModels 