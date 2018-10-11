//%attributes = {}
  // Método: dhBM_VerificaEjecucionTareas
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 28-10-10, 09:43:42
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //dhBM_VerificaEjecucionTareas

C_DATE:C307($vd_lastExec;$vd_fecha1;$vd_fecha2)
C_TIME:C306($vh_hora1;$vh_hora2)
C_LONGINT:C283($vl_pid)
C_TEXT:C284($vtXS_DTSInicioTareas;$domaine;$userName)
C_BOOLEAN:C305($vb_alertar)
C_LONGINT:C283($error;$vl_pref;$vl_prefActivada)
C_TEXT:C284($vt_procName)

ARRAY TEXT:C222($atXS_netInfo;0)

$vl_prefActivada:=Num:C11(PREF_fGet (0;"XS_VerificacionTIDActivada";"1"))  //por si en algun momento se necesita desactivar esta opcion...
  //PREF_Set (0;"XS_VerificacionTIDActivada";"0")  `desactiva validacion
If ($vl_prefActivada=1)
	
	If (SYS_IsWindows )
		$error:=sys_GetNetworkInfo ($networkInfo)
		AT_Text2Array (->$atXS_netInfo;$networkInfo;",")
		$domaine:=$atXS_netInfo{2}
	Else 
		$domaine:=""
	End if 
	$userName:=Current system user:C484
	$vt_procName:="End of the day tasks"
	$vtXS_DTSInicioTareas2:=DTS_MakeFromDateTime 
	$vt_module:="Procesador de tareas"
	
	If (($domaine="lester.colegium.com") | (Not:C34(Is compiled mode:C492)))
	Else 
		$vd_lastExec:=DTS_GetDate (PREF_fGet (0;"lastEndOfTheDayExec";"00000000000000"))
		If ($vd_lastExec#Current date:C33(*))
			$vl_pid:=Process number:C372($vt_procName;*)
			If ($vl_pid#0)
				GET PROCESS VARIABLE:C371($vl_pid;<>vtXS_DTSInicioTareas;$vtXS_DTSInicioTareas)
				If ($vtXS_DTSInicioTareas#"")  //si esta vacio asumimos que esta correcto...
					$vd_fecha1:=DTS_GetDate ($vtXS_DTSInicioTareas)
					$vd_fecha2:=DTS_GetDate ($vtXS_DTSInicioTareas2)
					$vh_hora1:=DTS_GetTime ($vtXS_DTSInicioTareas)
					$vh_hora2:=DTS_GetTime ($vtXS_DTSInicioTareas2)
					If ($vd_fecha1=$vd_fecha2)
						If ($vh_hora2-$vh_hora1>?07:00:00?)
							$vb_alertar:=True:C214
						End if 
					Else 
						$vb_alertar:=True:C214
					End if 
				Else 
					  //ojo que se pueden estar abriendo bases de datos de datos historicas
				End if 
			Else 
				$vb_alertar:=True:C214
			End if 
		Else 
			  //$vb_alertar:=True si son iguales no hay problema
		End if 
		
		If ($vb_alertar)
			$vl_pref:=Num:C11(PREF_fGet (0;"XS_VerificacionTareasInicioDia;"+Substring:C12(DTS_MakeFromDateTime ($vd_lastExec);1;8);"0"))
			If ($vl_pref=0)
				PREF_Set (0;"XS_VerificacionTareasInicioDia;"+Substring:C12(DTS_MakeFromDateTime ($vd_lastExec);1;8);"1")
				C_TEXT:C284($vt_msg;$vt_module;$message;$to)
				C_LONGINT:C283($i;$vl_resultado)
				ARRAY LONGINT:C221($alXS_recNums;0)
				
				READ ONLY:C145([xShell_Logs:37])
				QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3>$vd_lastExec;*)
				QUERY:C277([xShell_Logs:37]; & ;[xShell_Logs:37]Module:8=$vt_module)
				
				ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
				LONGINT ARRAY FROM SELECTION:C647([xShell_Logs:37];$alXS_recNums;"")
				
				$vt_msg:="Las tareas de inicio de día no fueron ejecutadas correctamente durante la madruga"+"da del día de hoy. Es necesario revisar la base de datos de su colegio. Por favor"+" deje un respaldo actualizado de su base de datos en el carpeta ftp de su colegio."+"\r"+"Ruta Base de datos actualmente utilizada: "+SYS_GetDataPath 
				vsBWR_CurrentModule:="SchoolTrack"
				$To:="soporte@colegium.com"
				$message:=$vt_msg+"\r\r"
				$message:=$message+"Detalle del registro de actividades del módulo "+ST_Qte ($vt_module)+", para el día de hoy: "+String:C10(Size of array:C274($alXS_recNums))+" evento(s):"+"\r\r"
				
				For ($i;1;Size of array:C274($alXS_recNums))
					GOTO RECORD:C242([xShell_Logs:37];$alXS_recNums{$i})
					$message:=$message+String:C10([xShell_Logs:37]Event_Time:4)+"\t"+[xShell_Logs:37]Event_Description:5+"."+"\r"
					If (Length:C16($message)>30000)
						$message:=$message+ST_Boolean2Str ($vl_pid#0;"Proceso "+ST_Qte ($vt_procName)+" en ejecución."+"\r";"Proceso "+ST_Qte ($vt_procName)+" no existe.")
						$message:=$message+"..."
						$i:=Size of array:C274($alXS_recNums)
					End if 
				End for 
				If (Length:C16($message)<=30000)
					$message:=$message+ST_Boolean2Str ($vl_pid#0;"Proceso "+ST_Qte ($vt_procName)+" en ejecución."+"\r";"Proceso "+ST_Qte ($vt_procName)+" no existe.")
				End if 
				
				$vl_resultado:=SOPORTE_EnviaMailIncidente ($To;$message;"D")
				LOG_RegisterEvt ("¡¡¡¡¡   ATENCIÓN   !!!!!"+"\r\r"+$vt_msg)
				CD_Dlog (0;$vt_msg)
				
			End if 
		End if 
		
	End if 
End if 
