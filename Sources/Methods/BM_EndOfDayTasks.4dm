//%attributes = {"executedOnServer":true}
  //BM_EndOfDayTasks()
  // Por: Alberto Bachler K.: 15-04-15, 14:56:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($d_ultimoInicioDiario)
C_LONGINT:C283($l_estadoProceso;$l_numeroProceso;$l_pausaEntreEjecucion)

C_TIME:C306($l_ultimoSyncTest;$l_ultimoConteoRegistros)

C_BOOLEAN:C305(<>stopDaemons;<>b_sincronizar)

MESSAGES OFF:C175
dhBM_Initialisations 

vsBWR_CurrentModule:="Procesador de tareas"
GET PICTURE FROM LIBRARY:C565("Module SchoolTrack";vpXS_IconModule)


$d_ultimoInicioDiario:=Current date:C33(*)
$l_pausaEntreEjecucion:=1*60*60  // 1 minuto
$l_ultimoConteoRegistros:=0

$l_ultimoSyncTest:=0
$time2Wait:=(Random:C100%(900000-600000+1))+600000
$d_fechaSesion:=Date:C102(PREF_fGet (0;"CreacionDeSesiones"))

$h_timeSesiones:=Current time:C178(*)
$d_diaSesiones:=Current date:C33(*)

KRL_UnloadAll 
While (Not:C34(<>stopDaemons))
	READ ONLY:C145(*)
	LOG_LimpiaLog 
	
	If (Current date:C33(*)>$d_ultimoInicioDiario)
		dhBM_TareasInicioDiario 
		KRL_UnloadAll 
		$d_ultimoInicioDiario:=Current date:C33(*)
	End if 
	
	  //If ((Milliseconds-$l_ultimoConteoRegistros)>60000)//JHB 20170313 Por problema con milliseconds que solo cuentas hasta MAXLONG
	If ($l_ultimoConteoRegistros=0)
		CIM_CuentaRegistros ("GuardaArchivo")
		$l_ultimoConteoRegistros:=Current time:C178
	Else 
		If (UTIL_TimeDiff ($l_ultimoConteoRegistros)>60000)
			CIM_CuentaRegistros ("GuardaArchivo")
			$l_ultimoConteoRegistros:=Current time:C178
		End if 
	End if 
	
	  //If ((Milliseconds-$l_ultimoSyncTest)>$time2Wait)//JHB 20170313 Por problema con milliseconds que solo cuentas hasta MAXLONG
	If ($l_ultimoSyncTest=0)
		SyncPG_ActualizaDiccionario 
		$l_ultimoSyncTest:=Current time:C178
	Else 
		If (UTIL_TimeDiff ($l_ultimoSyncTest)>$time2Wait)
			SyncPG_ActualizaDiccionario 
			$l_ultimoSyncTest:=Current time:C178
		End if 
	End if 
	
	If (<>b_sincronizar)
		$l_numeroProceso:=Process number:C372("Condor Sync")
		$l_estadoProceso:=Process state:C330($l_numeroProceso)
		If ($l_estadoProceso<Executing:K13:4)
			$l_numeroProceso:=New process:C317("SyncPG_SincronizaDatos";Pila_1024K;"Condor Sync";*)
		Else 
			RESUME PROCESS:C320($l_numeroProceso)
		End if 
	End if 
	
	  //If ((Current date(*)>$d_diaSesiones) & ($h_timeSesiones>=?05:00:00?))
	If ((Current date:C33(*)>$d_diaSesiones) & (Current time:C178(*)>=?05:00:00?))  //20180531 RCH Ticket 208327
		$processID:=ST_EjecutaProcesoServidor ("dbu_CreaSesiones";"CreacionDeSesiones")
		$d_diaSesiones:=Current date:C33(*)
	End if 
	
	DELAY PROCESS:C323(Current process:C322;$l_pausaEntreEjecucion)
End while 