//%attributes = {}
  //ACT_InicializaAccountTrackServe

<>InitACT:=0
<>vlXS_CurrentModuleRef:=$1
cbCtasAfectasInteres:=$2
cbApdosAfectosInteres:=$3
ACTcc_InitVariables 
ACTinit_FormArraysDeclarations 
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
REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
<>InitACT:=1