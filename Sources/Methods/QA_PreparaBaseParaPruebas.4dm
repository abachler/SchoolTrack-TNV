//%attributes = {}
  //QA_PreparaBaseParaPruebas 
C_TEXT:C284($t_accion;$1)

If (Count parameters:C259>=1)
	$t_accion:=$1
End if 
If ($t_accion="")
	$t_accion:="AbreFormulario"
End if 

Case of 
	: ($t_accion="AbreFormulario")
		$l_refVentana:=Open form window:C675("QA_PreparaBDPruebas";Plain form window:K39:10;On the left:K39:2;At the top:K39:5)
		SET WINDOW TITLE:C213("Preparación de base de datos para pruebas";$l_refVentana)
		DIALOG:C40("QA_PreparaBDPruebas")
		CLOSE WINDOW:C154
		
	: ($t_accion="OnLoad")
		C_POINTER:C301($y_tareaDescripcion;$y_tareaTipo;$y_tareaID)
		
		$y_tareaDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_descripcion")
		$y_tareaTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_ejecutar")
		$y_tareaID:=OBJECT Get pointer:C1124(Object named:K67:5;"tareas_id")
		
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"Desactivar envío de datos a CommTrack")
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"Eliminar mails de toda la base de datos")
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"Eliminar mail Administrador SchoolNet")
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"Eliminar mail envío contraseñas SchoolNet")
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"Desactivar alertas AccountTrack")
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"Cambiar uuid de tablas")
		
		APPEND TO ARRAY:C911($y_tareaID->;1)
		APPEND TO ARRAY:C911($y_tareaID->;2)
		APPEND TO ARRAY:C911($y_tareaID->;3)
		APPEND TO ARRAY:C911($y_tareaID->;4)
		APPEND TO ARRAY:C911($y_tareaID->;5)
		APPEND TO ARRAY:C911($y_tareaID->;6)
		
		APPEND TO ARRAY:C911($y_tareaTipo->;True:C214)
		APPEND TO ARRAY:C911($y_tareaTipo->;True:C214)
		APPEND TO ARRAY:C911($y_tareaTipo->;True:C214)
		APPEND TO ARRAY:C911($y_tareaTipo->;True:C214)
		APPEND TO ARRAY:C911($y_tareaTipo->;True:C214)
		APPEND TO ARRAY:C911($y_tareaTipo->;True:C214)
		
	: ($t_accion="EjecutaTareas")
		
		C_POINTER:C301($y_tareaDescripcion;$y_tareaTipo;$y_tareaID)
		$y_tareaDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_descripcion")
		$y_tareaTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_ejecutar")
		$y_tareaID:=OBJECT Get pointer:C1124(Object named:K67:5;"tareas_id")
		
		C_LONGINT:C283($l_indice;$l_proc)
		If (Find in array:C230($y_tareaTipo->;True:C214)>0)
			$l_proc:=IT_UThermometer (1;0;"Ejecutando tareas")
			
			If ($y_tareaTipo->{1})  // Desactiva envio CMT
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{1}+"...")
				<>vl_CMT_OnOff:=0
				PREF_Set (0;"CMT_ONOFF";String:C10(<>vl_CMT_OnOff))
				LOG_RegisterEvt ("QA PRUEBAS: Tarea "+$y_tareaDescripcion->{1}+" ejecutada.")
			End if 
			
			If ($y_tareaTipo->{2})  //Elimina mails de la base de datos
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{2}+"...")
				C_LONGINT:C283($l_enUsoProfesores;$l_enUsoPersonas;$l_enUsoAlumnos;$l_enUsoFamilia;$l_enUsoRS;$l_enUsoUsuarios)
				
				READ WRITE:C146([Profesores:4])
				ALL RECORDS:C47([Profesores:4])
				
				0xDev_AvoidTriggerExecution (True:C214)
				MESSAGES ON:C181
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{2}+" para profesores...")
				
				APPLY TO SELECTION:C70([Profesores:4];[Profesores:4]eMail_Personal:61:="")
				$l_enUsoProfesores:=$l_enUsoProfesores+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([Profesores:4];[Profesores:4]eMail_profesional:38:="")
				$l_enUsoProfesores:=$l_enUsoProfesores+Records in set:C195("LockedSet")
				
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{2}+" para personas...")
				
				READ WRITE:C146([Personas:7])
				ALL RECORDS:C47([Personas:7])
				
				APPLY TO SELECTION:C70([Personas:7];[Personas:7]eMail:34:="")
				$l_enUsoPersonas:=$l_enUsoPersonas+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111:="")
				$l_enUsoPersonas:=$l_enUsoPersonas+Records in set:C195("LockedSet")
				
				MESSAGES OFF:C175
				KRL_UnloadReadOnly (->[Profesores:4])
				KRL_UnloadReadOnly (->[Personas:7])
				
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{2}+" para alumnos...")
				READ WRITE:C146([Alumnos:2])
				ALL RECORDS:C47([Alumnos:2])
				MESSAGES ON:C181
				APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]eMAIL:68:="")
				$l_enUsoAlumnos:=$l_enUsoAlumnos+Records in set:C195("LockedSet")
				MESSAGES OFF:C175
				KRL_UnloadReadOnly (->[Alumnos:2])
				
				READ WRITE:C146([Familia:78])
				ALL RECORDS:C47([Familia:78])
				MESSAGES ON:C181
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{2}+" para familias...")
				APPLY TO SELECTION:C70([Familia:78];[Familia:78]eMail:21:="")
				$l_enUsoFamilia:=$l_enUsoFamilia+Records in set:C195("LockedSet")
				MESSAGES OFF:C175
				KRL_UnloadReadOnly (->[Familia:78])
				
				READ WRITE:C146([ACT_RazonesSociales:279])
				ALL RECORDS:C47([ACT_RazonesSociales:279])
				MESSAGES ON:C181
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{2}+" para razones sociales...")
				APPLY TO SELECTION:C70([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]contacto_eMail:15:="")
				$l_enUsoRS:=$l_enUsoRS+Records in set:C195("LockedSet")
				MESSAGES OFF:C175
				KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
				0xDev_AvoidTriggerExecution (False:C215)
				
				READ WRITE:C146([xShell_Users:47])
				ALL RECORDS:C47([xShell_Users:47])
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{2}+" para usuarios...")
				APPLY TO SELECTION:C70([xShell_Users:47];[xShell_Users:47]email:20:="")
				$l_enUsoUsuarios:=$l_enUsoUsuarios+Records in set:C195("LockedSet")
				KRL_UnloadReadOnly (->[xShell_Users:47])
				
				If (($l_enUsoProfesores+$l_enUsoPersonas+$l_enUsoAlumnos+$l_enUsoFamilia+$l_enUsoRS+$l_enUsoUsuarios)>0)
					Case of 
						: ($l_enUsoProfesores>0)
							CD_Dlog (0;"Hay registros en uso de profesores. Se debe repetir la operación.")
						: ($l_enUsoPersonas>0)
							CD_Dlog (0;"Hay registros en uso de personas. Se debe repetir la operación.")
						: ($l_enUsoAlumnos>0)
							CD_Dlog (0;"Hay registros en uso alumnos. Se debe repetir la operación.")
						: ($l_enUsoFamilia>0)
							CD_Dlog (0;"Hay registros en uso de familias. Se debe repetir la operación.")
						: ($l_enUsoRS>0)
							CD_Dlog (0;"Hay registros en uso de razones sociales. Se debe repetir la operación.")
						: ($l_enUsoUsuarios>0)
							CD_Dlog (0;"Hay registros en uso de usuarios. Se debe repetir la operación.")
					End case 
				Else 
					  //CD_Dlog (0;"Datos modificados con éxito.")
				End if 
				KRL_UnloadReadOnly (->[xShell_Users:47])
				LOG_RegisterEvt ("QA PRUEBAS: Tarea "+$y_tareaDescripcion->{2}+" ejecutada.")
			End if 
			
			If ($y_tareaTipo->{3})  //Eliminar mail administrador SN
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{3}+"...")
				SN3_LoadGeneralSettings 
				SN3_eMailAdministrador:=""
				SN3_SaveGeneralSettings 
				LOG_RegisterEvt ("QA PRUEBAS: Tarea "+$y_tareaDescripcion->{3}+" ejecutada.")
			End if 
			
			If ($y_tareaTipo->{4})  //Eliminar mail administrador SN
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{4}+"...")
				SN3_LoadUsersSettings 
				SN3_MailAddress:=""
				SN3_SaveUsersConfig 
				LOG_RegisterEvt ("QA PRUEBAS: Tarea "+$y_tareaDescripcion->{4}+" ejecutada.")
			End if 
			
			If ($y_tareaTipo->{5})  //Eliminar mail alertas en ACT
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{5}+"...")
				ACTcfg_LeeBlob ("ACTcfg_AlertasYOtros")
				cbAlertaEmisionAvisos:=0
				vtACTcfg_MailTo:=""
				vtACTcfg_MailCC:=""
				vtACTcfg_MailBCC:=""
				ACTcfg_GuardaBlob ("ACTcfg_AlertasYOtros")
				LOG_RegisterEvt ("QA PRUEBAS: Tarea "+$y_tareaDescripcion->{5}+" ejecutada.")
			End if 
			
			If ($y_tareaTipo->{6})  //Cambiar uuid de todas las tablas
				C_BOOLEAN:C305($b_enUso)
				IT_UThermometer (0;$l_proc;"Ejecutando tarea: "+$y_tareaDescripcion->{6}+"...")
				$b_enUso:=QA_ModificaUUIDTablas 
				LOG_RegisterEvt ("QA PRUEBAS: Tarea "+$y_tareaDescripcion->{6}+" ejecutada"+Choose:C955($b_enUso;" con error por registros en uso en tabla "+ST_Qte ($t_nombreTabla)+".";"."))
				If ($b_enUso)
					CD_Dlog (0;"Había registros en uso en la tabla "+$t_nombreTabla+" durante la ejecución de la tarea "+ST_Qte ($y_tareaDescripcion->{6})+". No todos los registros pudieron ser modificados. Intente nuevamente.")
				End if 
			End if 
			
			
			IT_UThermometer (-2;$l_proc)
		Else 
			BEEP:C151
		End if 
End case 