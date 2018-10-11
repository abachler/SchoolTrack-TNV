//%attributes = {}
C_TEXT:C284($ruta_archivo;$msg_alerta)

CONFIRM:C162("Recuerde que su archivo de GPUnits debe contar con las siguientes columnas: N.Lec, Grupo, Profesor, Materia, Aula espec, día, hora. Por favor revise esto antes de continuar";"Continuar";"Cancelar")

If (OK=1)
	
	$ruta_archivo:=xfGetFileName ("Seleccione el archivo a importar")
	
	If ($ruta_archivo#"")
		
		If (SYS_IsWindows )
			USE CHARACTER SET:C205("windows-1252";1)
		Else 
			USE CHARACTER SET:C205("MacRoman";1)
		End if 
		
		READ ONLY:C145([Asignaturas:18])
		
		  //array cargados con archivo 
		ARRAY TEXT:C222(at_ar_curso;0)
		ARRAY TEXT:C222(at_ar_profe;0)
		ARRAY TEXT:C222(at_ar_materia;0)
		ARRAY TEXT:C222(at_ar_Aula;0)
		ARRAY INTEGER:C220(ai_ar_dia;0)
		ARRAY INTEGER:C220(ai_ar_hora;0)
		  //arrays cargados con info ST 
		ARRAY LONGINT:C221(al_id_asig;0)
		ARRAY TEXT:C222(at_lineas;0)
		ARRAY TEXT:C222(at_msg_import;0)
		
		  //array para menu de selección de asignaturas 
		ARRAY TEXT:C222(at_asignom;0)
		ARRAY TEXT:C222(at_asigcurso;0)
		ARRAY LONGINT:C221(al_asignum;0)
		ARRAY INTEGER:C220(al_asigsexo;0)
		ARRAY TEXT:C222(at_profesor;0)
		ARRAY TEXT:C222(at_abrev;0)
		ARRAY TEXT:C222(at_sexo;0)
		APPEND TO ARRAY:C911(at_sexo;"Ambos")
		APPEND TO ARRAY:C911(at_sexo;"Femenino")
		APPEND TO ARRAY:C911(at_sexo;"Masculino")
		
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([TMT_Horario:166])
		READ ONLY:C145([Asignaturas_RegistroSesiones:168])
		C_DATE:C307($vdDesde;$vdHasta)
		C_TEXT:C284($text;$delimiter;$curso;$sexo;$msg_imp;$msg_reemplazo_archivo;$msg_conflicto;$t_denominacionInterna_IMP;$t_cursoasig_IMP)
		C_LONGINT:C283($indice;$resp;$numeroNivel;$i;$x;$nivel_AsigIMP;$abloque;$seleccionSexo_AsigIMP;$vl_resp)
		C_TIME:C306($ref)
		C_BOOLEAN:C305($reemplazo;$seleccion_AsigIMP;$reemplazar_bloques)
		$reemplazar_bloques:=True:C214  //por ahora asi despues daré lña opción de consultar
		$delimiter:=ACTabc_DetectDelimiter ($ruta_archivo)
		$ref:=Open document:C264($ruta_archivo;"";Read mode:K24:5)
		
		RECEIVE PACKET:C104($ref;$text;$delimiter)  //saltamos encabezados 
		RECEIVE PACKET:C104($ref;$text;$delimiter)  //tomamos la primera linea 
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Leyendo archivo..."))
		
		While ($text#"")
			$curso:=Replace string:C233(ST_GetWord ($text;2;",");"\"";"";*)
			$curso:=Insert string:C231($curso;"-";Length:C16($curso))
			
			APPEND TO ARRAY:C911(at_lineas;$text)
			
			APPEND TO ARRAY:C911(at_ar_curso;$curso)
			APPEND TO ARRAY:C911(at_ar_profe;Replace string:C233(ST_GetWord ($text;3;",");"\"";"";*))
			APPEND TO ARRAY:C911(at_ar_materia;Replace string:C233(ST_GetWord ($text;4;",");"\"";"";*))
			APPEND TO ARRAY:C911(at_ar_Aula;Replace string:C233(ST_GetWord ($text;5;",");"\"";"";*))
			APPEND TO ARRAY:C911(ai_ar_dia;Num:C11(ST_GetWord ($text;6;",")))
			APPEND TO ARRAY:C911(ai_ar_hora;Num:C11(ST_GetWord ($text;7;",")))
			APPEND TO ARRAY:C911(al_id_asig;0)
			
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479($ruta_archivo))
		End while 
		USE CHARACTER SET:C205(*;1)
		CLOSE DOCUMENT:C267($ref)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		  //buscando las asignaturas a las que pertenecen los bloques
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"buscando asignaturas...")
		For ($indice;1;Size of array:C274(at_ar_curso))
			
			$reemplazo:=False:C215
			$curso:=at_ar_curso{$indice}
			
			If ((at_ar_curso{$indice}#"") & (at_ar_materia{$indice}#"") & (al_id_asig{$indice}=0))
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=at_ar_curso{$indice};*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Abreviación:26=at_ar_materia{$indice})
				
				Case of 
					: (Records in selection:C76([Asignaturas:18])=1)
						al_id_asig{$indice}:=[Asignaturas:18]Numero:1
						
					: (Records in selection:C76([Asignaturas:18])>1)
						CREATE SET:C116([Asignaturas:18];"ASIGENCONTRADAS")
						QUERY SELECTION WITH ARRAY:C1050([Asignaturas:18]Numero:1;al_id_asig)
						CREATE SET:C116([Asignaturas:18];"ASIGSELECCIONADAS")
						DIFFERENCE:C122("ASIGENCONTRADAS";"ASIGSELECCIONADAS";"ASIGENCONTRADAS")
						USE SET:C118("ASIGENCONTRADAS")
						If (Records in selection:C76([Asignaturas:18])>0)
							ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
							SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;at_asignom;[Asignaturas:18]Curso:5;at_asigcurso;[Asignaturas:18]Numero:1;al_asignum;[Asignaturas:18]Seleccion_por_sexo:24;al_asigsexo;[Asignaturas:18]profesor_nombre:13;at_profesor;[Asignaturas:18]Abreviación:26;at_abrev)
							APPEND TO ARRAY:C911(at_asignom;"Sin Asignatura")
							APPEND TO ARRAY:C911(at_asigcurso;"")
							APPEND TO ARRAY:C911(al_asignum;-1)
							APPEND TO ARRAY:C911(al_asigsexo;0)
							APPEND TO ARRAY:C911(at_profesor;"")
							APPEND TO ARRAY:C911(at_abrev;"")
							
							SET_ClearSets ("ASIGENCONTRADAS";"ASIGSELECCIONADAS")
							For ($i;1;Size of array:C274(at_asignom))
								at_asignom{$i}:=at_asignom{$i}+" - "+at_asigcurso{$i}+" ("+at_sexo{al_asigsexo{$i}}+") "+at_profesor{$i}
							End for 
							CD_Dlog (0;"La asignatura "+at_ar_materia{$indice}+" del curso "+at_ar_curso{$indice}+" tiene más de un resultado dentro de SchoolTrack, seleccionela del listado de las asignaturas del nivel")
							SRtbl_ShowChoiceList (0;"¿Qué es? "+at_ar_materia{$indice}+", "+at_ar_curso{$indice}+", "+at_ar_profe{$indice};2;->at_asignom;False:C215;->at_asignom)
							If (choiceidx>0)
								al_id_asig{$indice}:=al_asignum{choiceidx}
								$reemplazo:=True:C214
							End if 
						End if 
						
					: (Records in selection:C76([Asignaturas:18])=0)
						$numeroNivel:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$curso;->[Cursos:3]Nivel_Numero:7)
						If ($numeroNivel#0)
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$numeroNivel)
							CREATE SET:C116([Asignaturas:18];"ASIGENCONTRADAS")
							QUERY SELECTION WITH ARRAY:C1050([Asignaturas:18]Numero:1;al_id_asig)
							CREATE SET:C116([Asignaturas:18];"ASIGSELECCIONADAS")
							DIFFERENCE:C122("ASIGENCONTRADAS";"ASIGSELECCIONADAS";"ASIGENCONTRADAS")
							USE SET:C118("ASIGENCONTRADAS")
							If (Records in selection:C76([Asignaturas:18])>0)
								ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
								SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;at_asignom;[Asignaturas:18]Curso:5;at_asigcurso;[Asignaturas:18]Numero:1;al_asignum;[Asignaturas:18]Seleccion_por_sexo:24;al_asigsexo;[Asignaturas:18]profesor_nombre:13;at_profesor;[Asignaturas:18]Abreviación:26;at_abrev)
								APPEND TO ARRAY:C911(at_asignom;"Sin Asignatura")
								APPEND TO ARRAY:C911(at_asigcurso;"")
								APPEND TO ARRAY:C911(al_asignum;-1)
								APPEND TO ARRAY:C911(al_asigsexo;0)
								APPEND TO ARRAY:C911(at_profesor;"")
								APPEND TO ARRAY:C911(at_abrev;"")
								
								SET_ClearSets ("ASIGENCONTRADAS";"ASIGSELECCIONADAS")
								For ($i;1;Size of array:C274(at_asignom))
									at_asignom{$i}:=at_asignom{$i}+" - "+at_asigcurso{$i}+" ("+at_sexo{al_asigsexo{$i}}+") "+at_profesor{$i}
								End for 
								CD_Dlog (0;"La asignatura "+at_ar_materia{$indice}+" del curso "+at_ar_curso{$indice}+" - "+at_ar_profe{$indice}+" no existe dentro de SchoolTrack, seleccionela del listado de las asignaturas del nivel")
								SRtbl_ShowChoiceList (0;"¿Qué es? "+at_ar_materia{$indice}+", "+at_ar_curso{$indice}+", "+at_ar_profe{$indice};2;->at_asignom;False:C215;->at_asignom)
								If (choiceidx>0)
									al_id_asig{$indice}:=al_asignum{choiceidx}
									$reemplazo:=True:C214
								End if 
							End if 
						End if 
				End case 
				
				If ($reemplazo)
					If (al_asignum{choiceidx}>0)  //si es menor es por que selecciono sin asignatura
						$msg_reemplazo_archivo:=$msg_reemplazo_archivo+at_ar_materia{$indice}+", "+at_ar_curso{$indice}+", "+at_ar_profe{$indice}+" - pasa a ser: "+at_abrev{choiceidx}+", "+at_asigcurso{choiceidx}+", "+at_ar_profe{$indice}+"\r"
					End if 
					$abrev:=at_ar_materia{$indice}
					$profe:=at_ar_profe{$indice}
					$curso:=at_ar_curso{$indice}
					
					For ($x;$indice;Size of array:C274(at_ar_materia))
						If (($abrev=at_ar_materia{$x}) & ($curso=at_ar_curso{$x}) & ($profe=at_ar_profe{$x}))
							al_id_asig{$x}:=al_asignum{choiceidx}
							If (al_id_asig{$x}>0)
								at_ar_materia{$x}:=at_abrev{choiceidx}
								at_ar_curso{$x}:=at_asigcurso{choiceidx}
							End if 
						End if 
					End for 
				End if 
			End if 
			
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/Size of array:C274(at_ar_curso))
		End for 
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		
		
		C_LONGINT:C283($i;$id_sala;$nonivel;$id_asignatura;$x)
		C_BOOLEAN:C305($vb_importar)
		C_TEXT:C284($nivel;$curso;$msg_imp)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Creando horario...")
		For ($i;1;Size of array:C274(al_id_asig))
			
			$vb_importar:=True:C214
			$msg_imp:=""
			$vdDesde:=!00-00-00!
			$id_asignatura:=al_id_asig{$i}
			
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(al_id_asig);"bloque "+String:C10(ai_ar_hora{$i})+" día "+String:C10(ai_ar_dia{$i})+", "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]denominacion_interna:16))
			
			If ($id_asignatura>0)
				
				$curso:=at_ar_curso{$i}
				$nonivel:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]Numero_del_Nivel:6)
				$nivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nonivel;->[xxSTR_Niveles:6]Nivel:1)
				
				$id_sala:=0
				
				If (at_ar_Aula{$i}#"")  //revisar la sala si viene en el registro 
					
					READ ONLY:C145([TMT_Salas:167])
					QUERY:C277([TMT_Salas:167];[TMT_Salas:167]NombreSala:2=at_ar_Aula{$i})
					
					If (Records in selection:C76([TMT_Salas:167])=0)
						READ WRITE:C146([ACT_Apoderados_de_Cuenta:107])
						CREATE RECORD:C68([TMT_Salas:167])
						[TMT_Salas:167]NombreSala:2:=at_ar_Aula{$i}
						SAVE RECORD:C53([TMT_Salas:167])
						$id_sala:=[TMT_Salas:167]ID_Sala:1
						KRL_UnloadReadOnly (->[TMT_Salas:167])
					Else 
						$id_sala:=[TMT_Salas:167]ID_Sala:1
						UNLOAD RECORD:C212([TMT_Salas:167])
					End if 
					
				End if 
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id_asignatura)
				$t_denominacionInterna_IMP:=[Asignaturas:18]denominacion_interna:16
				$t_cursoasig_IMP:=[Asignaturas:18]Curso:5
				$nivel_AsigIMP:=[Asignaturas:18]Numero_del_Nivel:6
				$seleccion_AsigIMP:=[Asignaturas:18]Seleccion:17
				$seleccionSexo_AsigIMP:=[Asignaturas:18]Seleccion_por_sexo:24
				
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@";*)
				QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50#"Promovido@")
				CREATE SET:C116([Alumnos:2];"ALUASIGIMPORT")
				
				  //buscar los bloques de la asignaturas correspondientes a las asignaturas del bloque que estoy tratando de meter.
				READ ONLY:C145([TMT_Horario:166])
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$nivel_AsigIMP)
				KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*))
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=ai_ar_dia{$i})
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2=ai_ar_hora{$i})
				
				ARRAY LONGINT:C221($al_BloqueDestino;0)
				LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_BloqueDestino;"")
				ARRAY LONGINT:C221($al_idAsigBloqueConflicto;0)
				
				For ($abloque;1;Size of array:C274($al_BloqueDestino))
					
					GOTO RECORD:C242([TMT_Horario:166];$al_BloqueDestino{$abloque})
					APPEND TO ARRAY:C911($al_idAsigBloqueConflicto;[TMT_Horario:166]ID_Asignatura:5)
					
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[TMT_Horario:166]ID_Asignatura:5)
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@";*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50#"Promovido@")
					CREATE SET:C116([Alumnos:2];"ALUASIGHORARIO")
					
					CREATE EMPTY SET:C140([Alumnos:2];"ALUCONFLICTO")
					INTERSECTION:C121("ALUASIGIMPORT";"ALUASIGHORARIO";"ALUCONFLICTO")
					$vl_aluconflicto:=Records in set:C195("ALUCONFLICTO")
					
					If (($vl_aluconflicto>0) & ($id_asignatura#[TMT_Horario:166]ID_Asignatura:5))
						
						  //aqui hay que poner una alerta si elegimos poner una pregunta en vez de que trate de reemplazar cuando tiene un conflicto
						$msg_conflicto:="El dia "+<>atXS_DayNames{ai_ar_dia{$i}+1}+" a la hora "+String:C10(ai_ar_hora{$i})+" el importador quiere ingresar un bloque para "+$t_denominacionInterna_IMP+" "+$t_cursoasig_IMP
						$msg_conflicto:=$msg_conflicto+", pero existe un bloque activo de "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]denominacion_interna:16)+" "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Curso:5)
						$msg_conflicto:=$msg_conflicto+" con "+String:C10($vl_aluconflicto)+" alumnos en común. Si reemplaza el bloque existente quedará activo hasta hoy (si el bloque no tiene sesiones asociadas será eliminado)."
						$vl_resp:=CD_Dlog (0;$msg_conflicto;"";__ ("Reemplazar");__ ("Conservar"))
						
						If ($vl_resp=1)
							$reemplazar_bloques:=True:C214
						Else 
							$reemplazar_bloques:=False:C215
						End if 
						
						If ($reemplazar_bloques)
							
							READ WRITE:C146([TMT_Horario:166])
							GOTO RECORD:C242([TMT_Horario:166];$al_BloqueDestino{$abloque})
							QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[TMT_Horario:166]ID_Asignatura:5)
							If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
								[TMT_Horario:166]SesionesHasta:13:=Current date:C33(*)
								$vdDesde:=Current date:C33(*)
								SAVE RECORD:C53([TMT_Horario:166])
							Else 
								DELETE RECORD:C58([TMT_Horario:166])
							End if 
							
							KRL_UnloadReadOnly (->[TMT_Horario:166])
							
						End if 
						
					End if 
					CLEAR SET:C117("ALUASIGHORARIO")
					CLEAR SET:C117("ALUCONFLICTO")
				End for 
				CLEAR SET:C117("ALUASIGIMPORT")
				
				If (Find in array:C230($al_idAsigBloqueConflicto;$id_asignatura)>0)
					$vb_importar:=False:C215  //es por que el bloque para esta asignatura que viene en el archivo ya existe en el horario
				End if 
				
				If ($vb_importar)
					$nonivel:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]Numero_del_Nivel:6)
					PERIODOS_LoadData ($nonivel)
					If (ai_ar_hora{i}<=Size of array:C274(alSTR_Horario_Desde))
						If ($vdDesde=!00-00-00!)
							$vdDesde:=adSTR_Periodos_Desde{1}
						End if 
						$vdHasta:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
						READ WRITE:C146([TMT_Horario:166])
						CREATE RECORD:C68([TMT_Horario:166])
						[TMT_Horario:166]Curso:11:=at_ar_curso{$i}
						[TMT_Horario:166]NumeroHora:2:=ai_ar_hora{$i}
						[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{[TMT_Horario:166]NumeroHora:2}
						[TMT_Horario:166]Hasta:4:=alSTR_Horario_Hasta{[TMT_Horario:166]NumeroHora:2}
						[TMT_Horario:166]ID_Asignatura:5:=$id_asignatura
						[TMT_Horario:166]ID_Sala:6:=$id_sala
						[TMT_Horario:166]ID_Teacher:9:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]profesor_numero:4)
						[TMT_Horario:166]Nivel:10:=$nonivel
						[TMT_Horario:166]No_Ciclo:14:=1
						[TMT_Horario:166]NumeroDia:1:=ai_ar_dia{$i}
						[TMT_Horario:166]Sala:8:=at_ar_Aula{$i}
						[TMT_Horario:166]SesionesDesde:12:=$vdDesde
						[TMT_Horario:166]SesionesHasta:13:=$vdHasta
						[TMT_Horario:166]TipoHora:16:=1
						SAVE RECORD:C53([TMT_Horario:166])
						KRL_ReloadAsReadOnly (->[TMT_Horario:166])
						TMT_CreaSesiones (Record number:C243([TMT_Horario:166]))
						KRL_UnloadReadOnly (->[TMT_Horario:166])
						$msg_imp:="Bloque importado, asignatura ID "+String:C10($id_asignatura)+" "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]denominacion_interna:16)+" "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]Curso:5)
					Else 
						$msg_imp:="Bloque No importado, asignatura ID "+String:C10($id_asignatura)+" "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]denominacion_interna:16)+" "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]Curso:5)+", bloque "+String:C10(ai_ar_hora{i})+" no existe en la configuración del horario dentro de la configuración de periodos para el nivel de la asignatura."
					End if 
				Else 
					$msg_imp:="Bloque No importado, asignatura ID "+String:C10($id_asignatura)+" "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]denominacion_interna:16)+" "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asignatura;->[Asignaturas:18]Curso:5)+", ya existía en el horario."
				End if 
				
			Else 
				$vb_importar:=False:C215
				$msg_imp:="Asignatura no encontrada"
			End if 
			
			APPEND TO ARRAY:C911(at_msg_import;at_lineas{$i}+" "+$msg_imp)
			
		End for 
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		If (Size of array:C274(at_msg_import)>0)
			C_TEXT:C284($ruta)
			$ruta:=xfGetDirName ("Seleccione una carpeta para detalle de la importación")
			
			If ($ruta#"")
				If (SYS_IsWindows )
					USE CHARACTER SET:C205("windows-1252";0)
				Else 
					USE CHARACTER SET:C205("MacRoman";0)
				End if 
				C_TIME:C306($docRef)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Creando archivo log...")
				$docRef:=Create document:C266($ruta+"Registro_de_Importacion.txt")
				For ($i;1;Size of array:C274(at_msg_import))
					IO_SendPacket ($docRef;at_msg_import{$i}+"\r")
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_msg_import))
				End for 
				CLOSE DOCUMENT:C267($docRef)
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				USE CHARACTER SET:C205(*;0)
			End if 
		End if 
		C_TEXT:C284($log_msg)
		
		CD_Dlog (0;"Fin de la importación")
		
	End if 
	
End if 
