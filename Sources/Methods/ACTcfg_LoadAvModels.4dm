//%attributes = {}
  //ACTcfg_LoadAvModels

ARRAY TEXT:C222(atACT_ModelosAv;0)
ARRAY TEXT:C222(atACT_ModelosAvDesc;0)
ARRAY LONGINT:C221(alACT_ModelosAvID;0)
ARRAY BOOLEAN:C223(abACT_ModelosAvEsSt;0)
ARRAY LONGINT:C221(alACT_RegXPaginsAv;0)
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1)
SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atACT_ModelosAv;[xShell_Reports:54]ID:7;alACT_ModelosAvID;[xShell_Reports:54]Descripción:16;atACT_ModelosAvDesc;[xShell_Reports:54]IsStandard:38;abACT_ModelosAvEsSt;[xShell_Reports:54]RegistrosXPagina:44;alACT_RegXPaginsAv)
SORT ARRAY:C229(atACT_ModelosAv;alACT_ModelosAvID;atACT_ModelosAvDesc;abACT_ModelosAvEsSt;alACT_RegXPaginsAv;>)