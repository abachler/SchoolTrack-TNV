//%attributes = {}
  //CFG_BBL_ReglasUsuarios

READ WRITE:C146([xxBBL_ReglasParaUsuarios:64])
<>aPrefUsr:=Find in array:C230(<>aPrefUsr;"GEN")
QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1="GEN")
CFG_OpenConfigPanel (->[xxBBL_ReglasParaUsuarios:64];"CFG_ReglasLectores";1)
KRL_ExecuteOnConnectedClients ("BBL_LeeConfiguracion")
BBL_LeeConfiguracion 