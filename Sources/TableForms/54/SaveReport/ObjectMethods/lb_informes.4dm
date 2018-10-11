  // [xShell_Reports].SaveReport.List Box()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 12:46:40
  // -----------------------------------------------------------
C_LONGINT:C283($l_columna;$l_fila)

If (Form event:C388=On Clicked:K2:4)
	LISTBOX GET CELL POSITION:C971(*;"lb_informes";$l_columna;$l_fila)
	GOTO SELECTED RECORD:C245([xShell_Reports:54];$l_fila)
	vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
End if 