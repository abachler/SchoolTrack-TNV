//%attributes = {}
  //QR_MakeTemplatePublic

If ((<>lUSR_CurrentUserID=[xShell_Reports:54]Propietary:9) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)))
	GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$recNum;$CurrentReportName)
	KRL_GotoRecord (->[xShell_Reports:54];$recNum;True:C214)
	If ([xShell_Reports:54]Public:8)
		[xShell_Reports:54]Public:8:=False:C215
	Else 
		[xShell_Reports:54]Public:8:=True:C214
	End if 
	SAVE RECORD:C53([xShell_Reports:54])
	KRL_ReloadAsReadOnly (->[xShell_Reports:54])
	QR_LoadSelectedReport 
End if 
