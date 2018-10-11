  // [xShell_Reports].SaveReport.List Box()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 12:46:40
  // -----------------------------------------------------------
C_LONGINT:C283($l_columna;$l_fila)



$l_evento:=Form event:C388
Case of 
	: ($l_evento=On Load:K2:1)
		
	: ($l_evento=On Load Record:K2:38)
		
	: ($l_evento=On Close Box:K2:21)
		
	: ($l_evento=On Unload:K2:2)
		
	: ($l_evento=On Double Clicked:K2:5)
		POST KEY:C465(13)
		
	: ($l_evento=On Selection Change:K2:29)
		LISTBOX GET CELL POSITION:C971(*;"lb_informes";$l_columna;$l_fila)
		GOTO SELECTED RECORD:C245([xShell_Reports:54];$l_fila)
		vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
End case 

