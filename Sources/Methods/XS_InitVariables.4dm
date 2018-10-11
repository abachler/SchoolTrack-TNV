//%attributes = {}
  //XS_InitVariables

  // Inicialización de arreglos para procesos y ventanas
  //==================================
ARRAY LONGINT:C221(<>alXS_OpenWindows;0)
ARRAY TEXT:C222(<>atXS_OpenWindows;0)
ARRAY LONGINT:C221(<>alXS_OpenWindowsProcessID;0)
ARRAY TEXT:C222(<>atXS_ProcessMethod;0)
ARRAY TEXT:C222(<>atXS_ProcessName;0)
ARRAY LONGINT:C221(<>alXS_RegisteredProcessIDs;0)
ARRAY TEXT:C222(<>atXS_RegisteredProcessNames;0)

ARRAY LONGINT:C221(<>AL_TriggerFlag_aL;0)  //Este arreglo es usado por 0xDev_ALTestCallBack, metodo para controlar el doble
  //llamado al callback de los ALP.


<>nbSpace:=" "
<>lUSR_CurrentUserID:=0
<>lUSR_RelatedTableUserID:=0
<>tUSR_CurrentUser:=""
<>webServerRunning:=False:C215
<>toolBar:=0
<>stopDaemons:=False:C215
<>onServer:=False:C215
<>noLogs:=False:C215
<>vb_MsgON:=True:C214
<>vb_avoidTriggerExecution:=False:C215
<>lHelp_ProcessID:=0

<>vlXS_SpecialAuthCount:=0  //Contador de intentos de ingreso de clave de administrador usado en USR_EmergencyUser

<>gAutoFormat:=(Num:C11(PREF_fGet (0;"XS_FormatNames";"1"))=1)
<>vs_PictureFormat:=PICT_GetDefaultFormat 
<>vs_PictureFileExtension:=PICT_GetDefaultExtension 

<>vlXS_TranslatorProc:=0  //proceso de traduccion contextual

  // Creacion de arreglos desde recursos
  //==================================