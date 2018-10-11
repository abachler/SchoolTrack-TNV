//%attributes = {}
  //SIGE_LoadDataArrays
C_LONGINT:C283($accion;$1;$opcion;$2;$vl_mes;$3;$noNivel;$4)
C_LONGINT:C283($i;$fia)
$accion:=$1
$opcion:=1

If (Count parameters:C259>=2)  //opción de visualización (utilizada actualmente para la asistencia)
	$opcion:=$2
End if 

If (Count parameters:C259>=3)  // Mes para la visualización de asistencia
	$vl_mes:=$3
End if 

If (Count parameters:C259=4)  //No Nivel para filtrar en asistencia
	$noNivel:=$4
End if 

If (at_ultima_ejec{$accion}#"")
	vt_fechaejec:=at_ultima_ejec{$accion}
Else 
	vt_fechaejec:="nunca ejecutado..."
End if 

Case of 
	: ($accion=1)  //Verificación de alumnos
		
		READ ONLY:C145([Alumnos:2])
		C_TEXT:C284(vt_ultima_fecha_alu)
		
		  //la fecha tiene que ser con hora
		
		If (vt_ultima_fecha_alu#vt_fechaejec)
			
			vt_ultima_fecha_alu:=vt_fechaejec
			ARRAY LONGINT:C221(al_alu_fail_verif;0)
			
			ARRAY TEXT:C222(at_alumno;0)
			ARRAY TEXT:C222(at_cur;0)
			ARRAY TEXT:C222(at_problema_alu;0)
			
			Case of 
				: ((Not:C34(ab_status{$accion})) & (Size of array:C274(al_id_alumno)=0))  //nunca se ha ejecutado el proceso
					
					QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesActivos)
					QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  //filtrar Cursos ADT
					KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@")
					ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					SELECTION TO ARRAY:C260([Alumnos:2]numero:1;al_id_alumno)
					ARRAY LONGINT:C221(al_cod_ejec_alu;Size of array:C274(al_id_alumno))
					REDUCE SELECTION:C351([Alumnos:2];0)
					
				: (Size of array:C274(al_id_alumno)>0)  //Verificar si hay alumnos nuevos que no se han agregado al proceso
					ARRAY LONGINT:C221($al_new_alu;0)
					QUERY WITH ARRAY:C644([Alumnos:2]numero:1;al_id_alumno)
					CREATE SET:C116([Alumnos:2];"alu_proc")
					QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesActivos)
					QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  //filtrar Cursos ADT
					KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@")
					CREATE SET:C116([Alumnos:2];"todos")
					DIFFERENCE:C122("todos";"alu_proc";"todos")
					USE SET:C118("todos")
					SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_new_alu)
					SET_ClearSets ("todos";"alu_proc")
					For ($i;1;Size of array:C274($al_new_alu))
						APPEND TO ARRAY:C911(al_id_alumno;$al_new_alu{$i})
						APPEND TO ARRAY:C911(al_cod_ejec_alu;0)
					End for 
					
					  //quitando a los retirados 
					ARRAY LONGINT:C221($al_retirados;0)
					QUERY WITH ARRAY:C644([Alumnos:2]numero:1;al_id_alumno)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Ret@")
					SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_retirados)
					
					For ($i;1;Size of array:C274($al_retirados))
						$fia:=Find in array:C230(al_id_alumno;$al_retirados{$i})
						If ($fia>0)
							DELETE FROM ARRAY:C228(al_id_alumno;$fia;1)
							DELETE FROM ARRAY:C228(al_cod_ejec_alu;$fia;1)
						End if 
					End for 
					
					
					
			End case 
			
			For ($i;1;Size of array:C274(al_id_alumno))
				
				If (al_cod_ejec_alu{$i}#1)
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=al_id_alumno{$i})
					APPEND TO ARRAY:C911(al_alu_fail_verif;al_id_alumno{$i})
					If (Records in selection:C76([Alumnos:2])=1)
						
						APPEND TO ARRAY:C911(at_alumno;[Alumnos:2]apellidos_y_nombres:40)
						APPEND TO ARRAY:C911(at_cur;[Alumnos:2]curso:20)
						UNLOAD RECORD:C212([Alumnos:2])
						
						Case of 
							: (al_cod_ejec_alu{$i}=-1)  //respuesta interna para alumnos no verificados
								APPEND TO ARRAY:C911(at_problema_alu;"Alumnos sin RUN en Schooltrack")
							: (al_cod_ejec_alu{$i}=0)
								APPEND TO ARRAY:C911(at_problema_alu;"Alumnos sin proceso de verificación")
							: (al_cod_ejec_alu{$i}=2)  //respuestas de error entregadas por el mineduc en el archivo API Servicios SIGE v-0.2
								APPEND TO ARRAY:C911(at_problema_alu;"RUN de entrada tiene Ficha SIGE, pero la identificación proporcionada no correspo"+"nde a SRCel.")
							: (al_cod_ejec_alu{$i}=3)
								APPEND TO ARRAY:C911(at_problema_alu;"RUN de entrada NO tiene Ficha SIGE, pero la identificación proporcionada correspo"+"nde a SRCel.")
							: (al_cod_ejec_alu{$i}=4)
								APPEND TO ARRAY:C911(at_problema_alu;"RUN de entrada NO tiene Ficha SIGE y la identificación proporcionada no correspo"+"nde a SRCel.")
							: (al_cod_ejec_alu{$i}=5)
								APPEND TO ARRAY:C911(at_problema_alu;"RUN de entrada NO válido")
						End case 
						
					End if 
					
				End if 
				
			End for 
			
			
		End if 
		
		vl_alumnosnoverif:=Size of array:C274(at_alumno)
		
		  //para el botón de status
		If (vl_alumnosnoverif=0)
			ab_status{$accion}:=True:C214
		Else 
			ab_status{$accion}:=False:C215
		End if 
		
		
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->al_id_alumno;->al_cod_ejec_alu)
		PREF_SetBlob (0;"SIGE_ALUMNOS_"+String:C10(<>gyear);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($accion=2)  //Ingreso Tipo enseñanza
		
		  //verificamos todos los tipos de enseñanza con distinto rol de bd
		ARRAY TEXT:C222($at_RolBD;0)
		ARRAY LONGINT:C221($al_Educ_Codes;0)
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>=0)
		ORDER BY:C49([Cursos:3];[Cursos:3]cl_RolBaseDatos:20;>;[Cursos:3]cl_CodigoTipoEnseñanza:21;>)
		
		AT_DistinctsFieldValues (->[Cursos:3]cl_RolBaseDatos:20;->$at_RolBD)
		
		If (Size of array:C274($at_RolBD)>1)
			SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoTipoEnseñanza:21;$al_Educ_Codes;[Cursos:3]cl_RolBaseDatos:20;$at_RolBD)
			For ($i;Size of array:C274($al_Educ_Codes);1;-1)
				If (($al_Educ_Codes{$i}=$al_Educ_Codes{$i-1}) & ($at_RolBD{$i}=$at_RolBD{$i-1}))
					AT_Delete ($i;1;->$al_Educ_Codes;->$at_RolBD)
				End if 
			End for 
		Else 
			AT_DistinctsFieldValues (->[Cursos:3]cl_CodigoTipoEnseñanza:21;->$al_Educ_Codes)
			While (Size of array:C274($at_RolBD)<Size of array:C274($al_Educ_Codes))
				APPEND TO ARRAY:C911($at_RolBD;$at_RolBD{1})
			End while 
		End if 
		
		If (Size of array:C274(al_cod_tipo_ens)=0)
			COPY ARRAY:C226($at_RolBD;at_rolbd)
			COPY ARRAY:C226($al_Educ_Codes;al_cod_tipo_ens)
		Else 
			$text:=AT_Arrays2Text (";";"-";->at_rolbd;->al_cod_tipo_ens)
			For ($i;1;Size of array:C274($at_RolBD))
				$pos:=Position:C15($at_RolBD{$i}+"-"+String:C10($al_Educ_Codes{$i});$text)
				If ($pos=0)
					APPEND TO ARRAY:C911(at_rolbd;$at_RolBD{$i})
					APPEND TO ARRAY:C911(al_cod_tipo_ens;$al_Educ_Codes{$i})
				End if 
			End for 
		End if 
		ARRAY LONGINT:C221(al_cod_ejec_tipo_ens;Size of array:C274(at_rolbd))
		ARRAY TEXT:C222(at_listado_error_tipo_ens;Size of array:C274(at_rolbd))
		
		  //array para despliegue de los que no han sido verificados o tuvieron problemas
		ARRAY TEXT:C222(at_CodTipoEns_P;0)
		ARRAY TEXT:C222(at_RolBD_P;0)
		ARRAY TEXT:C222(at_detalle_P;0)
		
		For ($i;1;Size of array:C274(al_cod_tipo_ens))
			
			  //para mostrar las enseñanzas en el arealist que no han sido procesados correctamente
			  //If (al_cod_ejec_tipo_ens{$i}#1)//antes ocultaba lo enviado satisfactoriamente
			APPEND TO ARRAY:C911(at_CodTipoEns_P;String:C10(al_cod_tipo_ens{$i}))
			APPEND TO ARRAY:C911(at_RolBD_P;at_rolbd{$i})
			
			Case of 
				: (al_cod_ejec_tipo_ens{$i}=0)
					APPEND TO ARRAY:C911(at_detalle_P;"Porceso de ingreso no ejecutado")
				: ((al_cod_ejec_tipo_ens{$i}=2) | (al_cod_ejec_tipo_ens{$i}=1) | (al_cod_ejec_tipo_ens{$i}=-1))
					APPEND TO ARRAY:C911(at_detalle_P;Lowercase:C14(ST_GetCleanString (at_listado_error_tipo_ens{$i})))
				: (al_cod_ejec_tipo_ens{$i}=3)
					APPEND TO ARRAY:C911(at_detalle_P;"RBD NO tiene servicio disponible")
				: (al_cod_ejec_tipo_ens{$i}=4)
					APPEND TO ARRAY:C911(at_detalle_P;"Convenio no tiene asociado RBD")
				: (al_cod_ejec_tipo_ens{$i}=5)
					APPEND TO ARRAY:C911(at_detalle_P;"Servicio no disponible")
				: (al_cod_ejec_tipo_ens{$i}=7)
					APPEND TO ARRAY:C911(at_detalle_P;"Error Interno de Servicio")
			End case 
			
			  //End if 
			
		End for 
		
		vl_IngTipoEns:=Size of array:C274(at_CodTipoEns_P)
		
		If (vl_IngTipoEns=0)
			ab_status{$accion}:=True:C214
		Else 
			ab_status{$accion}:=False:C215
		End if 
		
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->al_cod_tipo_ens;->at_rolbd;->al_cod_ejec_tipo_ens;->at_listado_error_tipo_ens)
		PREF_SetBlob (0;"SIGE_TIPOENS_"+String:C10(<>gyear);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($accion=3)  //Ingreso de Cursos
		
		READ ONLY:C145([Cursos:3])
		  //arrays de despliegue en listbox
		ARRAY TEXT:C222(at_curso_P;0)
		ARRAY TEXT:C222(at_cod_ejec_curso_P;0)
		
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
		CREATE SET:C116([Cursos:3];"todos")
		
		If (Size of array:C274(at_curso)=0)
			ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;at_curso)
			ARRAY LONGINT:C221(al_cod_ejec_curso;Size of array:C274(at_curso))
			ARRAY TEXT:C222(at_listado_error_curso;Size of array:C274(at_curso))
		Else 
			ARRAY TEXT:C222($at_cursos_nuevos;0)
			QUERY WITH ARRAY:C644([Cursos:3]Curso:1;at_curso)
			CREATE SET:C116([Cursos:3];"cursos_reg")
			CREATE EMPTY SET:C140([Cursos:3];"cursos_nuevos")
			DIFFERENCE:C122("todos";"cursos_reg";"cursos_nuevos")
			USE SET:C118("cursos_nuevos")
			ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursos_nuevos)
			For ($i;1;Size of array:C274($at_cursos_nuevos))
				APPEND TO ARRAY:C911(at_curso;$at_cursos_nuevos{$i})
				APPEND TO ARRAY:C911(al_cod_ejec_curso;0)
				APPEND TO ARRAY:C911(at_listado_error_curso;"")
			End for 
			SET_ClearSets ("cursos_reg";"cursos_nuevos")
		End if 
		CLEAR SET:C117("todos")
		
		$lineas_visibles_por_linea:=3
		
		For ($i;1;Size of array:C274(at_curso))
			
			  //If (al_cod_ejec_curso{$i}#1)  //1)solicitud ingresada ok - 2) Curso ya existente en SIGE
			APPEND TO ARRAY:C911(at_curso_P;at_curso{$i})
			Case of 
				: (al_cod_ejec_curso{$i}=0)
					APPEND TO ARRAY:C911(at_cod_ejec_curso_P;"Proceso no ejecutado")
				: ((al_cod_ejec_curso{$i}=2) | (al_cod_ejec_curso{$i}=1))  //esto se llena en la misma llamada al WS que devuelve el detalle de los errores.
					APPEND TO ARRAY:C911(at_cod_ejec_curso_P;Lowercase:C14(ST_GetCleanString (at_listado_error_curso{$i})))
				: (al_cod_ejec_curso{$i}=3)
					APPEND TO ARRAY:C911(at_cod_ejec_curso_P;"RBD No tiene servicio disponible")
				: (al_cod_ejec_curso{$i}=4)
					APPEND TO ARRAY:C911(at_cod_ejec_curso_P;"Convenio NO tiene asociado RBD")
				: (al_cod_ejec_curso{$i}=5)
					APPEND TO ARRAY:C911(at_cod_ejec_curso_P;"Servicio NO disponible")
				: (al_cod_ejec_curso{$i}=7)
					APPEND TO ARRAY:C911(at_cod_ejec_curso_P;"Error interno de servicio")
				: ((al_cod_ejec_curso{$i}=-10) | (al_cod_ejec_curso{$i}=-9))
					APPEND TO ARRAY:C911(at_cod_ejec_curso_P;at_listado_error_curso{$i})
					
			End case 
			  //End if 
			
		End for 
		
		vl_IngCursos:=Size of array:C274(at_curso_P)
		
		If (vl_IngCursos=0)
			ab_status{$accion}:=True:C214
		Else 
			ab_status{$accion}:=False:C215
		End if 
		
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->at_curso;->al_cod_ejec_curso;->at_listado_error_curso)
		PREF_SetBlob (0;"SIGE_CURSOS_"+String:C10(<>gyear);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($accion=4)  //Asistencia
		
		Case of   //opcion 1 mesual, 2 diario, 3 resultado
			: ($opcion=1)  //general : todos los niveles para el mes seleccionado
				
				ARRAY TEXT:C222(at_NivDetail;0)
				
				For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
					
					ARRAY TEXT:C222($at_key_nivel;0)
					ARRAY TEXT:C222($at_key_fecha_nivel;0)
					ARRAY LONGINT:C221($al_cod_respuesta_asist;0)
					ARRAY TEXT:C222($at_cod_envio_asist;0)  //código para consultar como fue procesado nuestro envío
					ARRAY TEXT:C222($at_envio_asist_msg;0)
					ARRAY LONGINT:C221($al_cod_envio_asist_resp;0)
					ARRAY TEXT:C222($at_error_envio_asist_resp;0)
					
					ARRAY LONGINT:C221($al_codigos_pet;0)
					ARRAY LONGINT:C221($al_codigos_rev;0)
					
					$vt_detalle_nivel:=SIGE_CargaBlobNivelesMes (<>al_NumeroNivelesActivos{$i};$vl_mes;->$at_key_nivel;->$at_key_fecha_nivel;->$al_cod_respuesta_asist;->$at_cod_envio_asist;->$at_envio_asist_msg;->$al_cod_envio_asist_resp;->$at_error_envio_asist_resp)
					
					COPY ARRAY:C226($al_cod_respuesta_asist;$al_codigos_pet)
					AT_DistinctsArrayValues (->$al_codigos_pet)
					COPY ARRAY:C226($al_cod_envio_asist_resp;$al_codigos_rev)
					AT_DistinctsArrayValues (->$al_codigos_rev)
					
					ARRAY TEXT:C222($at_error_txt;0)
					
					For ($n;1;Size of array:C274($al_codigos_pet))
						Case of 
							: ($al_codigos_pet{$n}=0)
								APPEND TO ARRAY:C911($at_error_txt;"Proceso nunca ejecutado")
							: ($al_codigos_pet{$n}=2)
								APPEND TO ARRAY:C911($at_error_txt;"Error de validación de negocio")
							: ($al_codigos_pet{$n}=3)
								APPEND TO ARRAY:C911($at_error_txt;"RBD NO tiene servicio disponible")
							: ($al_codigos_pet{$n}=4)
								APPEND TO ARRAY:C911($at_error_txt;"Convenio NO tiene RBD asociado")
							: ($al_codigos_pet{$n}=5)
								APPEND TO ARRAY:C911($at_error_txt;"Servicio NO disponible")
							: ($al_codigos_pet{$n}=7)
								APPEND TO ARRAY:C911($at_error_txt;"Error interno del servicio")
						End case 
					End for 
					
					ARRAY LONGINT:C221($DA_return;0)
					$al_codigos_pet{0}:=0
					AT_SearchArray (->$al_codigos_pet;"#";->$DA_return)
					
					If (Size of array:C274($DA_return)>0)
						
						For ($n;1;Size of array:C274($al_codigos_rev))
							Case of 
								: ($al_codigos_rev{$n}=0)
									APPEND TO ARRAY:C911($at_error_txt;"Verificación de ingreso pendiente")
								: ($al_codigos_rev{$n}=1)
									APPEND TO ARRAY:C911($at_error_txt;"Asistencia procesada Existosamente")
								: ($al_codigos_rev{$n}=2)
									APPEND TO ARRAY:C911($at_error_txt;"Asistencia procesada con observaciones")
								: ($al_codigos_rev{$n}=3)
									APPEND TO ARRAY:C911($at_error_txt;"Asistencia procesada con errores")
								: ($al_codigos_rev{$n}=4)
									APPEND TO ARRAY:C911($at_error_txt;"Asistencia aun no procesada")
								: ($al_codigos_rev{$n}=5)
									APPEND TO ARRAY:C911($at_error_txt;"Parámetros no corresponden")
								: ($al_codigos_rev{$n}=6)
									APPEND TO ARRAY:C911($at_error_txt;"RBD NO tiene servicio disponible")
								: ($al_codigos_rev{$n}=7)
									APPEND TO ARRAY:C911($at_error_txt;"Convenio NO tiene asociado RBD")
								: ($al_codigos_rev{$n}=8)
									APPEND TO ARRAY:C911($at_error_txt;"Servicio no disponible")
								: ($al_codigos_rev{$n}=9)
									APPEND TO ARRAY:C911($at_error_txt;"Semilla para verificación ha caducado...")
								: ($al_codigos_rev{$n}=10)
									APPEND TO ARRAY:C911($at_error_txt;"Error interno de servicio")
							End case 
						End for 
						
					End if 
					
					APPEND TO ARRAY:C911(at_NivDetail;AT_array2text (->$at_error_txt;", "))
					
				End for 
				
			: ($opcion>1)
				
				ARRAY TEXT:C222($at_key_nivel;0)
				ARRAY TEXT:C222($at_key_fecha_nivel;0)
				ARRAY LONGINT:C221($al_cod_respuesta_asist;0)
				ARRAY TEXT:C222($at_cod_envio_asist;0)  //código para consultar como fue procesado nuestro envío
				ARRAY TEXT:C222($at_envio_asist_msg;0)
				ARRAY LONGINT:C221($al_cod_envio_asist_resp;0)
				ARRAY TEXT:C222($at_error_envio_asist_resp;0)
				
				$vt_detalle_nivel:=SIGE_CargaBlobNivelesMes ($noNivel;$vl_mes;->$at_key_nivel;->$at_key_fecha_nivel;->$al_cod_respuesta_asist;->$at_cod_envio_asist;->$at_envio_asist_msg;->$al_cod_envio_asist_resp;->$at_error_envio_asist_resp)
				
				ARRAY TEXT:C222(at_Fecha;0)
				ARRAY TEXT:C222(at_Rol;0)
				ARRAY TEXT:C222(at_Cod_ens;0)
				ARRAY TEXT:C222(at_Cod_grado;0)
				ARRAY TEXT:C222(at_Detalle;0)
				
				For ($i;1;Size of array:C274($at_key_fecha_nivel))
					If ($opcion=3)
						
						If ($al_cod_respuesta_asist{$i}=1)  //LOS INGRESOS DE ASISTENCIA ENVIADOS SATISFACTORIAMENTE Y QUE NO HAN SIDO CONFIRMADOS POSITIVAMENTE
							ARRAY TEXT:C222($at_exploded;0)
							AT_Text2Array (->$at_exploded;$at_key_fecha_nivel{$i};".")
							If (Size of array:C274($at_exploded)=4)
								
								APPEND TO ARRAY:C911(at_Rol;$at_exploded{1})
								APPEND TO ARRAY:C911(at_Cod_ens;$at_exploded{2})
								APPEND TO ARRAY:C911(at_Cod_grado;$at_exploded{3})
								APPEND TO ARRAY:C911(at_Fecha;$at_exploded{4})
								
								Case of 
									: ($al_cod_envio_asist_resp{$i}=0)
										APPEND TO ARRAY:C911(at_Detalle;"Verificación de ingreso pendiente"+$at_error_envio_asist_resp{$i})
									: ($al_cod_envio_asist_resp{$i}=1)
										APPEND TO ARRAY:C911(at_Detalle;"Asistencia procesada exitosamente.")
									: ($al_cod_envio_asist_resp{$i}=2)
										APPEND TO ARRAY:C911(at_Detalle;"Asistencia procesada con observaciones. "+$at_error_envio_asist_resp{$i})
									: ($al_cod_envio_asist_resp{$i}=3)
										APPEND TO ARRAY:C911(at_Detalle;"Asistencia procesada con errores. "+$at_error_envio_asist_resp{$i})
									: ($al_cod_envio_asist_resp{$i}=4)
										APPEND TO ARRAY:C911(at_Detalle;"Asistencia aun no ha sido procesada.")
									: ($al_cod_envio_asist_resp{$i}=5)
										APPEND TO ARRAY:C911(at_Detalle;"Parámetros no corresponden. "+$at_error_envio_asist_resp{$i})
									: ($al_cod_envio_asist_resp{$i}=6)
										APPEND TO ARRAY:C911(at_Detalle;"RBD NO tiene Servicio Disponible")
									: ($al_cod_envio_asist_resp{$i}=7)
										APPEND TO ARRAY:C911(at_Detalle;"Convenio NO tiene RBD asociado")
									: ($al_cod_envio_asist_resp{$i}=8)
										APPEND TO ARRAY:C911(at_Detalle;"Servicio no disponible, intente nuevamente más tarde.")
									: ($al_cod_envio_asist_resp{$i}=9)
										APPEND TO ARRAY:C911(at_Detalle;"Semilla de operación no válida")
									: ($al_cod_envio_asist_resp{$i}=10)
										APPEND TO ARRAY:C911(at_Detalle;"Error interno del servicio")
										
								End case 
								
							End if 
							
						End if 
						
					Else 
						
						ARRAY TEXT:C222($at_exploded;0)
						AT_Text2Array (->$at_exploded;$at_key_fecha_nivel{$i};".")
						
						If (Size of array:C274($at_exploded)=4)
							
							APPEND TO ARRAY:C911(at_Rol;$at_exploded{1})
							APPEND TO ARRAY:C911(at_Cod_ens;$at_exploded{2})
							APPEND TO ARRAY:C911(at_Cod_grado;$at_exploded{3})
							APPEND TO ARRAY:C911(at_Fecha;$at_exploded{4})
							
							Case of 
								: ($al_cod_respuesta_asist{$i}=0)
									APPEND TO ARRAY:C911(at_Detalle;"Proceso nunca ejecutado")
								: ($al_cod_respuesta_asist{$i}=1)
									APPEND TO ARRAY:C911(at_Detalle;"Envío ejecutado exitosamente ("+$at_cod_envio_asist{$i}+") "+$at_envio_asist_msg{$i})
								: ($al_cod_respuesta_asist{$i}=2)
									APPEND TO ARRAY:C911(at_Detalle;"Error de validación de negocio. "+$at_cod_envio_asist{$i}+". "+$at_envio_asist_msg{$i})  //cuando el código de respuesta es 2 guardo el detalle del error aquí...
								: ($al_cod_respuesta_asist{$i}=3)
									APPEND TO ARRAY:C911(at_Detalle;"RBD NO tiene Servicio Disponible")
								: ($al_cod_respuesta_asist{$i}=4)
									APPEND TO ARRAY:C911(at_Detalle;"Convenio NO tiene RBD asociado")
								: ($al_cod_respuesta_asist{$i}=5)
									APPEND TO ARRAY:C911(at_Detalle;"Servicio NO disponible")
								: ($al_cod_respuesta_asist{$i}=7)
									APPEND TO ARRAY:C911(at_Detalle;"Error interno del servicio")
							End case 
							
						End if 
						
					End if 
					
				End for 
				
		End case 
		
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->at_key_asistencia;->al_cod_respuesta_asist;->al_cod_envio_asist;->al_cod_envio_asist_resp;->at_error_envio_asist_resp)
		PREF_SetBlob (0;"SIGE_ASISTENCIA_"+String:C10(<>gyear);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
End case 

C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;->at_opc;->al_num_opc;->ab_status;->at_ultima_ejec)
PREF_SetBlob (0;"SIGE_LOG_"+String:C10(<>gyear);xBlob)
SET BLOB SIZE:C606(xBlob;0)