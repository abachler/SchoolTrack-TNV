//%attributes = {}
  // QR_NewSuperReportTemplate()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 12:29:06
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($l_ocultoEnExplorador)


If (False:C215)
	C_POINTER:C301(QR_NewSuperReportTemplate ;$1)
	C_BOOLEAN:C305(QR_NewSuperReportTemplate ;$2)
End if 

C_LONGINT:C283(vlQR_SRMainTable)

Case of 
	: (Count parameters:C259=2)
		$l_ocultoEnExplorador:=$2
		vyQR_tablePointer:=$1
		vlQR_SRMainTable:=(Table:C252($1))*-1
		OK:=QR_SetUnivers (Table:C252(vyQR_tablePointer);Abs:C99(vlQR_SRMainTable))
	: (Count parameters:C259=1)
		vyQR_tablePointer:=$1
		vlQR_SRMainTable:=Table:C252($1)
		OK:=QR_SetUnivers (Table:C252(vyQR_tablePointer);Abs:C99(vlQR_SRMainTable))
	Else 
		vyQR_tablePointer:=yBWR_CurrentTable
		vlQR_SRMainTable:=Table:C252(vyQR_TablePointer)
		OK:=1
End case 

If (ok=1)
	If (Undefined:C82(vlSR_RegXPagina))
		vlSR_RegXPagina:=1
	Else 
		If (vlSR_RegXPagina=0)
			vlSR_RegXPagina:=1
		Else 
			If (Not:C34($l_ocultoEnExplorador))
				vlSR_RegXPagina:=1
			End if 
		End if 
	End if 
	REDUCE SELECTION:C351([xShell_Reports:54];0)
	vlQR_ReportRecNum:=-1
	WDW_OpenFormWindow (->[xShell_Reports:54];"SuperReportEditor";-1;8)
	DIALOG:C40([xShell_Reports:54];"SuperReportEditor")
	CLOSE WINDOW:C154
End if 