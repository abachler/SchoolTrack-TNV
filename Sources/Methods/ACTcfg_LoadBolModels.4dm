//%attributes = {}
  //ACTcfg_LoadBolModels

QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=Table:C252(->[ACT_Boletas:181])*-1)
SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atACT_ModelosDoc;[xShell_Reports:54]ID:7;alACT_ModelosDocID;[xShell_Reports:54]Descripción:16;atACT_ModelosDesc;[xShell_Reports:54]IsStandard:38;abACT_ModelosEsSt;[xShell_Reports:54]RegistrosXPagina:44;alACT_ModelosDocRegXPag)
SORT ARRAY:C229(atACT_ModelosDoc;alACT_ModelosDocID;atACT_ModelosDesc;abACT_ModelosEsSt;alACT_ModelosDocRegXPag;>)