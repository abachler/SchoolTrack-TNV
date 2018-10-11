//%attributes = {}
  //CFG_BBL_Intereses

READ WRITE:C146([xxBBL_Preferencias:65])
ALL RECORDS:C47([xxBBL_Preferencias:65])
If (Records in table:C83([xxBBL_Preferencias:65])=0)
	CREATE RECORD:C68([xxBBL_Preferencias:65])
	SAVE RECORD:C53([xxBBL_Preferencias:65])
End if 
FIRST RECORD:C50([xxBBL_Preferencias:65])
CFG_OpenConfigPanel (->[xxBBL_Preferencias:65];"CFG_Intereses")
LIST TO BLOB:C556(<>hl_InterestList;$blob)
PREF_SetBlob (0;"BBL_ListaInteres";$blob)
KRL_ExecuteOnConnectedClients ("BBL_LeeConfiguracion")
BBL_LeeConfiguracion 