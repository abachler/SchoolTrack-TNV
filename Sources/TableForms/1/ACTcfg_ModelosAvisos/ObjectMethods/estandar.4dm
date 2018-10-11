C_LONGINT:C283($table)
$readOnlyState:=Read only state:C362([xShell_Reports:54])
$row:=AL_GetLine (xAL_ModelosAvisos)
$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
READ WRITE:C146([xShell_Reports:54])
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosAvID{$row})
[xShell_Reports:54]IsStandard:38:=(Self:C308->=1)
SAVE RECORD:C53([xShell_Reports:54])
If ($readOnlyState)
	KRL_UnloadReadOnly (->[xShell_Reports:54])
Else 
	UNLOAD RECORD:C212([xShell_Reports:54])
End if 
ACTcfg_LoadAvModels 
AL_UpdateArrays (xAL_ModelosAvisos;-2)
ACTcfg_MarkStandardAvModels 