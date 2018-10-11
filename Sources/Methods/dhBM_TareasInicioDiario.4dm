//%attributes = {}
  // dhBM_TareasInicioDiario()
  // Por: Alberto Bachler K.: 29-08-14, 09:16:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)

C_BLOB:C604($x_blobVacio)
C_BOOLEAN:C305($b_avisaBloqueo;$b_ExecuteTasks;$b_forceExecution)
C_DATE:C307($d_fecha;$d_fechaAyer;$d_FechaHoy;$d_ultimasEjecucion)
C_LONGINT:C283($l_idProceso;$l_ms;$l_resultadoVerificacionLicencia;$l_versionBD_Build)
C_TIME:C306($h_hora)
C_TEXT:C284($t_carpetaLogs;$t_carpetaLogsInicioDiario;$t_Duracion;$t_encabezadoLog;$t_entrada;$t_errorLicencia;$t_hora;$t_parametro;$t_parametro1;$t_rutaLog)


If (False:C215)
	C_BOOLEAN:C305(dhBM_TareasInicioDiario ;$1)
End if 


  // CODIGO PRINCIPAL
If (Count parameters:C259=1)
	$b_ForceExecution:=$1
End if 

<>vtXS_DTSInicioTareas:=DTS_MakeFromDateTime 

$b_ExecuteTasks:=False:C215
$d_ultimasEjecucion:=DTS_GetDate (PREF_fGet (0;"lastEndOfTheDayExec";"00000000000000"))
$d_FechaHoy:=Current date:C33(*)
If (($d_ultimasEjecucion<$d_FechaHoy) | ($b_forceExecution) | ((Macintosh option down:C545 | Windows Alt down:C563) & (Shift down:C543) & (Application type:C494#4D Server:K5:6)))
	Case of 
		: ((Macintosh option down:C545 | Windows Alt down:C563) & (Shift down:C543) & (Application type:C494#4D Server:K5:6))
			Case of 
				: (Application type:C494=4D Remote mode:K5:5)
					$b_ExecuteTasks:=False:C215
					$l_idProceso:=Execute on server:C373("dhBM_TareasInicioDiario";Pila_1024K;"Tareas de fin de día (ejecución forzada)";True:C214)
				: (Application type:C494=4D Local mode:K5:1)
					$b_ExecuteTasks:=True:C214
			End case 
			
		: ((Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1))
			If ((<>lUSR_CurrentUserID>0) | (IT_AltKeyIsDown ))
				If ($d_ultimasEjecucion<$d_FechaHoy)
					CD_Dlog (0;__ ("SchoolTrack efectúa durante la noche una serie de tareas de verificación de datos. Estas tareas no pudieron ser ejecutadas durante la última noche porque su computador estaba apagado. SchoolTrack hará ahora la verificación, pero usted podrá cont"+"inua"+"trabajando normalmente.\r\rLe recomendamos mantener su computador encendido si no desea que éstas tareas se hagan al iniciar la aplicación."))
				End if 
				$b_ExecuteTasks:=True:C214
			Else 
				$b_ExecuteTasks:=False:C215
			End if 
			
		: (Application type:C494=4D Server:K5:6)
			If (((Current time:C178(*)>=?00:00:00?) & (Current time:C178(*)<?07:00:00?)) | ($b_ForceExecution))
				$b_ExecuteTasks:=True:C214
			Else 
				$b_ExecuteTasks:=False:C215
				LOG_RegisterEvt ("El servidor fue iniciado después de las 07:00\rLas tareas de fin de día no se ejecutaron para no afectar las operación diaria.")
			End if 
			
	End case 
Else 
	$b_ExecuteTasks:=False:C215
End if 


If ($b_ExecuteTasks)
	$t_carpetaLogs:=Get 4D folder:C485(Logs folder:K5:19)
	$t_rutaLog:=$t_carpetaLogs+"Tareas de inicio diario "+String:C10(Year of:C25(Current date:C33(*));"0000")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")+"-"+String:C10(Milliseconds:C459)+".txt"
	vh_refLog:=Create document:C266($t_rutaLog;"TEXT")
	If (OK=1)
		$t_encabezadoLog:="Inicio de tareas de fin de día\rBase de datos: "+SYS_GetDataPath +"\rSchoolTrack "+SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)
		dhBM_EjecutaTarea ("";$t_encabezadoLog)
		
		  // numeros de secuencia
		dhBM_EjecutaTarea ("SQ_SetSequences";"Verificación de la tabla de números de secuencia")
		dhBM_EjecutaTarea ("SQ_CargaDatos";"Lectura de la tabla de números secuenciales")
		
		  // Verifica cantidad de registros tabla colegio
		dhBM_EjecutaTarea ("COL_VerificaRegistroColegio";"Verificación de registro de tabla colegio")
		
		
		
		  //20140911 reeemplazo del método llamado anteriormente para 
		ACT_TareasInicioDiario 
		
		
		
		  // *****   MEDIATRACK  *****
		  // actualización de la duración de prestamos
		dhBM_EjecutaTarea ("BBLci_CalcLoansOverdue";"MediaTrack: Contabilización de días de préstamos items de biblioteca")
		  // eliminación de reservas vencidas
		dhBM_EjecutaTarea ("BBLdbu_EliminaReservasVencidas";"MediaTrack: eliminacion de reservas vencidas")
		
		  // generación estadísticas de circulacion biblioteca
		If (False:C215)
			  //ABK 20140830 normalmente no debiera ser necesario ejecutar este método en las tareas de fin día
			  //lo desactivo a contar de esta fecha ya que su ejecución puede tomar mucho tiempo
			  // a monitorear
			dhBM_EjecutaTarea ("BBLdbu_RebuildStatistics";"MediaTrack: Generación de estadísticas de circulación")
		End if 
		
		  // *****   SCHOOLTRACK  *****
		  // cración de sesiones de clases
		dhBM_EjecutaTarea ("dbu_CreaSesiones";"Creación de sesiones de clases")
		
		  // verificación de consistencia de nombres de asignaturas
		dhBM_EjecutaTarea ("DBU_VerifNombresAsigEnCalificac";"Verificación de nombres de asignaturas en tabla calificaciones")
		
		  // verificación de propiedades de donsolidación de asignaturas
		dhBM_EjecutaTarea ("dbu_VerificaConsolidaciones";"Verificación de propiedades de consolidación de asignaturas")
		
		  // asignación de números de folio
		dhBM_EjecutaTarea ("AL_AsignaNoDeFolio";"Asignación de números de folio")
		
		  // calculo de situacion final de alumnos
		$b_avisaBloqueo:=False:C215
		dhBM_EjecutaTarea ("dbu_CalculaSituacionFinal";"Cálculo de situación final de alumnos";->$x_blobVacio;->$b_avisaBloqueo)
		
		  // calculo de los rankings de alumnos
		dhBM_EjecutaTarea ("AL_Rankings";"Calculo de rankings de alumnos")
		
		  // calculo de promedios de los cursos
		dhBM_EjecutaTarea ("dbu_CalculaPromediosCursos";"Calculo de Promedios generales de cursos")
		
		  // contabilizacion de alumnos en familias, cursos y asignaturas
		dhBM_EjecutaTarea ("dbu_CountFamilyStudents";"Verificación de contadores de alumnos en Familias")
		dhBM_EjecutaTarea ("dbu_CountClassStudents";"Verificación de contadores de alumnos en Cursos")
		dhBM_EjecutaTarea ("dbu_CountSubjectStudents";"Verificación de contadores de alumnos en Asignaturas")
		
		  // verificación de subasignaturas
		dhBM_EjecutaTarea ("Diag_VerificaSubasignaturas";"Verificación de subasignaturas")
		
		
		  // cuenta horas de clases semanales, Ticket Nº 180337 - Saúl Ponce
		dhBM_EjecutaTarea ("dbu_CuentaHorasDeClase";"Contabilizando horas de clases semanales")
		
		  // *****   ESTADISTICAS DE USO  *****
		  //envio de información de computadores
		dhBM_EjecutaTarea ("WSout_EnviaInfoMaquinas";"Informacion de maquinas enviada")
		
		  // envía estadísticas de uso a la intranet
		$d_fechaAyer:=Current date:C33-1
		dhBM_EjecutaTarea ("XSstat_EnviaUsoSchoolTrack";"Envío de información de uso";->$d_FechaAyer)
		
		
		
		
		  // *****   SCHOOLNET  *****
		  // Verificacion de integrida para Schoolnet3
		dhBM_EjecutaTarea ("SN3_VerificadorIntegridad";"Verificación de integridad SN")
		
		dhBM_EjecutaTarea ("SN3_ActuaDatos_EndDayTask";"Envío de información de actualizaciones pendientes (SN3)")
		  //mono SN3 actualización de datos: llamados a webservices para avisos de  actualizaciones pendientes
		
		  // limpieza log SN3
		dhBM_EjecutaTarea ("SN3_CleanLog";"Limpieza del log de SchoolNet")
		
		
		
		  // *****   EJECUCION DE SCRIPTS CORP  *****
		  // actualización de Scripts activados en la intranet
		dhBM_EjecutaTarea ("CORP_Create_and_Update_Scripts";"CORP. Actualización scripts activos")
		  // Ejecución de Scripts activados en la intranet
		dhBM_EjecutaTarea ("CORP_Check_and_Execute_Scripts";"CORP. Ejecución de scripts activos")
		
		
		
		  // *****   COMMTRACK  *****
		$t_parametro:="CMT_EliminaMarcasRegistrosFinDeDia"
		dhBM_EjecutaTarea ("CMT_RegistrosMarcados";"CommTrack. Tareas de fin de día";->$t_parametro)
		dhBM_EjecutaTarea ("CT_DeleteLog";"Eliminando registro de actividades obsoleto de Commtrack")
		
		  //verificacion sync
		dhBM_EjecutaTarea ("SYNC_VerificaRegistrosMod";"Verificación sync")  //20170311 RCH
		
		dhBM_EjecutaTarea ("STWA2_EliminaPdfInformesLCD";"Eliminación de informes LCD")
		
		dhBM_EjecutaTarea ("ST_EliminaRelacionArchivoFisico";"Eliminación de registros lógicos de archivos fisicos eliminados manualmente")  //ASM 20180723 ticket 212298
		
		  // verificación de la licencia
		$l_ms:=Milliseconds:C459
		SEND PACKET:C103(vh_refLog;String:C10(Current time:C178(*);HH MM SS:K7:1)+"\t"+"Obtención de licencia de uso")
		$t_errorLicencia:=LICENCIA_Descarga 
		If ($t_errorLicencia="")
			$l_resultadoVerificacionLicencia:=LICENCIA_Verifica (False:C215)
			Case of 
				: ($l_resultadoVerificacionLicencia=1)
					$t_Duracion:=String:C10(Milliseconds:C459-$l_ms)+"ms"
					SEND PACKET:C103(vh_refLog;": "+$t_Duracion+"."+"\r\n")
				: ($l_resultadoVerificacionLicencia=-1)
					$t_Duracion:=String:C10(Milliseconds:C459-$l_ms)+"ms"
					SEND PACKET:C103(vh_refLog;": "+__ ("La licencia es inválida o no corresponde al computador en que está instalada la aplicación: ")+$t_Duracion+"."+"\r\n")
				: ($l_resultadoVerificacionLicencia=-2)
					$t_Duracion:=String:C10(Milliseconds:C459-$l_ms)+"ms"
					SEND PACKET:C103(vh_refLog;": "+__ ("Licencia vencida: ")+$t_Duracion+"."+"\r\n")
				: ($l_resultadoVerificacionLicencia=-3)
					$t_Duracion:=String:C10(Milliseconds:C459-$l_ms)+"ms"
					SEND PACKET:C103(vh_refLog;": "+__ ("La licencia no es valida para el identificador de la institución: ")+$t_Duracion+"."+"\r\n")
			End case 
		Else 
			$t_Duracion:=String:C10(Milliseconds:C459-$l_ms)+"ms"
			SEND PACKET:C103(vh_refLog;String:C10(Current time:C178(*);HH MM SS:K7:1)+"\t"+"La licencia no pudo ser leida a causa del error: \""+$t_errorLicencia+"\""+": "+$t_Duracion+"."+"\r\n")
		End if 
		
		
		
		SEND PACKET:C103(vh_refLog;String:C10(Current time:C178(*);HH MM SS:K7:1)+"\t"+"Finalización de tareas de inicio de día."+"\r\n")
		PREF_Set (0;"lastEndOfTheDayExec";DTS_MakeFromDateTime ($d_FechaHoy))
		
		
		
		
		
		SEND PACKET:C103(vh_refLog;"EOF"+"\r\n")
		
		CLOSE DOCUMENT:C267(vh_refLog)
		
		XSusr_ListaSuperUsuarios_in 
		
		
		  // integro el log al registro de actividades
		vh_refLog:=Open document:C264($t_rutaLog)
		RECEIVE PACKET:C104(vh_refLog;$t_entrada;"\r\n")
		Repeat 
			If ($t_entrada#"")
				$d_fecha:=$d_FechaHoy
				$t_hora:=ST_GetWord ($t_entrada;1;"\t")
				$h_hora:=Time:C179($t_hora)
				$t_entrada:=ST_GetWord ($t_entrada;2;"\t")
				CREATE RECORD:C68([xShell_Logs:37])
				[xShell_Logs:37]UserName:2:="Procesador de Tareas"
				[xShell_Logs:37]Event_Date:3:=$d_fecha
				[xShell_Logs:37]Event_Time:4:=$h_hora
				[xShell_Logs:37]Event_Description:5:=$t_entrada
				[xShell_Logs:37]Module:8:="Tareas de fin de día"
				SAVE RECORD:C53([xShell_Logs:37])
			End if 
			RECEIVE PACKET:C104(vh_refLog;$t_entrada;"\r\n")
		Until ($t_entrada="EOF")
		UNLOAD RECORD:C212([xShell_Logs:37])
		CLOSE DOCUMENT:C267(vh_refLog)
		
		
		
	End if 
End if 

<>vtXS_DTSInicioTareas:=""
