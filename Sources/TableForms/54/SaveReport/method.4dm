Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY LONGINT:C221($al_recNums;0)
		
		$l_tabla:=vlQR_SRMainTable
		
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportType:2=vtQR_CurrentReportType;*)
		QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]MainTable:3=$l_tabla)
		ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)
		LONGINT ARRAY FROM SELECTION:C647([xShell_Reports:54];$al_recNums)
		
		If (vlQR_ReportRecNum>No current record:K29:2)
			$l_fila:=Find in array:C230($al_recNums;vlQR_ReportRecNum)
			LISTBOX SELECT ROW:C912(*;"lb_informes";$l_fila)
			OBJECT SET SCROLL POSITION:C906(*;"lb_informes";$l_fila;1;*)
		Else 
			vtQR_CurrentReportName:=""
		End if 
		OBJECT SET RGB COLORS:C628(*;"lb_informes";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)
		
		
		If (vtQR_CurrentReportType="gSR2")
			If ([xShell_Reports:54]isOneRecordReport:11)
				bIsOneRecordReport:=1
			Else 
				bIsOneRecordReport:=0
			End if 
		Else 
			OBJECT SET VISIBLE:C603(bIsOneRecordReport;False:C215)
		End if 
		
		GOTO OBJECT:C206(vtQR_CurrentReportName)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
