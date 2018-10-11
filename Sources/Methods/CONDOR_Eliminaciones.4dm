//%attributes = {"publishedSoap":true,"publishedWsdl":true}
C_LONGINT:C283(l_tabla)
C_TEXT:C284(t_uuid)
C_LONGINT:C283($l_deleted)
C_TEXT:C284($t_mensaje)
C_LONGINT:C283($rn)
C_TEXT:C284(t_respuesta)

SOAP DECLARATION:C782(l_tabla;Is longint:K8:6;SOAP input:K46:1;"tabla_st")
SOAP DECLARATION:C782(t_uuid;Is text:K8:3;SOAP input:K46:1;"uuid")
SOAP DECLARATION:C782(t_respuesta;Is text:K8:3;SOAP output:K46:2;"resultado")

$l_deleted:=-1
Case of 
	: (l_tabla=Table:C252(->[Alumnos:2]))
		$rn:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->t_uuid;True:C214)
		If ($rn>No current record:K29:2)
			$vb_Continuar:=True:C214
			$ctaCte:=Find in field:C653([ACT_CuentasCorrientes:175]ID_Alumno:3;[Alumnos:2]numero:1)
			If ($ctaCte#No current record:K29:2)
				$idCta:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID:1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$idCta)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($records>0)
					$vb_Continuar:=False:C215
					$l_deleted:=0
					$t_mensaje:="El alumno tiene asociada un cuenta corriente. Dicha cuenta tiene cargos asociados."
				End if 
			Else 
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
				If (OK=1)
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=$id_Alumno)
					ok:=KRL_DeleteSelection (->[ACT_CuentasCorrientes:175];False:C215)
				End if 
				If (OK=1)
					DELETE RECORD:C58([Alumnos:2])
					VALIDATE TRANSACTION:C240
					NIV_LoadArrays 
					KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
				Else 
					CANCEL TRANSACTION:C241
				End if 
				$l_deleted:=OK
				If ($l_deleted=0)
					$t_mensaje:="Algunos registros asociados al alumno no pudieron ser eliminados."
				End if 
			End if 
		End if 
	: (l_tabla=Table:C252(->[Personas:7]))
		$rn:=KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->t_uuid;True:C214)
		If ($rn>No current record:K29:2)
			READ ONLY:C145([Familia:78])
			QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1;*)
			QUERY:C277([Familia:78]; | [Familia:78]Madre_Número:6=[Personas:7]No:1)
			$familia:=[Familia:78]Nombre_de_la_familia:3
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1;*)
			QUERY:C277([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aText1)
			For ($i;1;Size of array:C274($aText1))
				$aText1{$i}:="   - "+$aText1{$i}
			End for 
			$alumnos:=AT_array2text (->$aText1;"\r")
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_RegistrosCargos)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_RegistrosPagos)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$delete:=False:C215
			Case of 
				: (($familia#"") & ($alumnos#""))
					$msg:=[Personas:7]Apellidos_y_nombres:30+" tiene relación con la familia: "+"\r"+"   - "+$familia+"\r\r"
					$msg:=$msg+" y con los siguientes alumnos: "+"\r"+$alumnos+"\r\r"+"El registro no puede ser eliminado."
				: (($familia="") & ($alumnos#""))
					$msg:=[Personas:7]Apellidos_y_nombres:30+" tiene relación con los alumnos "+"\r"+$alumnos+"\r\r"
					$msg:=$msg+"El registro no puede ser eliminado."
				: ((($vl_RegistrosPagos>0) | ($vl_RegistrosCargos>0)) & (Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))=1))
					$msg:=[Personas:7]Apellidos_y_nombres:30+" posee información relacionada a AccountTrack. El registro no puede ser eliminad"+"o."
				: (($familia#"") & ($alumnos=""))
					$msg:=[Personas:7]Apellidos_y_nombres:30+" tiene relación con la familia "+"\r"+"   - "+$familia+"\r"
					$msg:=$msg+"¿Desea Ud. realmente eliminar esta ficha?"
					$delete:=True:C214
				: (($familia="") & ($alumnos=""))
					$msg:="¿Desea Ud. realmente eliminar la ficha de "+[Personas:7]Apellidos_y_nombres:30+"?"
					$delete:=True:C214
			End case 
			If (Not:C34($delete))
				$l_deleted:=0
				$t_mensaje:=$msg
			Else 
				START TRANSACTION:C239
				READ WRITE:C146([Familia:78])
				QUERY:C277([Familia:78];[Familia:78]Madre_Número:6=[Personas:7]No:1)
				APPLY TO SELECTION:C70([Familia:78];[Familia:78]Madre_Número:6:=0)
				APPLY TO SELECTION:C70([Familia:78];[Familia:78]Madre_Nombre:16:="")
				KRL_UnloadReadOnly (->[Familia:78])
				If (ok=1)
					READ WRITE:C146([Familia_RelacionesFamiliares:77])
					QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
					ok:=KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77];False:C215)
				End if 
				If (ok=1)
					READ WRITE:C146([Alumnos:2])
					QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1)
					APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27:=0)
				End if 
				If (ok=1)
					QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
					APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28:=0)
				End if 
				KRL_UnloadReadOnly (->[Alumnos:2])
			End if 
			If (ok=1)
				READ WRITE:C146([Profesores:4])
				QUERY:C277([Profesores:4];[Profesores:4]ID_Persona:65=[Personas:7]No:1)
				[Profesores:4]ID_Persona:65:=0
				[Profesores:4]ConAlumnosRelacionados:64:=False:C215
				SAVE RECORD:C53([Profesores:4])
				KRL_UnloadReadOnly (->[Profesores:4])
			End if 
			If (ok=1)
				ARRAY LONGINT:C221($aIDs;0)
				APPEND TO ARRAY:C911($aIDs;[Personas:7]No:1)
				ADTcdd_DeleteEducacionAnterior (->$aIDs;"pe")
			End if 
			DELETE RECORD:C58([Personas:7])
			If (ok=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
				$t_mensaje:="Algunos registros asociados a la persona no pudieron ser eliminados."
			End if 
			$l_deleted:=ok
		End if 
	: (l_tabla=Table:C252(->[Profesores:4]))
		$rn:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]Auto_UUID:41;->t_uuid;True:C214)
		If ($rn>No current record:K29:2)
			READ WRITE:C146([xShell_Users:47])
			QUERY:C277([xShell_Users:47];[xShell_Users:47]NoEmployee:7=[Profesores:4]Numero:1)
			QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
			If (Records in selection:C76([Cursos:3])#0)
				$mess:=[Profesores:4]Apellidos_y_nombres:28+" es profesor jefe de "+[Cursos:3]Curso:1
				$messDlog:="Si elimina el registro de "+[Profesores:4]Apellidos_y_nombres:28+" deberá reasignar el profesor jefe a "+[Cursos:3]Curso:1
			End if 
			QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
			SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$aSubject;[Asignaturas:18]Curso:5;$aClass)
			$mess2:=""
			For ($i;1;Size of array:C274($aSubject))
				$mess2:=$mess2+$aSubject{$i}+", "+$aClass{$i}+"\r"
			End for 
			If ($mess2#"")
				If ($mess#"")
					$mess:=$mess+"\r"+" y profesor de las siguientes asignaturas: "+"\r"+$mess2
					$messDlog:="Si elimina el registro de "+[Profesores:4]Apellidos_y_nombres:28+" deberá reasignar el profesor jefe a "+[Cursos:3]Curso:1+" y los profesores de asignatura en: "+"\r"+$mess2
				Else 
					$mess:="Es profesor de las siguientes asignaturas: "+"\r"+$mess2
					$messDlog:="Si elimina el registro de "+[Profesores:4]Apellidos_y_nombres:28+" deberá reasignar los profesores de asignatura en: "+"\r"+$mess2
				End if 
			End if 
			QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=[Profesores:4]Numero:1)
			If (Records in selection:C76([Alumnos:2])>0)
				$mess:=[Profesores:4]Apellidos_y_nombres:28+" es tutor de  "+String:C10(Records in selection:C76([Alumnos:2]))+" alumnos."
				$messDlog:="Si elimina el registro de "+[Profesores:4]Apellidos_y_nombres:28+" deberá reasignar tutor a "+String:C10(Records in selection:C76([Alumnos:2]))+" alumnos."
			End if 
			If ($mess="")
				If (Not:C34(Locked:C147([xShell_Users:47])))
					DELETE RECORD:C58([xShell_Users:47])
					DELETE RECORD:C58([Profesores:4])
					KRL_ReloadAsReadOnly (->[xShell_Users:47])
					$l_deleted:=1
				Else 
					$t_mensaje:="Algunos registros asociados al profesor no pudieron ser eliminados."
					$l_deleted:=0
				End if 
			Else 
				ARRAY TEXT:C222($aText1;0)
				ARRAY LONGINT:C221($aLong1;0)
				START TRANSACTION:C239
				READ WRITE:C146([Asignaturas:18])
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
				AT_DimArrays (Records in selection:C76([Asignaturas:18]);->$aText1;->$aLong1)
				OK:=KRL_Array2Selection (->$aText1;->[Asignaturas:18]profesor_nombre:13;->$aLong1;->[Asignaturas:18]profesor_numero:4)
				KRL_UnloadReadOnly (->[Asignaturas:18])
				If (ok=1)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1)
					AT_DimArrays (Records in selection:C76([Asignaturas:18]);->$aText1;->$aLong1)
					OK:=KRL_Array2Selection (->$aText1;->[Asignaturas:18]profesor_firmante_Nombre:34;->$aLong1;->[Asignaturas:18]profesor_firmante_numero:33)
					KRL_UnloadReadOnly (->[Asignaturas:18])
				End if 
				If (ok=1)
					READ WRITE:C146([Cursos:3])
					QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
					APPLY TO SELECTION:C70([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2:=0)
					KRL_UnloadReadOnly (->[Cursos:3])
				End if 
				If (ok=1)
					READ WRITE:C146([Alumnos:2])
					QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=[Profesores:4]Numero:1)
					AT_DimArrays (Records in selection:C76([Alumnos:2]);->aText1;->aLong1)
					OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Tutor_Nombre:38;->aLong1;->[Alumnos:2]Tutor_numero:36)
					KRL_UnloadReadOnly (->[Alumnos:2])
				Else 
					ok:=0
				End if 
				If (ok=1)
					If (Not:C34(Locked:C147([xShell_Users:47])))
						DELETE RECORD:C58([xShell_Users:47])
						KRL_ReloadAsReadOnly (->[xShell_Users:47])
					Else 
						ok:=0
					End if 
				Else 
					ok:=0
				End if 
				If (ok=1)
					DELETE RECORD:C58([Profesores:4])
					VALIDATE TRANSACTION:C240
				Else 
					CANCEL TRANSACTION:C241
					$t_mensaje:="Algunos registros asociados al profesor no pudieron ser eliminados."
				End if 
				$l_deleted:=ok
			End if 
		End if 
	: (l_tabla=Table:C252(->[Familia:78]))
		$rn:=KRL_FindAndLoadRecordByIndex (->[Familia:78]Auto_UUID:23;->t_uuid;True:C214)
		If ($rn>No current record:K29:2)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
			QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($records>0)
				$l_deleted:=0
				$t_mensaje:="La familia no puede ser eliminada mientras tenga alumnos asociados."
			Else 
				$recNum:=Record number:C243([Familia:78])
				ARRAY LONGINT:C221($al_idPersonas;0)
				READ ONLY:C145([Familia_RelacionesFamiliares:77])
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & [Personas:7]No:1#0)
				SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Persona:3;$al_idPersonas)
				CREATE EMPTY SET:C140([Personas:7];"toDelete")
				fm_BuscaPersonasAEliminar ("toDelete";->$al_idPersonas)
				USE SET:C118("toDelete")
				CLEAR SET:C117("toDelete")
				GOTO RECORD:C242([Familia:78];$recNum)
				START TRANSACTION:C239
				ok:=KRL_DeleteSelection (->[Personas:7])
				If (ok=1)
					QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
					ok:=KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77])
					If (ok=1)
						DELETE RECORD:C58([Familia:78])
					End if 
				End if 
				If (ok=1)
					VALIDATE TRANSACTION:C240
				Else 
					CANCEL TRANSACTION:C241
					$t_mensaje:="Algunos registros asociados a la familia no pudieron ser eliminados."
				End if 
				$l_deleted:=ok
			End if 
		End if 
	: (l_tabla=Table:C252(->[Familia_RelacionesFamiliares:77]))
		$rn:=KRL_FindAndLoadRecordByIndex (->[Familia_RelacionesFamiliares:77]Auto_UUID:7;->t_uuid;True:C214)
		If ($rn>No current record:K29:2)
			If ([Familia_RelacionesFamiliares:77]ID_Persona:3=0)
				$l_deleted:=KRL_DeleteRecord (->[Familia_RelacionesFamiliares:77])
				If ($l_deleted=0)
					$t_mensaje:="No es posible eliminar la relación familiar en este momento."
				End if 
			Else 
				READ ONLY:C145([Alumnos:2])
				QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia_RelacionesFamiliares:77]ID_Familia:2)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Familia_RelacionesFamiliares:77]ID_Persona:3;*)
				QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=[Familia_RelacionesFamiliares:77]ID_Persona:3)
				If (Records in selection:C76([Alumnos:2])>0)
					$l_deleted:=0
					$t_mensaje:="La relación familiar es apoderado de un alumno de la familia."
				Else 
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Familia_RelacionesFamiliares:77]ID_Persona:3;*)
					QUERY:C277([ACT_CuentasCorrientes:175]; & [ACT_CuentasCorrientes:175]ID_Familia:2=[Familia_RelacionesFamiliares:77]ID_Familia:2)
					If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
						$l_deleted:=0
						$t_mensaje:="La relación familiar tiene cuentas corrientes activas a su cargo."
					Else 
						READ ONLY:C145([Alumnos:2])
						QUERY:C277([Alumnos:2];[Alumnos:2]ID_Custodio:99=[Familia_RelacionesFamiliares:77]ID_Persona:3)
						If (Records in selection:C76([Alumnos:2])>0)
							$l_deleted:=0
							$t_mensaje:="La relación familiar es custodio de al menos un alumno."
						Else 
							START TRANSACTION:C239
							READ WRITE:C146([Familia:78])
							QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
							If ([Familia:78]Padre_Número:5=[Familia_RelacionesFamiliares:77]ID_Persona:3)
								[Familia:78]Padre_Número:5:=0
								[Familia:78]Padre_Nombre:15:=""
							End if 
							If ([Familia:78]Madre_Número:6=[Familia_RelacionesFamiliares:77]ID_Persona:3)
								[Familia:78]Madre_Número:6:=0
								[Familia:78]Madre_Nombre:16:=""
							End if 
							SAVE RECORD:C53([Familia:78])
							$nombrePersona:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;->[Personas:7]Apellidos_y_nombres:30)
							$log:="Eliminación de "+[Familia_RelacionesFamiliares:77]Parentesco:6+" ("+$nombrePersona+") en la familia "+[Familia:78]Nombre_de_la_familia:3+"."
							LOG_RegisterEvt ($log)
							KRL_UnloadReadOnly (->[Familia:78])
							DELETE RECORD:C58([Familia_RelacionesFamiliares:77])
							$l_deleted:=ok
							If ($l_deleted=0)
								$t_mensaje:="No fue posible eliminar la realción familiar."
								CANCEL TRANSACTION:C241
							Else 
								VALIDATE TRANSACTION:C240
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	Else 
		$l_deleted:=-2
End case 
Case of 
	: ($l_deleted=-1)
		$t_mensaje:="No se encuentra el registro en SchoolTrack."
	: ($l_deleted=-2)
		$t_mensaje:="No se encuentra la tabla en SchoolTrack."
End case 

  // Modificado por: Alexis Bustamante (10-06-2017)
  //Ticket 179869


C_OBJECT:C1216($ob_raiz)
C_TEXT:C284($json)

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$l_deleted;"codigo")
OB_SET ($ob_raiz;->$t_mensaje;"mensaje")
$json:=OB_Object2Json ($ob_raiz)
t_respuesta:=$json

  //$json:=JSON New 
  //$node:=JSON Append long ($json;"codigo";$l_deleted)
  //$node:=JSON Append text ($json;"mensaje";$t_mensaje)
  //t_respuesta:=JSON Export to text ($json;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($json)

  //resultado -2: tabla desconocida
  //resultado -1: registro inexistente en ST
  //resultado 0: No se puede eliminar
  //resultado 1: Eliminación exitosa