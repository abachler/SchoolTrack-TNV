$tab:=Selected list items:C379(vlXS_BrowserTab)
GET LIST ITEM:C378(vlXS_BrowserTab;$tab;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
yBWR_currentTable:=Table:C252(vlBWR_SelectedTableRef)  //pointer to the default table displayed in browser    

USR_RegisterUserEvent (UE_TabSelection;vlBWR_SelectedTableRef)

REDUCE SELECTION:C351(yBWR_currentTable->;0)
BWR_PanelSettings 
BWR_SelectTableData 

XS_SetInterface 
ALP_SetInterface (xALP_Browser)
