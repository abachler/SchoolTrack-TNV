//%attributes = {}
  //CFG_STR_Colegio

READ WRITE:C146([Colegio:31])
ALL RECORDS:C47([Colegio:31])
If (Records in selection:C76([Colegio:31])=0)
	CREATE RECORD:C68([Colegio:31])
	SAVE RECORD:C53([Colegio:31])
End if 
FIRST RECORD:C50([Colegio:31])
CFG_OpenConfigPanel (->[Colegio:31];"Configuration";1)
KRL_ExecuteEverywhere ("STR_LeeConfiguracion")