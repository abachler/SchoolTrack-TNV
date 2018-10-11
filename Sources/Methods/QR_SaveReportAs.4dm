//%attributes = {}
  // QR_SaveReportAs()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 12:32:41
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_IdInforme;$l_recNum;$l_recNumTemp;$l_refIcon;$l_tabla)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_nombreInforme)

If (False:C215)
	C_LONGINT:C283(QR_SaveReportAs ;$1)
	C_LONGINT:C283(QR_SaveReportAs ;$2)
	C_LONGINT:C283(QR_SaveReportAs ;$3)
End if 

$l_recNumTemp:=vlQR_ReportRecNum
$l_tabla:=vlQR_SRMainTable

WDW_OpenFormWindow (->[xShell_Reports:54];"SaveReport";-1;8;__ ("Guardar informe como…");"WDW_Close")
DIALOG:C40([xShell_Reports:54];"SaveReport")
CLOSE WINDOW:C154

If (bSaveDocument=1)
	USR_RegisterUserEvent (UE_ReportCreation;vlBWR_SelectedTableRef;[xShell_Reports:54]ReportName:26+";"+[xShell_Reports:54]ReportType:2)
	
	  //[xShell_Reports]DTS_UltimaModificacion:=""  //inicializo la fecha de modificación para forzar actualización en el trigger
	Case of 
		: (vtQR_CurrentReportType="gSR2")
			SR_SaveReport (xReportData;"")
			
		: (vtQR_CurrentReportType="4DSE")
			$h_refDocumento:=Create document:C266("";"4DSE")
			If (ok=1)
				CLOSE DOCUMENT:C267($h_refDocumento)
				QR REPORT TO BLOB:C770(xQR_ReportArea;$x_blob)
				BLOB TO DOCUMENT:C526(document;$x_blob)
				  //se agrega el informe a la lista de Informes en Columnas
				$l_IdInforme:=[xShell_Reports:54]ID:7
				$t_nombreInforme:=[xShell_Reports:54]ReportName:26
				$l_refIcon:=Use PicRef:K28:4+27514
				APPEND TO LIST:C376(hl_Reports_QR;$t_nombreInforme;$l_IdInforme)
				SET LIST ITEM PROPERTIES:C386(hl_Reports_QR;$l_IdInforme;True:C214;0;$l_refIcon)
				SORT LIST:C391(hl_Reports_QR;>)
			End if 
			
			
		: (vtQR_CurrentReportType="4DWR")
	End case 
End if 

vlQR_ReportRecNum:=$l_recNumTemp



