  //ACTcfg_SaveConfig (8)


ACTcfg_LoadPrinters 
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=Table:C252(->[ACT_Boletas:181])*-1)
SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atACT_ModelosDoc;[xShell_Reports:54]ID:7;alACT_ModelosDocID)
SORT ARRAY:C229(atACT_ModelosDoc;alACT_ModelosDocID;>)
AL_RemoveArrays (ALP_TiposdeDoc;1;8)
xALPSet_ACT_TiposdeDoc 
  //ACTcfg_LoadConfigData (8)

If (Size of array:C274(atACT_ModelosDoc)>0)
	atACT_ModelosDoc:=1
End if 
OBJECT SET ENABLED:C1123(bEditarModelo;Size of array:C274(atACT_ModelosDoc)>0)
OBJECT SET ENABLED:C1123(bBorrarModelo;Size of array:C274(atACT_ModelosDoc)>0)