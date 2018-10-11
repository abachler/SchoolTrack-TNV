//%attributes = {}
  // dhBWR_ModuleInitialisations()
  // Por: Alberto Bachler: 16/11/13, 18:20:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_AccounTrackInicializado;$b_moduloIniciado)
C_LONGINT:C283($l_AccounTrackInicializado;$l_amissionTrackInicializado;$l_IdProceso)
C_TEXT:C284($t_moduloActual)
If (False:C215)
	C_TEXT:C284(dhBWR_ModuleInitialisations ;$1)
End if 

$t_moduloActual:=$1
$b_moduloIniciado:=True:C214
KRL_AllTablesReadOnly 
Case of 
	: ($t_moduloActual="SchoolTrack")  // schooltrack
		vsBWR_CurrentModule:="SchoolTrack"
		GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
		BBL_LeeConfiguracion 
		STR_LeeConfiguracion 
		  //
		
	: ($t_moduloActual="MediaTrack")  // medialtrackyBWR_currentTable:=->[BBL_Items]
		<>bMediaTrackIsRunning:=True:C214
		vsBWR_CurrentModule:="MediaTrack"
		GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
		BBL_InitVariables 
		BBL_LeeConfiguracion 
		If (USR_GetMethodAcces ("BBLci_IniciaConsola";0))
			BBLci_IniciaConsola 
		End if 
		STR_LeeConfiguracion 
		  //
		
	: ($t_moduloActual="AccountTrack")  // accountTrack
		vsBWR_CurrentModule:="AccountTrack"
		GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
		BBL_LeeConfiguracion 
		STR_LeeConfiguracion 
		If (Application type:C494=4D Remote mode:K5:5)
			$l_AccounTrackInicializado:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
			If ($l_AccounTrackInicializado=0)
				If (Size of array:C274(<>alXS_RegisteredProcessIDs)=1)
					btnText:="Salir"
				Else 
					btnText:="Cancelar"
				End if 
				WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_InitOptions";0;5;__ ("Inicialización de AccountTrack"))
				DIALOG:C40([xxSTR_Constants:1];"ACT_InitOptions")
				CLOSE WINDOW:C154
				If (iResult=1)
					$l_AccounTrackInicializado:=0
					$l_IdProceso:=Execute on server:C373("ACT_InicializaAccountTrackServe";Pila_256K;"Init ACT";vlBWR_CurrentModuleRef;cbCtasAfectasInteres;cbApdosAfectosInteres)
					$l_idProceso:=IT_UThermometer (1;0;__ ("Inicializando AccountTrack en el servidor..."))
					While ($l_AccounTrackInicializado=0)
						GET PROCESS VARIABLE:C371(-1;<>InitACT;$l_AccounTrackInicializado)
						DELAY PROCESS:C323(Current process:C322;15)
					End while 
					IT_UThermometer (-2;$l_idProceso)
					CD_Dlog (0;__ ("AccountTrack terminó de inicializarse.\rUtilice las opciones de Configuración para configurar su sistema."))
				Else 
					If (Size of array:C274(<>alXS_RegisteredProcessIDs)=1)
						QUIT 4D:C291
					End if 
				End if 
			End if 
		Else 
			If (Not:C34(ACT_AccountTrackInicializado ))
				ACT_InicializaAccountTrack 
			End if 
		End if 
		ACT_LeeConfiguracion 
		$l_AccounTrackInicializado:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
		$b_moduloIniciado:=($l_AccounTrackInicializado=1)
		<>lACT_PagosCaja:=0
		<>lACT_Documentar:=0
		<>lACT_PagosRapidos:=0
		  //
		
	: ($t_moduloActual="AdmissionTrack")  // admissionTRack STR_LeeConfiguracion 
		vsBWR_CurrentModule:="AdmissionTrack"
		GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
		BBL_LeeConfiguracion 
		STR_LeeConfiguracion 
		If (Application type:C494=4D Remote mode:K5:5)
			$l_amissionTrackInicializado:=Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))
			If ($l_amissionTrackInicializado=0)
				$l_idProceso:=Execute on server:C373("ADT_InicializaAdmissionTrackSer";Pila_256K;"Init ADT";vlBWR_CurrentModuleRef)
				$l_idProceso:=IT_UThermometer (1;0;__ ("Inicializando AdmissionTrack..."))
				While (Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))=0)
					DELAY PROCESS:C323(Current process:C322;15)
				End while 
				IT_UThermometer (-2;$l_idProceso)
				CD_Dlog (0;__ ("AdmissionTrack terminó de inicializarse.\rUtilice las opciones de Configuración para configurar su sistema."))
			End if 
		Else 
			$l_amissionTrackInicializado:=Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))
			If ($l_amissionTrackInicializado=0)
				ADT_InicializaAdmissionTrack 
			End if 
		End if 
		PST_InitVariables 
		PST_ReadParameters 
		$l_amissionTrackInicializado:=Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))
		$b_moduloIniciado:=($l_amissionTrackInicializado=1)
End case 
$0:=$b_moduloIniciado