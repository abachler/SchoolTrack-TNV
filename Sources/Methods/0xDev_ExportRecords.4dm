//%attributes = {}
  // 0xDev_ExportRecords()
  // Por: Alberto Bachler: 14/02/13, 11:37:36
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283(vl_numeroRegistros)
C_POINTER:C301($y_table)


vl_numeroRegistros:=0
WDW_OpenFormWindow ($y_table;"IO_ExportarRegistros";0;4;__ ("Exportación en formato 4D"))
DIALOG:C40("IO_ExportarRegistros")
CLOSE WINDOW:C154
If (ok=1)
	IO_ExportRecordsFromOneTable (Table:C252(iTableNumber))
End if 