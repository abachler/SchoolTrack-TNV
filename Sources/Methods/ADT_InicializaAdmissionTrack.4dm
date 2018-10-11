//%attributes = {}
  //ADT_InicializaAdmissionTrack

HIDE PROCESS:C324(<>Splash)
BRING TO FRONT:C326(Current process:C322)
If (Size of array:C274(<>alXS_RegisteredProcessIDs)=1)
	$r:=CD_Dlog (0;__ ("Esta es la primera vez que el módulo AdmissionTrack es utilizado.\r\rAdmissionTrack creará ahora las preferencias por defecto.");__ ("");__ ("Continuar");__ ("Salir"))
Else 
	$r:=CD_Dlog (0;__ ("Esta es la primera vez que el módulo AdmissionTrack es utilizado.\r\rAdmissionTrack creará ahora las preferencias por defecto.");__ ("");__ ("Continuar");__ ("Cancelar"))
End if 
If ($r=1)
	USR_SetModuleSemaphore 
	PST_ReadParameters 
	ADT_CreateDefaultPrefs 
	PST_SaveParameters 
	
	PREF_Set (0;"ADT_Inicializado";"1")
	CD_Dlog (0;__ ("AdmissionTrack terminó de inicializarse.\rUtilice las opciones de Configuración para configurar su sistema."))
	USR_ClearModuleSemaphore 
	SHOW PROCESS:C325(<>Splash)
Else 
	If (Size of array:C274(<>alXS_RegisteredProcessIDs)=1)
		QUIT 4D:C291
	End if 
End if 

_O_C_INTEGER:C282($admissionTrackIsInitialized)
$admissionTrackIsInitialized:=Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))
