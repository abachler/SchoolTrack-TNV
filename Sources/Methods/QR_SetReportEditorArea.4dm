//%attributes = {}
  // QR_SetReportEditorArea()
  // Por: Alberto Bachler: 25/02/13, 16:33:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------






vtQR_CurrentReportName:=""
Case of 
	: (vtQR_CurrentReportType="4DSE")
		If (Record number:C243([xShell_Reports:54])>=0)
			vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
			GOTO RECORD:C242([xShell_Reports:54];Record number:C243([xShell_Reports:54]))
			If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
				$blob:=[xShell_Reports:54]xReportData_:29
				QR BLOB TO REPORT:C771(xQR_ReportArea;$blob)
			End if 
			If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#Table:C252(yBWR_currentTable)))
				QR SET REPORT TABLE:C757(xQR_ReportArea;[xShell_Reports:54]RelatedTable:14)
				atQR_TableFieldSelector:=2
				QR_BuildTableList (->hlQR_FieldList;vlQR_MainTable;atQR_TableFieldSelector)
			Else 
				QR SET REPORT TABLE:C757(xQR_ReportArea;[xShell_Reports:54]MainTable:3)
			End if 
		Else 
			QR SET REPORT TABLE:C757(xQR_ReportArea;Abs:C99(vlQR_MainTable))
		End if 
		
	: (vtQR_CurrentReportType="gSR2")
		If (Application version:C493>="15@")
			If (Record number:C243([xShell_Reports:54])>No current record:K29:2)
				vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
				GOTO RECORD:C242([xShell_Reports:54];Record number:C243([xShell_Reports:54]))
				  // el informe se carga automaticamente desde el blob [xShell_Reports]xReportData_
			Else 
				$error:=SR_LoadReport (xReportData;SR_GetTextProperty (0;0;SRP_Area_NewReport))
				SRP_FijaTabla (xReportData;vlQR_SRMainTable)
				SRP_FijaDiseñoPorOmision 
			End if 
			
		Else 
			If (Record number:C243([xShell_Reports:54])>=0)
				vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
				GOTO RECORD:C242([xShell_Reports:54];Record number:C243([xShell_Reports:54]))
				$err:=SR Set Area (xReportData;[xShell_Reports:54]xReportData_:29)
			Else 
				vtQR_CurrentReportName:=""
				$err:=SR New Report (xSR_ReportBlob)
				SRP_FijaDiseñoPorOmision 
				$err:=SR Set Area (xReportData;xSR_ReportBlob)
				$err:=SR Main Table2 (xReportData;1;Abs:C99(vlQR_SRMainTable);"")
			End if 
		End if 
End case 



