//%attributes = {}
  // MNU_Register()
  // Por: Alberto Bachler K.: 12-10-14, 10:23:34
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



XS_MapeoTablas_AppColegio 


SET MENU BAR:C67("XS_Edicion")
DISABLE MENU ITEM:C150(1;0)
WDW_OpenFormWindow (->[Colegio:31];"wzd_Install";0;4;__ ("Asistente para la configuración de SchoolTrack"))
FORM SET INPUT:C55([Colegio:31];"wzd_Install")

vb_CreacionBD:=False:C215
ALL RECORDS:C47([Colegio:31])
If (Records in selection:C76([Colegio:31])=0)
	ADD RECORD:C56([Colegio:31];*)
Else 
	READ WRITE:C146([xShell_ApplicationData:45])
	ALL RECORDS:C47([xShell_ApplicationData:45])
	FIRST RECORD:C50([xShell_ApplicationData:45])
	READ WRITE:C146([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	MODIFY RECORD:C57([Colegio:31];*)
End if 
CLOSE WINDOW:C154
KRL_ReloadAsReadOnly (->[Colegio:31])
KRL_ReloadAsReadOnly (->[xShell_ApplicationData:45])
