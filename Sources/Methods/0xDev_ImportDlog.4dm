//%attributes = {}
  //0xDev_ImportDlog

  //WDW_Open (320;70;0;4;"Importación en formato 4D")
WDW_OpenFormWindow (->[xShell_Dialogs:114];"SelectTable";0;4;__ ("Importación en formato 4D"))
DIALOG:C40([xShell_Dialogs:114];"SelectTable")
CLOSE WINDOW:C154
If (ok=1)
	IO_ImportRecords2OneTable (Table:C252(vi_TableNumber))
End if 