//%attributes = {}
  //QR_Editor

READ ONLY:C145(*)

MNU_SetMenuBar ("XS_ReportEditor")
WDW_OpenFormWindow (->[xShell_Reports:54];"QR_Editor";-1;8;__ ("Editor de informes en columnas"))
DIALOG:C40([xShell_Reports:54];"QR_Editor")
CLOSE WINDOW:C154
MNU_SetMenuBar ("XS_ReportManager")