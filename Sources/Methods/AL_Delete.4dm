//%attributes = {}
  //AL_Delete
C_BOOLEAN:C305($vb_continuar)
$vb_continuar:=True:C214
C_LONGINT:C283($r;$0;$id_Alumno;$nCandidato)
If (USR_checkRights ("D";->[Alumnos:2]))
	$ctaRcNum:=Find in field:C653([ACT_CuentasCorrientes:175]ID_Alumno:3;[Alumnos:2]numero:1)
	  //20120509 ASM se realiza validación, para eliminar a los alumnos que no tienen cargos emitidos o proyectado.
	If ($ctaRcNum#-1)
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$ctaRcNum)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
		If (Records in selection:C76([ACT_Cargos:173])>0)
			$vb_continuar:=False:C215
		Else 
			$vb_continuar:=True:C214
		End if 
	End if 
	
	  //If ($ctaRcNum#-1)
	If (Not:C34($vb_continuar))
		CD_Dlog (2;__ ("Esta alumno tiene una cuenta corriente asociada. El registro no puede ser eliminado."))
	Else 
		$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar toda la información sobre ")+[Alumnos:2]Nombres:2+__ (" ")+[Alumnos:2]Apellido_paterno:3+__ ("?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			$r:=CD_Dlog (2;__ ("Usted solicitó eliminar definitivamente toda la infomación de ")+[Alumnos:2]Nombres:2+__ (" ")+[Alumnos:2]Apellido_paterno:3+__ (".\rEsta acción no podrá ser revertida jamás.\r\r¿Esta usted seguro de quere eliminar este registro?");__ ("");__ ("No");__ ("Eliminar"))
			If ($r=2)
				$pID:=IT_UThermometer (1;0;__ ("Eliminando al alumno seleccionado..."))
				START TRANSACTION:C239
				OK:=AL_ClearCurrentInfo 
				$id_Alumno:=[Alumnos:2]numero:1
				If (OK=1)
					QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1=$id_Alumno)
					$nCandidato:=Records in selection:C76([ADT_Candidatos:49])
					OK:=KRL_DeleteSelection (->[ADT_Candidatos:49];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_Conducta:8];[Alumnos_Conducta:8]Número_de_Alumno:1=$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Conducta:8];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_FichaMedica:13];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Numero_Alumno:1=$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Vacunas:101];False:C215)
				End if 
				If (OK=1)
					$key:="2."+String:C10($id_Alumno)
					QUERY:C277([MDATA_RegistrosDatosLocales:145];[MDATA_RegistrosDatosLocales:145]Llave_Tabla_and_ID:6=$key)
					OK:=KRL_DeleteSelection (->[MDATA_RegistrosDatosLocales:145];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Alumno_Numero:1=$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_EventosEnfermeria:14];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Alumno_Numero:1=$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_EventosPersonales:16];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_EventosOrientacion:21];[Alumnos_EventosOrientacion:21]Alumno_Numero:1=$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_EventosOrientacion:21];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Historico:25];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1=$id_Alumno)
					OK:=KRL_DeleteSelection (->[ADT_Candidatos:49];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2;=;$id_Alumno;*)
					QUERY:C277([Asignaturas_Inasistencias:125]; | ;[Asignaturas_Inasistencias:125]ID_Alumno:2;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6=$id_Alumno;*)
					QUERY:C277([Alumnos_ComplementoEvaluacion:209]; | ;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_ComplementoEvaluacion:209];False:C215)
					If (OK=1)
						QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$id_Alumno;*)
						QUERY:C277([Alumnos_Calificaciones:208]; | ;[Alumnos_Calificaciones:208]ID_Alumno:6;=;-$id_Alumno)
						OK:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208];False:C215)
					End if 
				End if 
				
				If (ok=1)
					QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;$id_Alumno;*)
					QUERY:C277([Alumnos_SintesisAnual:210]; | ;[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_SintesisAnual:210];False:C215)
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$id_Alumno;*)
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; | ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203];False:C215)
				End if 
				
				If (ok=1)
					QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8;=;$id_Alumno;*)
					QUERY:C277([Alumnos_Castigos:9]; | ;[Alumnos_Castigos:9]Alumno_Numero:8;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Castigos:9];False:C215)
				End if 
				If (ok=1)
					QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6;=;$id_Alumno;*)
					QUERY:C277([Alumnos_Anotaciones:11]; | ;[Alumnos_Anotaciones:11]Alumno_Numero:6;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Anotaciones:11];False:C215)
				End if 
				If (ok=1)
					QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7;=;$id_Alumno;*)
					QUERY:C277([Alumnos_Suspensiones:12]; | [Alumnos_Suspensiones:12]Alumno_Numero:7;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Suspensiones:12];False:C215)
				End if 
				If (ok=1)
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4;=;$id_Alumno;*)
					QUERY:C277([Alumnos_Inasistencias:10]; | ;[Alumnos_Inasistencias:10]Alumno_Numero:4;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Inasistencias:10];False:C215)
				End if 
				If (ok=1)
					QUERY:C277([Alumnos_EvaluacionValorica:23];[Alumnos_EvaluacionValorica:23]Alumno_Numero:1;=;$id_Alumno;*)
					QUERY:C277([Alumnos_EvaluacionValorica:23]; | ;[Alumnos_EvaluacionValorica:23]Alumno_Numero:1;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionValorica:23];False:C215)
				End if 
				If (ok=1)
					QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1;=;$id_Alumno;*)
					QUERY:C277([Alumnos_Actividades:28]; | ;[Alumnos_Actividades:28]Alumno_Numero:1;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Actividades:28];False:C215)
				End if 
				If (ok=1)
					QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1;=;$id_Alumno;*)
					QUERY:C277([Alumnos_Atrasos:55]; | ;[Alumnos_Atrasos:55]Alumno_numero:1;=;-$id_Alumno)
					OK:=KRL_DeleteSelection (->[Alumnos_Atrasos:55];False:C215)
				End if 
				
				  //20122505 ASM No se eliminaba la cuenta corriente
				If (OK=1)
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=$id_Alumno)
					ok:=KRL_DeleteSelection (->[ACT_CuentasCorrientes:175];False:C215)
				End if 
				
				If (OK=1)
					If (($nCandidato>0) & (vsBWR_CurrentModule="SchoolTrack"))
						LOG_RegisterEvt ("Eliminación de un registro de la tabla "+API Get Virtual Table Name (Table:C252(->[ADT_Candidatos:49]));Table:C252(->[ADT_Candidatos:49]);0;<>lUSR_CurrentUserID;"AdmissionTrack")
					End if 
					DELETE RECORD:C58([Alumnos:2])
					VALIDATE TRANSACTION:C240
					NIV_LoadArrays 
					KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
				Else 
					CANCEL TRANSACTION:C241
				End if 
				$0:=OK
				$pID:=IT_UThermometer (-2;$pID)
			End if 
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3;2)
End if 
