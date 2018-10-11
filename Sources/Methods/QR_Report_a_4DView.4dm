//%attributes = {}
  // Método: QR_Report_a_4DView
  //
  // 
  // creado por Alberto Bachler Klein
  // el 22/02/18, 10:35:16
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_POINTER:C301($y_tabla)

dhQR_PrePrintInstructions 
ok:=1
If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#Table:C252(yBWR_currentTable)))
	$y_tabla:=Table:C252([xShell_Reports:54]RelatedTable:14)
	If ([xShell_Reports:54]SourceField:13#0)
		vyQR_StartField:=Field:C253([xShell_Reports:54]MainTable:3;[xShell_Reports:54]SourceField:13)
	End if 
	If ([xShell_Reports:54]RelatedField:15#0)
		vyQR_EndField:=Field:C253([xShell_Reports:54]RelatedTable:14;[xShell_Reports:54]RelatedField:15)
	End if 
Else 
	$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
End if 
OK:=QR_SetUnivers ([xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14)
If (OK=1)
	If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	End if 
End if 

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
MESSAGES ON:C181
If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
	GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	
	$l_refArea:=QR New offscreen area:C735
	QR BLOB TO REPORT:C771($l_refArea;[xShell_Reports:54]xReportData_:29)
	QR SET REPORT TABLE:C757($l_refArea;Choose:C955([xShell_Reports:54]RelatedTable:14=0;[xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14))  //20161014 ASM Ticket 169372
	QR SET DESTINATION:C745($l_refArea;qr 4D View area:K14903:3)
	QR RUN:C746($l_refArea)
	$l_refArea4DView:=Frontmost window:C447
	SET WINDOW TITLE:C213([xShell_Reports:54]ReportName:26;Frontmost window:C447)
	SET WINDOW RECT:C444($l_izquierda+20;$l_arriba+20;$l_derecha-20;$l_abajo-20;Frontmost window:C447)
	
End if 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
MESSAGES OFF:C175

