C_LONGINT:C283($l_columna;$l_fila)

READ ONLY:C145([xShell_Reports:54])
LISTBOX GET CELL POSITION:C971(*;"lb_informes";$l_columna;$l_fila)
GOTO SELECTED RECORD:C245([xShell_Reports:54];$l_fila)
vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
vt_PrePrintMethod:=[xShell_Reports:54]ExecuteBeforePrinting:4
vb_IsOneRecordReport:=[xShell_Reports:54]isOneRecordReport:11