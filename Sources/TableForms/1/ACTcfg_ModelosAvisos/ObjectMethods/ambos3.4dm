C_LONGINT:C283($table)

$row:=AL_GetLine (xAL_ModelosAvisos)


$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
READ WRITE:C146([xShell_Reports:54])
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosAvID{$row})
If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
	vlQR_SRMainTable:=[xShell_Reports:54]MainTable:3
	vlQR_ReportRecNum:=Record number:C243([xShell_Reports:54])
	vb_NotInReportEditor:=True:C214
	vlSR_RegXPagina:=[xShell_Reports:54]RegistrosXPagina:44
	
	QR_EditSuperReportTemplate 
	
	ACTcfg_LoadAvModels 
	AL_UpdateArrays (xAL_ModelosAvisos;-2)
	AL_SetLine (xAL_ModelosAvisos;$row)
	ACTcfg_MarkStandardAvModels 
Else 
	CD_Dlog (0;__ ("Este es el modelo estándar y no puede ser modificado. Si lo desea puede duplicar el modelo para luego modificarlo."))
	KRL_UnloadReadOnly (->[xShell_Reports:54])
End if 