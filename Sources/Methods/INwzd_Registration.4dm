//%attributes = {}
  //INwzd_Registration

_O_C_STRING:C293(31;vs_Periodo1;vs_Periodo2;vs_Periodo3;vs_Periodo4;vs_Periodo5)
C_DATE:C307(vd_InicioPeriodo1;vd_InicioPeriodo2;vd_InicioPeriodo3;vd_InicioPeriodo4;vd_InicioPeriodo5;vd_finPeriodo1;vd_finPeriodo2;vd_finPeriodo3;vd_finPeriodo4;vd_finPeriodo5)

SET QUERY DESTINATION:C396(0)

READ WRITE:C146([SNT_Configuration:58])
ALL RECORDS:C47([SNT_Configuration:58])
FIRST RECORD:C50([SNT_Configuration:58])
If (Records in selection:C76([SNT_Configuration:58])=0)
	CREATE RECORD:C68([SNT_Configuration:58])
	[SNT_Configuration:58]ServerAddress:1:="ftp.colegium.com"
	[SNT_Configuration:58]ServerPort:2:=21
	[SNT_Configuration:58]SchoolNet_ON:20:=False:C215
End if 

USR_CreateDefaultGroups 
USR_LoadPasswordTables 


SET MENU BAR:C67("XS_Edicion")
DISABLE MENU ITEM:C150(1;0)
WDW_OpenFormWindow (->[Colegio:31];"wzd_Install";0;4;__ ("Asistente para la configuración de SchoolTrack"))
FORM SET INPUT:C55([Colegio:31];"wzd_Install")

vb_CreacionBD:=True:C214
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
<>vb_esBaseDeDatosNueva:=False:C215
SYS_EstableceVersionBaseDeDatos 

SYS_OpenLangageResource 
IN_CreaPeriodos 
IN_LoadEvaluationStyles 
IN_LoadNiveles 
IN_LoadSubjects 
IN_LoadComunas 
IN_LoadDefaultCurriculum 
IN_CargaTextosInformesNotas 
BBlin_LoadMARCcodes 
BBLsys_LoadSystemUsers 

dhCFG_ReadAllPreferences 


KRL_ReloadAsReadOnly (->[xShell_ApplicationData:45];->[Colegio:31])
CIM_CuentaRegistros ("GuardaArchivo")




