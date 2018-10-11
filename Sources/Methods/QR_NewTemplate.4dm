//%attributes = {}
  // QR_NewTemplate()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 15:51:27
  // -----------------------------------------------------------
C_LONGINT:C283($l_IdInforme;$l_refFolder;$l_tabla)
C_TEXT:C284($t_nombreCarpeta)

C_LONGINT:C283(vlSR_RegXPagina)


If (vbQR_FavoritesSelected)
	vtQR_CurrentReportType:=""
	GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$l_refFolder;$t_nombreCarpeta)
End if 

$l_tabla:=QR_SelectReportMainTable 

If ($l_tabla#0)
	Case of 
		: (vtQR_CurrentReportType="4DFO")  // 4D Form
			BEEP:C151
		: (vtQR_CurrentReportType="gSR2")  // SuperReport
			If ($l_tabla#Table:C252(vyQR_tablePointer))
				QR_NewSuperReportTemplate (Table:C252($l_tabla))
			Else 
				QR_NewSuperReportTemplate 
			End if 
		: (vtQR_CurrentReportType="4DSE")  //Quick Report
			If ($l_tabla#Table:C252(vyQR_tablePointer))
				QR_NewQuickReportTemplate (Table:C252($l_tabla))
			Else 
				QR_NewQuickReportTemplate 
			End if 
		: (vtQR_CurrentReportType="4DET")  //Labels
			QR_CleanReportFolder 
			If ($l_tabla#Table:C252(vyQR_tablePointer))
				QR_NewLabelTemplate (Table:C252($l_tabla))
			Else 
				QR_NewLabelTemplate 
			End if 
		: (vtQR_CurrentReportType="4DWR")  //Labels
			If ($l_tabla#Table:C252(vyQR_tablePointer))
				QR_NewWriteTemplate (Table:C252($l_tabla))
			Else 
				QR_NewWriteTemplate 
			End if 
	End case 
	$l_IdInforme:=[xShell_Reports:54]ID:7
	
	vbQR_FavoritesSelected:=False:C215
	QR_BuildReportHList 
	If ($l_IdInforme>0)
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Informes;$l_IdInforme)
		QR_LoadSelectedReport 
	Else 
		QR_LoadSelectedReport 
	End if 
Else 
	QR_BuildReportHList 
	If ($l_refFolder=0)
		SET LIST PROPERTIES:C387(hl_Informes;2;0;18)
		QR_LoadSelectedReport 
		SELECT LIST ITEMS BY POSITION:C381(hl_FavoriteReports;Count list items:C380(hl_FavoriteReports)+1)
	Else 
		SELECT LIST ITEMS BY REFERENCE:C630(hl_FavoriteReports;$l_refFolder)
		QR_GetFolderReports 
	End if 
End if 