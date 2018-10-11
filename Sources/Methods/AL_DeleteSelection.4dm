//%attributes = {}
  //AL_DeleteSelection

C_LONGINT:C283($r)
$0:=0
If (USR_checkRights ("D";->[Alumnos:2]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar toda la información de todos los alumnos seleccionados?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		$r:=CD_Dlog (2;__ ("La eliminación es irreversible.\r ¿Eliminar a todos los alumnos seleccionados?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			CREATE SET:C116([Alumnos:2];"2Delete")
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIds;[Alumnos:2]apellidos_y_nombres:40;$aNames;[Alumnos:2]curso:20;$aClass)
			
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
			
			  //20120509 ASM se realiza validación, para eliminar a los alumnos que no tienen cargos emitidos o proyectado.
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Ctas")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
			CREATE SET:C116([ACT_CuentasCorrientes:175];"CtasConCargos")
			INTERSECTION:C121("Ctas";"CtasConCargos";"Ctas")
			USE SET:C118("Ctas")
			SET_ClearSets ("Ctas";"CtasConCargos")
			
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
			CREATE SET:C116([Alumnos:2];"ConCtas")
			DIFFERENCE:C122("2Delete";"ConCtas";"2Delete")
			If (Records in set:C195("ConCtas")>0)
				CD_Dlog (0;__ ("Existen alumnos con cuentas corrientes asociadas. Dichos alumnos no serán eliminados."))
			End if 
			USE SET:C118("2Delete")
			If (Records in set:C195("2Delete")>0)
				SET_ClearSets ("2Delete";"ConCtas")
				$pID:=IT_UThermometer (1;0;__ ("Eliminando los alumnos seleccionados..."))
				START TRANSACTION:C239
				ok:=1
				
				SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIdAlumnos)
				
				If (ok=1)
					AL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$aIdAlumnos)
					OK:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208];False:C215)
				End if 
				
				If (ok=1)
					AL_RelateSelection (->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;->$aIdAlumnos)
					OK:=KRL_DeleteSelection (->[Alumnos_ComplementoEvaluacion:209];False:C215)
				End if 
				
				
				If (OK=1)
					AL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203];False:C215)
				End if 
				
				If (OK=1)
					AL_RelateSelection (->[ADT_Candidatos:49]Candidato_numero:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[ADT_Candidatos:49];False:C215)
				End if 
				
				If (OK=1)
					AL_RelateSelection (->[Alumnos_Vacunas:101]Numero_Alumno:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_Vacunas:101];False:C215)
				End if 
				
				If (OK=1)
					AL_RelateSelection (->[Alumnos_Conducta:8]Número_de_Alumno:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_Conducta:8];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_EvaluacionValorica:23]Alumno_Numero:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_EvaluacionValorica:23];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->$aIdAlumnos)
					OK:=KRL_DeleteSelection (->[Alumnos_SintesisAnual:210];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_Castigos:9]Alumno_Numero:8;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_Castigos:9];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_Inasistencias:10];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_Anotaciones:11];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_Suspensiones:12]Alumno_Numero:7;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_Suspensiones:12];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_Atrasos:55]Alumno_numero:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_Atrasos:55];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_FichaMedica:13]Alumno_Numero:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_FichaMedica:13];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_EventosEnfermeria:14];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_EventosPersonales:16]Alumno_Numero:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_EventosPersonales:16];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_EventosOrientacion:21]Alumno_Numero:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_EventosOrientacion:21];False:C215)
				End if 
				If (OK=1)
					AL_RelateSelection (->[Alumnos_Historico:25]Alumno_Numero:1;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[Alumnos_Historico:25];False:C215)
				End if 
				
				  //20122505 ASM No se eliminaba la cuenta corriente
				If (OK=1)
					AL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->$aIdAlumnos)
					ok:=KRL_DeleteSelection (->[ACT_CuentasCorrientes:175];False:C215)
				End if 
				
				If (OK=1)
					ARRAY TEXT:C222($aKeys;Size of array:C274($aIds))
					For ($i;1;Size of array:C274($aKeys))
						$aKeys{$i}:="2."+String:C10($aIds{$i})
					End for 
					QUERY WITH ARRAY:C644([MDATA_RegistrosDatosLocales:145]Llave_Tabla_and_ID:6;$aKeys)
					OK:=KRL_DeleteSelection (->[MDATA_RegistrosDatosLocales:145])
				End if 
				
				
				
				If (OK=1)
					SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIds;[Alumnos:2]apellidos_y_nombres:40;$aNames;[Alumnos:2]curso:20;$aClass)
					For ($i;1;Size of array:C274($aIds))
						LOG_RegisterEvt ("Alumnos - Eliminación: "+$aNames{$i}+"  "+$aClass{$i};Table:C252(->[Alumnos:2]);$aIds{$i})
					End for 
					ok:=KRL_DeleteSelection (->[Alumnos:2];False:C215)
				End if 
				If (ok=1)
					VALIDATE TRANSACTION:C240
					NIV_LoadArrays 
					KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
					$0:=1
				Else 
					CANCEL TRANSACTION:C241
				End if 
				$pID:=IT_UThermometer (-2;$pID)
			End if 
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3;2)
End if 

