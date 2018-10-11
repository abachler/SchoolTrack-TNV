//%attributes = {}
  //QR_EditSuperReportTemplate

C_POINTER:C301($tablePointer)
READ ONLY:C145(*)
MESSAGES ON:C181

dhQR_PrePrintInstructions 
ok:=1
If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#Table:C252(yBWR_currentTable)))
	$tablePointer:=Table:C252([xShell_Reports:54]RelatedTable:14)
	If ([xShell_Reports:54]SourceField:13#0)
		vyQR_StartField:=Field:C253([xShell_Reports:54]MainTable:3;[xShell_Reports:54]SourceField:13)
	End if 
	If ([xShell_Reports:54]RelatedField:15#0)
		vyQR_EndField:=Field:C253([xShell_Reports:54]RelatedTable:14;[xShell_Reports:54]RelatedField:15)
	End if 
Else 
	$tablePointer:=Table:C252(Abs:C99([xShell_Reports:54]MainTable:3))
End if 
OK:=QR_SetUnivers (Abs:C99([xShell_Reports:54]MainTable:3);Abs:C99([xShell_Reports:54]RelatedTable:14))


If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
	EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
	  //$t_input:="<!--#4DCODE\r"+[xShell_Reports]ExecuteBeforePrinting+"\r-->"
	  //PROCESS 4D TAGS($t_input;$t_output)
End if 
MESSAGES ON:C181

If (ok=1)
	vlSR_RegXPagina:=[xShell_Reports:54]RegistrosXPagina:44
	vtQR_CurrentReportName:=[xShell_Reports:54]ReportName:26
	MNU_SetMenuBar ("XS_ReportEditor")
	WDW_OpenFormWindow (->[xShell_Reports:54];"SuperReportEditor";-1;8;vtQR_CurrentReportName)
	DIALOG:C40([xShell_Reports:54];"SuperReportEditor")
	CLOSE WINDOW:C154
End if 

MESSAGES OFF:C175
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)


