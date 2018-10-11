Case of 
	: (Form event:C388=On Clicked:K2:4)
		ARRAY LONGINT:C221($al_idTicketEnf;0)
		ARRAY TEXT:C222($at_TicketEnf;0)
		C_LONGINT:C283($l_rnReport;$l_sel)
		
		$y_objtEnf:=OBJECT Get pointer:C1124(Object named:K67:5;"ticketEnfermeria_Obj")
		$y_nomTickEnfSel:=OBJECT Get pointer:C1124(Object named:K67:5;"ticketEnfermeria_nombre")
		OB GET ARRAY:C1229($y_objtEnf->;"ticketEnfermeria_nombre";$at_TicketEnf)
		OB GET ARRAY:C1229($y_objtEnf->;"ticketEnfermeria_id";$al_idTicketEnf)
		$l_sel:=OB Get:C1224($y_objtEnf->;"ticketEnfermeria_seleccionado")
		
		$l_rnReport:=Find in field:C653([xShell_Reports:54]ID:7;$al_idTicketEnf{$l_sel})
		If ($l_rnReport=-1)
			CD_Dlog (0;__ ("El ticket ^0, no se encuentra disponible, por favor utilice otro .";$at_TicketEnf{$l_sel}))
		Else 
			C_POINTER:C301($ptrCurrentTable)
			$ptrCurrentTable:=yBWR_currentTable
			READ ONLY:C145(*)
			GOTO RECORD:C242([xShell_Reports:54];$l_rnReport)
			$reportName:=[xShell_Reports:54]FormName:17
			$specialConfig:=[xShell_Reports:54]SpecialParameter:18
			$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
			$tablePointer:=Table:C252($tableNumber)
			yBWR_currentTable:=$tablePointer
			xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
			COPY NAMED SELECTION:C331([Alumnos:2];"◊Editions")
			xSR_ReportBlob:=SRP_ValidaAjustesImpresion ($l_rnReport)  //MONO Ticket 179726 - 209686
			If (ok=1)
				$err:=SR Print Report (xSR_ReportBlob;3;65535)
			End if 
			yBWR_currentTable:=$ptrCurrentTable
			
		End if 
End case 