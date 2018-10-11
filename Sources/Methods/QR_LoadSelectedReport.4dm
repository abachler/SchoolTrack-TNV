//%attributes = {}
  //QR_LoadSelectedReport

C_BOOLEAN:C305($reportIsAllowed)
C_LONGINT:C283($icon)
$selectedItem:=Selected list items:C379(hl_informes)
If (($selectedItem>0) & (Count list items:C380(hl_informes)>=$selectedItem))
	GET LIST ITEM:C378(hl_informes;$selectedItem;$reportRecNum;$CurrentReportName)
Else 
	$reportRecNum:=Record number:C243([xShell_Reports:54])
End if 
KRL_GotoRecord (->[xShell_Reports:54];$reportRecNum)
SELECT LIST ITEMS BY REFERENCE:C630(hl_informes;$reportRecNum)
GET LIST ITEM:C378(hl_informes;$selectedItem;$reportRecNum;$CurrentReportName)
If (OK=1)
	vlQR_ReportRecNum:=Record number:C243([xShell_Reports:54])
	vtQR_CurrentReportType:=[xShell_Reports:54]ReportType:2
	vlQR_SRMainTable:=[xShell_Reports:54]MainTable:3
	Case of 
		: (vtQR_CurrentReportType="4DFO")
			vtQR_ReportType:="Informes no editables"
		: (vtQR_CurrentReportType="gSR2")
			vtQR_ReportType:="SuperReport"
		: (vtQR_CurrentReportType="4DSE")
			vtQR_ReportType:="Informes en Columnas"
		: (vtQR_CurrentReportType="4DET")
			vtQR_ReportType:="Etiquetas"
		: (vtQR_CurrentReportType="4DWR")  //20151110 ASM Ticket 152395
			vtQR_ReportType:="4D Write"
	End case 
	
	OBJECT SET ENABLED:C1123(*;"edit";([xShell_Reports:54]ReportType:2#"4DFO"))
	
	
	C_TEXT:C284($t_blob)
	$l_offset:=0
	$l_size:=BLOB size:C605([xShell_Reports:54]xReportData_:29)
	$t_blob:=BLOB to text:C555([xShell_Reports:54]xReportData_:29;UTF8 text without length:K22:17;$l_offset;$l_size)
	$t_blob:=BLOB to text:C555([xShell_Reports:54]xReportData_:29;UTF8 C string:K22:15)
	
	
	vtQR_Propietary:=__ ("Diseñado por: ")+[xShell_Reports:54]Creacion_Usuario:34+__ (" el ")+DT_FechaISO_a_FechaHora ([xShell_Reports:54]timestampISO_creacion:36)
	vtQR_Propietary:=vtQR_Propietary+"\r"+__ ("Modificado por: ")+[xShell_Reports:54]Modificacion_Usuario:39+__ (" el ")+DT_FechaISO_a_FechaHora ([xShell_Reports:54]timestampISO_modificacion:35)
	$reportIsAllowed:=QR_IsReportAllowed ([xShell_Reports:54]ID:7)
	
	If ([xShell_Reports:54]RelatedTable:14>0)
		vtQR_MainFileName:=API Get Virtual Table Name ([xShell_Reports:54]RelatedTable:14)
	Else 
		vtQR_MainFileName:=vt_QRtableVName
	End if 
	
	
Else 
	If ($selectedItem>0)
		CD_Dlog (0;__ ("No se encontró el modelo de informe."))
		REDUCE SELECTION:C351([xShell_Reports:54];0)
	End if 
End if 

OBJECT SET ENABLED:C1123(*;"ReportData_ejemplo";False:C215)
OBJECT SET ENABLED:C1123(*;"ReportData_actualizar";False:C215)


If ((bc_lookforUpdatedReport=1) & ([xShell_Reports:54]DTS_Repositorio:45#""))
	RIN_InfoExplorador ([xShell_Reports:54]UUID:47)
Else 
	OBJECT SET TITLE:C194(*;"ReportData_estadoRepositorio";"")
End if 
QR_AjustesMenu 
