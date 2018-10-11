//%attributes = {}
  //ACTboldte_SetPruebas

WDW_OpenFormWindow (->[ACT_Boletas:181];"setPruebasListado";-1;4;__ ("Listado set de pruebas"))
DIALOG:C40([ACT_Boletas:181];"setPruebasListado")
CLOSE WINDOW:C154

ACTcfg_LoadConfigData (8)
KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->alACTcfg_Razones{atACTcfg_Razones};True:C214)
