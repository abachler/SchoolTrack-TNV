//%attributes = {}
  //QR_OpenReport

C_BLOB:C604($blob)
C_LONGINT:C283($1)  //<---Para 4D View!!!
C_LONGINT:C283($2)  //<---Para 4D View!!!
C_LONGINT:C283($3)  //<---Para 4D View!!!

WDW_OpenFormWindow (->[xShell_Reports:54];"OpenReport";-1;8;__ ("Abrir un informe…");"WDW_Close")
DIALOG:C40([xShell_Reports:54];"OpenReport")
CLOSE WINDOW:C154

Case of 
	: (ok=1)
		Case of 
			: (vtQR_CurrentReportType="4DSE")
				QR BLOB TO REPORT:C771(xQR_ReportArea;[xShell_Reports:54]xReportData_:29)
				
			: (vtQR_CurrentReportType="gSR2")
				xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
				$err:=SR Set Area (xReportData;xSR_ReportBlob)
				REDRAW WINDOW:C456
				
			: (vtQR_CurrentReportType="4DWR")
				If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
					WR BLOB TO AREA:P12000:142 (xWrite;[xShell_Reports:54]xReportData_:29)
				End if 
				
			: (vtQR_CurrentReportType="4DVW")
				If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
					PV BLOB TO AREA:P13000:13 (xView;[xShell_Reports:54]xReportData_:29)
				End if 
				
		End case 
	: (bOpenDoc=1)
		Case of 
			: (vtQR_CurrentReportType="4DSE")
				$ref:=Open document:C264("";"4DSE")
				If (OK=1)
					CLOSE DOCUMENT:C267($ref)
					DOCUMENT TO BLOB:C525(document;$blob)
					QR BLOB TO REPORT:C771(xQR_ReportArea;$blob)
				End if 
				
			: (vtQR_CurrentReportType="gSR2")
				$err:=SR Load Report (xReportData;"")
				If ($err=0)
					$document:=SR Document (xReportData;document)
					$err:=SR Get Area (xReportData;xSR_ReportBlob)
					$err:=SR Menu Item (xReportData;2;104;"";0;0;"")
				End if 
				
			: (vtQR_CurrentReportType="4DWR")
				WR OPEN DOCUMENT:P12000:48 (xWrite;"")
				
			: (vtQR_CurrentReportType="4DVW")
				PV OPEN DOCUMENT:P13000:37 (xView;"";0)
				
				
				
		End case 
End case 

