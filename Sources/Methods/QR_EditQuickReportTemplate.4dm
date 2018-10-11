//%attributes = {}
  // QR_EditQuickReportTemplate()
  // 
  //
  // creado por: Alberto Bachler Klein: 08-04-16, 16:37:13
  // -----------------------------------------------------------


C_BOOLEAN:C305($b_reconstruirLista)
C_POINTER:C301($y_tabla)

C_LONGINT:C283(SRArea;SRObjectPrintRef)

SRArea:=0
SRObjectPrintRef:=0
QR_InitGenericObjects 

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

If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
	EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
End if 
MESSAGES ON:C181

If (ok=1)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QR_Editor 
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
End if 


QR_BuildReportHList 


