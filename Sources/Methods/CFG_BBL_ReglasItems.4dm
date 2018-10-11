//%attributes = {}
  //CFG_BBL_ReglasItems

READ WRITE:C146([xxBBL_ReglasParaItems:69])
<>aPrefDoc:=Find in array:C230(<>aPrefDoc;"GEN")
QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1="GEN")
CFG_OpenConfigPanel (->[xxBBL_ReglasParaItems:69];"CFG_ReglasItems";1)
KRL_ExecuteOnConnectedClients ("BBL_LeeConfiguracion")
BBL_LeeConfiguracion 