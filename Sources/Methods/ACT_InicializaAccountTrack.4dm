//%attributes = {}
  //ACT_InicializaAccountTrack

HIDE PROCESS:C324(<>Splash)
ACTcc_InitVariables 
ACTinit_FormArraysDeclarations 
BRING TO FRONT:C326(Current process:C322)
If (Size of array:C274(<>alXS_RegisteredProcessIDs)=1)
	btnText:="Salir"
Else 
	btnText:="Cancelar"
End if 
  //20111012 AS. se elimina la ventana para los intereses por petición de IMP
  //WDW_OpenFormWindow (->[xxSTR_Constants];"ACT_InitOptions";0;5;__ ("Inicialización de AccountTrack"))
  //DIALOG([xxSTR_Constants];"ACT_InitOptions")
  //CLOSE WINDOW

iResult:=CD_Dlog (0;__ ("Se dará comienzo a la inicialización de AccountTrack.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))

If (iResult=1)
	  //20111012 AS. se deja por defecto que las cuentas y los apoderados sean afecto a intereses.
	C_REAL:C285(cbCtasAfectasInteres;cbApdosAfectosInteres)
	cbCtasAfectasInteres:=1
	cbApdosAfectosInteres:=1
	USR_SetModuleSemaphore 
	PREF_Set (0;"ACT_Inicializado";"1")
	ACTcfg_CreateDefaultPrefs 
	MESSAGES OFF:C175
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=Nivel_AdmissionTrack;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<Nivel_Egresados)
	ARRAY LONGINT:C221($aRecNumAlumnos;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNumAlumnos;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando cuentas corrientes..."))
	For ($i;1;Size of array:C274($aRecNumAlumnos))
		GOTO RECORD:C242([Alumnos:2];$aRecNumAlumnos{$i})
		ACTcc_CreaCuentaCorriente (True:C214)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNumAlumnos))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	UNLOAD RECORD:C212([Alumnos:2])
	ACTinit_CalcNoCargasYOrdenaCtas 
	If (cbApdosAfectosInteres=1)
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ WRITE:C146([Personas:7])
		ALL RECORDS:C47([ACT_CuentasCorrientes:175])
		KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9;__ ("Buscando apoderados de cuenta..."))
		$procID:=IT_UThermometer (1;0;__ ("Marcando apoderados de cuenta como afectos a intereses..."))
		0xDev_AvoidTriggerExecution (True:C214)
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_AfectoIntereses:64:=True:C214)
		0xDev_AvoidTriggerExecution (False:C215)
		KRL_UnloadReadOnly (->[Personas:7])
		IT_UThermometer (-2;$procID)
	End if 
	SQ_EstableceSecuencia (->[xxACT_Items:179]ID:1;0)
	ACTwtrf_LoadLibrary 
	USR_ClearModuleSemaphore 
	CD_Dlog (0;__ ("AccountTrack terminó de inicializarse.\rUtilice las opciones de Configuración para configurar su sistema."))
	REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
	KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
	SHOW PROCESS:C325(<>Splash)
Else 
	If (Size of array:C274(<>alXS_RegisteredProcessIDs)=1)
		QUIT 4D:C291
	End if 
End if 