//%attributes = {}
  // Método: SOPORTE_ImportaNotasConPromedio
  // código original de: ABK
  // modificado por Alberto Bachler Klein el 17/02/18, 15:42:25
  // - normalización, declaración de variables, limpieza
  // - eliminación de llamados innecesarios a metodos de inicialización
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_BLOB:C604($x_blobRecNumAlumnos)
C_BOOLEAN:C305($b_convertirA_EstiloOficial;$b_importarRegistro)
C_LONGINT:C283($el;$i;$l_caracteresProcesados;$l_IdAlumno;$l_IdAsignatura;$l_idCurso;$l_IdEstiloEvaluación;$l_IdEstiloOficial;$l_IdProcesoTherm;$l_IdProfesor)
C_LONGINT:C283($l_modoImpresionActas;$l_numeroFilaEnArchivo;$l_numeroListaEnCurso;$l_numeroNivel;$l_recNum;$l_registrosCreados;$l_registrosProcesados;$l_sinReprobacion;$l_tamañoDocumento)
C_TIME:C306($h_refArchivoErrores;$h_referenciaArchivoImportacion)
C_POINTER:C301($y_identificadorAlumno)
C_REAL:C285($r_nota;$r_nota0;$r_nota1;$r_nota2;$r_nota20;$r_nota21;$r_nota22;$r_nota23;$r_nota24;$r_nota25)
C_REAL:C285($r_nota26;$r_nota27;$r_nota28;$r_nota29;$r_nota3;$r_nota30;$r_nota31;$r_nota32;$r_nota33;$r_nota34)
C_REAL:C285($r_nota35;$r_nota36;$r_nota37;$r_nota38;$r_nota39;$r_nota4;$r_nota40;$r_nota41;$r_nota42;$r_nota43)
C_REAL:C285($r_nota44;$r_nota45;$r_nota46;$r_nota47;$r_nota48;$r_nota49;$r_nota5;$r_nota50;$r_nota51;$r_nota52)
C_REAL:C285($r_nota53;$r_nota54;$r_nota55;$r_nota56;$r_nota57;$r_nota58;$r_nota59;$r_nota6;$r_nota60;$r_nota7)
C_REAL:C285($r_nota8;$r_nota9;$r_notaControlPeriodo1;$r_notaControlPeriodo2;$r_notaControlPeriodo3;$r_notaControlPeriodo4;$r_notaControlPeriodo5;$r_notaExamen;$r_notaFinal;$r_notaFinalPeriodo1)
C_REAL:C285($r_notaFinalPeriodo2;$r_notaFinalPeriodo3;$r_notaFinalPeriodo4;$r_notaFinalPeriodo5;$r_notaPresentacion1;$r_notaPresentacion2;$r_notaPresentacion3;$r_notaPresentacion4;$r_notaPresentacion5;$r_notaPromedioFinal)
C_TEXT:C284($t_asignatura_y_curso;$t_llaveRegistroCalificaciones;$t_abreviaturaAsignatura;$t_codigoAsignatura;$t_cursoAlumno;$t_cursoAsignatura;$t_identificadorAlumno;$t_indentificadorProfesor;$t_nombreInternoAsignatura;$t_nombreNivel;$t_nombreOficialAsignatura)
C_TEXT:C284($t_nombreProfesor;$t_nombreProfesorFirmante;$t_observaciones1;$t_observaciones2;$t_observaciones3;$t_observaciones4;$t_observaciones5;$t_observacionesFinales;$t_observacionesP1;$t_observacionesP2)
C_TEXT:C284($t_observacionesP3;$t_observacionesP4;$t_observacionesP5;$t_origenDelArchivo;$t_registro;$t_rutaDocumento;$t_rutaLogErrores)

ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
ARRAY LONGINT:C221($al_recNumprofesores;0)
ARRAY TEXT:C222($at_asignaturasImportadas;0)
ARRAY TEXT:C222($at_erroresImportacion;0)
ARRAY TEXT:C222($at_camposEnRegistro;0)




If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;"Cualquier acción que afecte la situación académica de los alumnos ha sido bloquea"+"da a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+".")
Else 
	$b_importarRegistro:=True:C214
	Case of 
		: (Count parameters:C259>0)
			$y_identificadorAlumno:=$1
			$t_origenDelArchivo:=$2
			$t_rutaDocumento:=$3
		Else 
			$h_referenciaArchivoImportacion:=Open document:C264("";"*";Read mode:K24:5)
	End case 
	$l_tamañoDocumento:=Get document size:C479(document)
	
	If ($b_importarRegistro)
		TRACE:C157
		0xDev_AvoidTriggerExecution (True:C214)
		
		$l_IdProcesoTherm:=IT_UThermometer (1;0;"Normalizando identificador...")
		READ WRITE:C146([Alumnos:2])
		ALL RECORDS:C47([Alumnos:2])
		APPLY TO SELECTION:C70([Alumnos:2];$y_identificadorAlumno->:=ST_GetCleanString ($y_identificadorAlumno->))
		$l_IdProcesoTherm:=IT_UThermometer (-2;$l_IdProcesoTherm)
		
		If ($t_origenDelArchivo#"")
			If ($t_origenDelArchivo="Win")
				USE CHARACTER SET:C205("windows-1252";1)
			Else 
				USE CHARACTER SET:C205("MacRoman";1)
			End if 
		Else 
			If (SYS_IsWindows )
				USE CHARACTER SET:C205("windows-1252";1)
			Else 
				USE CHARACTER SET:C205("MacRoman";1)
			End if 
		End if 
		
		STR_LeeConfiguracion 
		EVS_ReadStyleData (-5)
		
		READ WRITE:C146([Asignaturas:18])
		$h_referenciaArchivoImportacion:=Open document:C264(document;"*";Read mode:K24:5)
		RECEIVE PACKET:C104($h_referenciaArchivoImportacion;$t_registro;"\r")
		
		$l_registrosCreados:=0
		$l_registrosProcesados:=0
		$l_caracteresProcesados:=0
		$l_numeroFilaEnArchivo:=0
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Importando registros de notas... ")
		While ((ok=1) & ($t_registro#"") & ($t_registro#Char:C90(10)))
			$l_numeroFilaEnArchivo:=$l_numeroFilaEnArchivo+1
			$l_caracteresProcesados:=$l_caracteresProcesados+Length:C16($t_registro)+1
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_caracteresProcesados/$l_tamañoDocumento;"Importando Registros de notas... ")
			AT_Text2Array (->$at_camposEnRegistro;$t_registro;"\t")
			ARRAY TEXT:C222($at_camposEnRegistro;93)
			$t_identificadorAlumno:=ST_GetCleanString ($at_camposEnRegistro{1})
			$l_numeroListaEnCurso:=Num:C11(ST_GetCleanString ($at_camposEnRegistro{2}))
			$t_codigoAsignatura:=ST_GetCleanString ($at_camposEnRegistro{3})
			$t_nombreOficialAsignatura:=ST_GetCleanString ($at_camposEnRegistro{4})
			$t_nombreInternoAsignatura:=ST_GetCleanString ($at_camposEnRegistro{5})
			$t_abreviaturaAsignatura:=ST_GetCleanString ($at_camposEnRegistro{6})
			$t_indentificadorProfesor:=ST_GetCleanString ($at_camposEnRegistro{7})
			$l_IdEstiloEvaluación:=Num:C11(ST_GetCleanString ($at_camposEnRegistro{8}))
			$t_cursoAsignatura:=Substring:C12(ST_GetCleanString ($at_camposEnRegistro{9});1;10)
			
			If ($l_IdEstiloEvaluación=0)
				$l_IdEstiloEvaluación:=-5
			End if 
			
			$b_importarRegistro:=True:C214
			Case of 
				: ($t_identificadorAlumno="")
					APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: Código de alumno inexistente"+"\t"+$t_registro)
					$b_importarRegistro:=False:C215
				: ($t_codigoAsignatura="")
					APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: Código de asignatura inexistente"+"\t"+$t_registro)
					$b_importarRegistro:=False:C215
			End case 
			
			If ($b_importarRegistro)
				If (Is nil pointer:C315($y_identificadorAlumno))
					QUERY:C277([Alumnos:2];[Alumnos:2]Codigo_interno:6=$t_identificadorAlumno)
					If (Records in selection:C76([Alumnos:2])=0)
						QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=$t_identificadorAlumno)
					End if 
				Else 
					QUERY:C277([Alumnos:2];$y_identificadorAlumno->=$t_identificadorAlumno)
				End if 
				Case of 
					: (Records in selection:C76([Alumnos:2])=0)
						APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: Alumno inexistente"+"\t"+$t_registro)
					: (Records in selection:C76([Alumnos:2])>1)
						APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: No existe correspondencia única con un alumno"+"\t"+$t_registro)
					: (Records in selection:C76([Alumnos:2])=1)
						$l_IdAlumno:=[Alumnos:2]numero:1
						$t_cursoAlumno:=[Alumnos:2]curso:20
						$l_numeroNivel:=[Alumnos:2]nivel_numero:29
						$t_nombreNivel:=[Alumnos:2]Nivel_Nombre:34
						
						QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
						$l_idCurso:=[Cursos:3]Numero_del_curso:6
						
						If ($t_indentificadorProfesor#"")
							QUERY:C277([Profesores:4];[Profesores:4]Codigo_interno:30=$t_indentificadorProfesor)
							If (Records in selection:C76([Profesores:4])=0)
								QUERY:C277([Profesores:4];[Profesores:4]RUT:27=$t_indentificadorProfesor)
							End if 
							$l_IdProfesor:=[Profesores:4]Numero:1
							$t_nombreProfesor:=[Profesores:4]Nombre_comun:21
							$t_nombreProfesorFirmante:=[Profesores:4]Apellidos_y_nombres:28
						Else 
							$l_IdProfesor:=0
							$t_nombreProfesor:=""
							$t_nombreProfesorFirmante:=""
						End if 
						
						  //creacion de la materia en plan de estudios (subsectores)
						QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Codigo:10=$t_codigoAsignatura)
						If (Records in selection:C76([xxSTR_Materias:20])=0)
							CREATE RECORD:C68([xxSTR_Materias:20])
							[xxSTR_Materias:20]ID_Materia:16:=SQ_SeqNumber (->[xxSTR_Materias:20]ID_Materia:16)
							[xxSTR_Materias:20]Orden interno:9:=0
							[xxSTR_Materias:20]Materia:2:=$t_nombreOficialAsignatura
							If ($t_nombreInternoAsignatura="")
								[xxSTR_Materias:20]Denominación_Interna:18:=$t_nombreOficialAsignatura
							Else 
								[xxSTR_Materias:20]Denominación_Interna:18:=$t_nombreInternoAsignatura
							End if 
							[xxSTR_Materias:20]Abreviatura:8:=$t_abreviaturaAsignatura
							[xxSTR_Materias:20]Codigo:10:=$t_codigoAsignatura
							[xxSTR_Materias:20]Materia:2:=ST_Format (->[xxSTR_Materias:20]Materia:2)
							[xxSTR_Materias:20]Denominación_Interna:18:=ST_Format (->[xxSTR_Materias:20]Denominación_Interna:18)
							SAVE RECORD:C53([xxSTR_Materias:20])
						End if 
						
						  //creacion de la asignatura
						If ($t_cursoAsignatura#"")
							QUERY:C277([Asignaturas:18];[Asignaturas:18]CHILE_CodigoMineduc:41=$t_codigoAsignatura;*)
							QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel;*)
							QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=$t_cursoAsignatura)
						Else 
							QUERY:C277([Asignaturas:18];[Asignaturas:18]CHILE_CodigoMineduc:41=$t_codigoAsignatura;*)
							QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel;*)
							QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=$t_cursoAlumno)
						End if 
						
						Case of 
							: (Records in selection:C76([Asignaturas:18])>1)
								$l_IdAsignatura:=0
								APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: No existe correspondencia única con una asignatura"+"\t"+$t_registro)
							: (Records in selection:C76([Asignaturas:18])=1)
								$l_IdAsignatura:=[Asignaturas:18]Numero:1
								If ([Asignaturas:18]Numero_de_EstiloEvaluacion:39=0)
									[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=$l_IdEstiloEvaluación
									SAVE RECORD:C53([Asignaturas:18])
								End if 
								$l_IdEstiloEvaluación:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
								Case of 
									: ($l_IdEstiloEvaluación#[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
										$l_IdAsignatura:=0
										APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: El estilo de evaluación asignado a la asignatura existente no corresponde"+" con el estilo de evaluación indicado en el archivo de importación."+"\t"+$t_registro)
										
									: ($l_IdEstiloEvaluación=0)
										$l_IdEstiloEvaluación:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
										
								End case 
								
								If (($l_IdProfesor#0) & ([Asignaturas:18]profesor_numero:4#$l_IdProfesor))
									[Asignaturas:18]profesor_numero:4:=$l_IdProfesor
									[Asignaturas:18]profesor_nombre:13:=$t_nombreProfesor
									[Asignaturas:18]profesor_firmante_numero:33:=$l_IdProfesor
									[Asignaturas:18]profesor_firmante_Nombre:34:=$t_nombreProfesorFirmante
									SAVE RECORD:C53([Asignaturas:18])
								End if 
								If (AS_PromediosSonCalculados )
									[Asignaturas:18]Resultado_no_calculado:47:=True:C214
									SAVE RECORD:C53([Asignaturas:18])
								End if 
								
							: (Records in selection:C76([Asignaturas:18])=0)
								If ($l_IdEstiloEvaluación=0)
									$l_IdEstiloEvaluación:=-5
								End if 
								CREATE RECORD:C68([Asignaturas:18])
								[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
								[Asignaturas:18]CHILE_CodigoMineduc:41:=[xxSTR_Materias:20]Codigo:10
								[Asignaturas:18]Asignatura:3:=[xxSTR_Materias:20]Materia:2
								[Asignaturas:18]denominacion_interna:16:=[xxSTR_Materias:20]Denominación_Interna:18
								[Asignaturas:18]Abreviación:26:=[xxSTR_Materias:20]Abreviatura:8
								[Asignaturas:18]Materia_UUID:46:=[xxSTR_Materias:20]Auto_UUID:21  //Asignatura, Materia Auto uuid
								[Asignaturas:18]Resultado_no_calculado:47:=True:C214
								If ($t_cursoAsignatura#"")
									[Asignaturas:18]Curso:5:=$t_cursoAsignatura
									[Asignaturas:18]Numero_del_Curso:25:=0
									[Asignaturas:18]Seleccion:17:=True:C214
								Else 
									[Asignaturas:18]Curso:5:=$t_cursoAlumno
									[Asignaturas:18]Numero_del_Curso:25:=$l_idCurso
									[Asignaturas:18]Seleccion:17:=False:C215
								End if 
								[Asignaturas:18]Seleccion_por_sexo:24:=1
								[Asignaturas:18]Nivel:30:=$t_nombreNivel
								[Asignaturas:18]Sector:9:=[xxSTR_Materias:20]Area:12
								[Asignaturas:18]Numero_del_Nivel:6:=$l_numeroNivel
								[Asignaturas:18]profesor_numero:4:=$l_IdProfesor
								[Asignaturas:18]profesor_nombre:13:=$t_nombreProfesor
								[Asignaturas:18]profesor_firmante_numero:33:=$l_IdProfesor
								[Asignaturas:18]profesor_firmante_Nombre:34:=$t_nombreProfesorFirmante
								[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=$l_IdEstiloEvaluación
								
								If ($t_nombreOficialAsignatura="Religi@")
									[Asignaturas:18]Incide_en_promedio:27:=False:C215
									[Asignaturas:18]Es_Optativa:70:=True:C214
									[Asignaturas:18]Incluida_en_Actas:44:=False:C215
								Else 
									[Asignaturas:18]Incide_en_promedio:27:=True:C214
									[Asignaturas:18]Es_Optativa:70:=False:C215
									[Asignaturas:18]Incluida_en_Actas:44:=True:C214
								End if 
								[Asignaturas:18]IncideEnPromedioInterno:64:=True:C214
								[Asignaturas:18]Numero_de_evaluaciones:38:=12
								[Asignaturas:18]En_InformesInternos:14:=True:C214
								[Asignaturas:18]Publicar_en_SchoolNet:60:=[Asignaturas:18]Publicar_en_SchoolNet:60 ?+ 0
								[Asignaturas:18]Publicar_en_SchoolNet:60:=[Asignaturas:18]Publicar_en_SchoolNet:60 ?+ 1
								SAVE RECORD:C53([Asignaturas:18])
								$l_IdAsignatura:=[Asignaturas:18]Numero:1
						End case 
						
						If ($l_IdAsignatura#0)
							$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluación)
							Case of 
								: ($l_recNum<0)
									$l_IdAsignatura:=0
									APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: Estilo de evaluación inexistente"+"\t"+$t_registro)
							End case 
						End if 
						
						If ($l_IdAsignatura#0)
							EVS_ReadStyleData ($l_IdEstiloEvaluación)
							AT_Inc (0)
							AT_Inc (9)
							
							$r_notaPromedioFinal:=NTA_StringValue2Percent ($at_camposEnRegistro{10})
							$r_notaExamen:=NTA_StringValue2Percent ($at_camposEnRegistro{11})
							$r_notaFinal:=NTA_StringValue2Percent ($at_camposEnRegistro{12})
							$r_nota1:=NTA_StringValue2Percent ($at_camposEnRegistro{13})
							$r_nota2:=NTA_StringValue2Percent ($at_camposEnRegistro{14})
							$r_nota3:=NTA_StringValue2Percent ($at_camposEnRegistro{15})
							$r_nota4:=NTA_StringValue2Percent ($at_camposEnRegistro{16})
							$r_nota5:=NTA_StringValue2Percent ($at_camposEnRegistro{17})
							$r_nota6:=NTA_StringValue2Percent ($at_camposEnRegistro{18})
							$r_nota7:=NTA_StringValue2Percent ($at_camposEnRegistro{19})
							$r_nota8:=NTA_StringValue2Percent ($at_camposEnRegistro{20})
							$r_nota9:=NTA_StringValue2Percent ($at_camposEnRegistro{21})
							$r_nota10:=NTA_StringValue2Percent ($at_camposEnRegistro{22})
							$r_nota11:=NTA_StringValue2Percent ($at_camposEnRegistro{23})
							$r_nota12:=NTA_StringValue2Percent ($at_camposEnRegistro{24})
							$r_notaPresentacion1:=NTA_StringValue2Percent ($at_camposEnRegistro{25})
							$r_notaControlPeriodo1:=NTA_StringValue2Percent ($at_camposEnRegistro{26})
							$r_notaFinalPeriodo1:=NTA_StringValue2Percent ($at_camposEnRegistro{27})
							$r_nota13:=NTA_StringValue2Percent ($at_camposEnRegistro{28})
							$r_nota14:=NTA_StringValue2Percent ($at_camposEnRegistro{29})
							$r_nota15:=NTA_StringValue2Percent ($at_camposEnRegistro{30})
							$r_nota16:=NTA_StringValue2Percent ($at_camposEnRegistro{31})
							$r_nota17:=NTA_StringValue2Percent ($at_camposEnRegistro{32})
							$r_nota18:=NTA_StringValue2Percent ($at_camposEnRegistro{33})
							$r_nota19:=NTA_StringValue2Percent ($at_camposEnRegistro{34})
							$r_nota20:=NTA_StringValue2Percent ($at_camposEnRegistro{35})
							$r_nota21:=NTA_StringValue2Percent ($at_camposEnRegistro{36})
							$r_nota22:=NTA_StringValue2Percent ($at_camposEnRegistro{37})
							$r_nota23:=NTA_StringValue2Percent ($at_camposEnRegistro{38})
							$r_nota24:=NTA_StringValue2Percent ($at_camposEnRegistro{39})
							$r_notaPresentacion2:=NTA_StringValue2Percent ($at_camposEnRegistro{40})
							$r_notaControlPeriodo2:=NTA_StringValue2Percent ($at_camposEnRegistro{41})
							$r_notaFinalPeriodo2:=NTA_StringValue2Percent ($at_camposEnRegistro{42})
							$r_nota25:=NTA_StringValue2Percent ($at_camposEnRegistro{43})
							$r_nota26:=NTA_StringValue2Percent ($at_camposEnRegistro{44})
							$r_nota27:=NTA_StringValue2Percent ($at_camposEnRegistro{45})
							$r_nota28:=NTA_StringValue2Percent ($at_camposEnRegistro{46})
							$r_nota29:=NTA_StringValue2Percent ($at_camposEnRegistro{47})
							$r_nota30:=NTA_StringValue2Percent ($at_camposEnRegistro{48})
							$r_nota31:=NTA_StringValue2Percent ($at_camposEnRegistro{49})
							$r_nota32:=NTA_StringValue2Percent ($at_camposEnRegistro{50})
							$r_nota33:=NTA_StringValue2Percent ($at_camposEnRegistro{51})
							$r_nota34:=NTA_StringValue2Percent ($at_camposEnRegistro{52})
							$r_nota35:=NTA_StringValue2Percent ($at_camposEnRegistro{53})
							$r_nota36:=NTA_StringValue2Percent ($at_camposEnRegistro{54})
							$r_notaPresentacion3:=NTA_StringValue2Percent ($at_camposEnRegistro{55})
							$r_notaControlPeriodo3:=NTA_StringValue2Percent ($at_camposEnRegistro{56})
							$r_notaFinalPeriodo3:=NTA_StringValue2Percent ($at_camposEnRegistro{57})
							$r_nota37:=NTA_StringValue2Percent ($at_camposEnRegistro{58})
							$r_nota38:=NTA_StringValue2Percent ($at_camposEnRegistro{59})
							$r_nota39:=NTA_StringValue2Percent ($at_camposEnRegistro{60})
							$r_nota40:=NTA_StringValue2Percent ($at_camposEnRegistro{61})
							$r_nota41:=NTA_StringValue2Percent ($at_camposEnRegistro{62})
							$r_nota42:=NTA_StringValue2Percent ($at_camposEnRegistro{63})
							$r_nota43:=NTA_StringValue2Percent ($at_camposEnRegistro{64})
							$r_nota44:=NTA_StringValue2Percent ($at_camposEnRegistro{65})
							$r_nota45:=NTA_StringValue2Percent ($at_camposEnRegistro{66})
							$r_nota46:=NTA_StringValue2Percent ($at_camposEnRegistro{67})
							$r_nota47:=NTA_StringValue2Percent ($at_camposEnRegistro{68})
							$r_nota48:=NTA_StringValue2Percent ($at_camposEnRegistro{69})
							$r_notaPresentacion4:=NTA_StringValue2Percent ($at_camposEnRegistro{70})
							$r_notaControlPeriodo4:=NTA_StringValue2Percent ($at_camposEnRegistro{71})
							$r_notaFinalPeriodo4:=NTA_StringValue2Percent ($at_camposEnRegistro{72})
							$r_nota49:=NTA_StringValue2Percent ($at_camposEnRegistro{73})
							$r_nota50:=NTA_StringValue2Percent ($at_camposEnRegistro{74})
							$r_nota51:=NTA_StringValue2Percent ($at_camposEnRegistro{75})
							$r_nota52:=NTA_StringValue2Percent ($at_camposEnRegistro{76})
							$r_nota53:=NTA_StringValue2Percent ($at_camposEnRegistro{77})
							$r_nota54:=NTA_StringValue2Percent ($at_camposEnRegistro{78})
							$r_nota55:=NTA_StringValue2Percent ($at_camposEnRegistro{79})
							$r_nota56:=NTA_StringValue2Percent ($at_camposEnRegistro{80})
							$r_nota57:=NTA_StringValue2Percent ($at_camposEnRegistro{81})
							$r_nota58:=NTA_StringValue2Percent ($at_camposEnRegistro{82})
							$r_nota59:=NTA_StringValue2Percent ($at_camposEnRegistro{83})
							$r_nota60:=NTA_StringValue2Percent ($at_camposEnRegistro{84})
							$r_notaPresentacion5:=NTA_StringValue2Percent ($at_camposEnRegistro{85})
							$r_notaControlPeriodo5:=NTA_StringValue2Percent ($at_camposEnRegistro{86})
							$r_notaFinalPeriodo5:=NTA_StringValue2Percent ($at_camposEnRegistro{87})
							
							$t_observacionesP1:=$at_camposEnRegistro{88}
							$t_observacionesP2:=$at_camposEnRegistro{89}
							$t_observacionesP3:=$at_camposEnRegistro{90}
							$t_observacionesP4:=$at_camposEnRegistro{91}
							$t_observacionesP5:=$at_camposEnRegistro{92}
							$t_observacionesFinales:=$at_camposEnRegistro{93}
							
							KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura)
							APPEND TO ARRAY:C911($al_RecNumAsignaturas;Record number:C243([Asignaturas:18]))
							
							AS_CreaRegistrosEvaluacion ($l_IdAlumno;$l_IdAsignatura)
							$t_llaveRegistroCalificaciones:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->$l_numeroNivel;->$l_IdAsignatura;->$l_IdAlumno)
							KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveRegistroCalificaciones;True:C214)
							
							[Alumnos_Calificaciones:208]P01_Eval01_Real:42:=$r_nota1
							[Alumnos_Calificaciones:208]P01_Eval02_Real:47:=$r_nota2
							[Alumnos_Calificaciones:208]P01_Eval03_Real:52:=$r_nota3
							[Alumnos_Calificaciones:208]P01_Eval04_Real:57:=$r_nota4
							[Alumnos_Calificaciones:208]P01_Eval05_Real:62:=$r_nota5
							[Alumnos_Calificaciones:208]P01_Eval06_Real:67:=$r_nota6
							[Alumnos_Calificaciones:208]P01_Eval07_Real:72:=$r_nota7
							[Alumnos_Calificaciones:208]P01_Eval08_Real:77:=$r_nota8
							[Alumnos_Calificaciones:208]P01_Eval09_Real:82:=$r_nota9
							[Alumnos_Calificaciones:208]P01_Eval10_Real:87:=$r_nota10
							[Alumnos_Calificaciones:208]P01_Eval11_Real:92:=$r_nota11
							[Alumnos_Calificaciones:208]P01_Eval12_Real:97:=$r_nota12
							[Alumnos_Calificaciones:208]P01_Presentacion_Real:102:=$r_notaPresentacion1
							[Alumnos_Calificaciones:208]P01_Control_Real:107:=$r_notaControlPeriodo1
							[Alumnos_Calificaciones:208]P01_Final_Real:112:=$r_notaFinalPeriodo1
							
							[Alumnos_Calificaciones:208]P02_Eval01_Real:117:=$r_nota13
							[Alumnos_Calificaciones:208]P02_Eval02_Real:122:=$r_nota14
							[Alumnos_Calificaciones:208]P02_Eval03_Real:127:=$r_nota15
							[Alumnos_Calificaciones:208]P02_Eval04_Real:132:=$r_nota16
							[Alumnos_Calificaciones:208]P02_Eval05_Real:137:=$r_nota17
							[Alumnos_Calificaciones:208]P02_Eval06_Real:142:=$r_nota18
							[Alumnos_Calificaciones:208]P02_Eval07_Real:147:=$r_nota19
							[Alumnos_Calificaciones:208]P02_Eval08_Real:152:=$r_nota20
							[Alumnos_Calificaciones:208]P02_Eval09_Real:157:=$r_nota21
							[Alumnos_Calificaciones:208]P02_Eval10_Real:162:=$r_nota22
							[Alumnos_Calificaciones:208]P02_Eval11_Real:167:=$r_nota23
							[Alumnos_Calificaciones:208]P02_Eval12_Real:172:=$r_nota24
							[Alumnos_Calificaciones:208]P02_Presentacion_Real:177:=$r_notaPresentacion2
							[Alumnos_Calificaciones:208]P02_Control_Real:182:=$r_notaControlPeriodo2
							[Alumnos_Calificaciones:208]P02_Final_Real:187:=$r_notaFinalPeriodo2
							
							[Alumnos_Calificaciones:208]P03_Eval01_Real:192:=$r_nota25
							[Alumnos_Calificaciones:208]P03_Eval02_Real:197:=$r_nota26
							[Alumnos_Calificaciones:208]P03_Eval03_Real:202:=$r_nota27
							[Alumnos_Calificaciones:208]P03_Eval04_Real:207:=$r_nota28
							[Alumnos_Calificaciones:208]P03_Eval05_Real:212:=$r_nota29
							[Alumnos_Calificaciones:208]P03_Eval06_Real:217:=$r_nota30
							[Alumnos_Calificaciones:208]P03_Eval07_Real:222:=$r_nota31
							[Alumnos_Calificaciones:208]P03_Eval08_Real:227:=$r_nota32
							[Alumnos_Calificaciones:208]P03_Eval09_Real:232:=$r_nota33
							[Alumnos_Calificaciones:208]P03_Eval10_Real:237:=$r_nota34
							[Alumnos_Calificaciones:208]P03_Eval11_Real:242:=$r_nota35
							[Alumnos_Calificaciones:208]P03_Eval12_Real:247:=$r_nota36
							[Alumnos_Calificaciones:208]P03_Presentacion_Real:252:=$r_notaPresentacion3
							[Alumnos_Calificaciones:208]P03_Control_Real:257:=$r_notaControlPeriodo3
							[Alumnos_Calificaciones:208]P03_Final_Real:262:=$r_notaFinalPeriodo3
							
							[Alumnos_Calificaciones:208]P04_Eval01_Real:267:=$r_nota37
							[Alumnos_Calificaciones:208]P04_Eval02_Real:272:=$r_nota38
							[Alumnos_Calificaciones:208]P04_Eval03_Real:277:=$r_nota39
							[Alumnos_Calificaciones:208]P04_Eval04_Real:282:=$r_nota40
							[Alumnos_Calificaciones:208]P04_Eval05_Real:287:=$r_nota41
							[Alumnos_Calificaciones:208]P04_Eval06_Real:292:=$r_nota42
							[Alumnos_Calificaciones:208]P04_Eval07_Real:297:=$r_nota43
							[Alumnos_Calificaciones:208]P04_Eval08_Real:302:=$r_nota44
							[Alumnos_Calificaciones:208]P04_Eval09_Real:307:=$r_nota45
							[Alumnos_Calificaciones:208]P04_Eval10_Real:312:=$r_nota46
							[Alumnos_Calificaciones:208]P04_Eval11_Real:317:=$r_nota47
							[Alumnos_Calificaciones:208]P04_Eval12_Real:322:=$r_nota48
							[Alumnos_Calificaciones:208]P04_Presentacion_Real:327:=$r_notaPresentacion4
							[Alumnos_Calificaciones:208]P04_Control_Real:332:=$r_notaControlPeriodo4
							[Alumnos_Calificaciones:208]P04_Final_Real:337:=$r_notaFinalPeriodo4
							
							[Alumnos_Calificaciones:208]P05_Eval01_Real:342:=$r_nota49
							[Alumnos_Calificaciones:208]P05_Eval02_Real:347:=$r_nota50
							[Alumnos_Calificaciones:208]P05_Eval03_Real:352:=$r_nota51
							[Alumnos_Calificaciones:208]P05_Eval04_Real:357:=$r_nota52
							[Alumnos_Calificaciones:208]P05_Eval05_Real:362:=$r_nota53
							[Alumnos_Calificaciones:208]P05_Eval06_Real:367:=$r_nota54
							[Alumnos_Calificaciones:208]P05_Eval07_Real:372:=$r_nota55
							[Alumnos_Calificaciones:208]P05_Eval08_Real:377:=$r_nota56
							[Alumnos_Calificaciones:208]P05_Eval09_Real:382:=$r_nota57
							[Alumnos_Calificaciones:208]P05_Eval10_Real:387:=$r_nota58
							[Alumnos_Calificaciones:208]P05_Eval11_Real:392:=$r_nota59
							[Alumnos_Calificaciones:208]P05_Eval12_Real:397:=$r_nota60
							[Alumnos_Calificaciones:208]P05_Presentacion_Real:402:=$r_notaPresentacion5
							[Alumnos_Calificaciones:208]P05_Control_Real:407:=$r_notaControlPeriodo5
							[Alumnos_Calificaciones:208]P05_Final_Real:412:=$r_notaFinalPeriodo5
							
							[Alumnos_Calificaciones:208]Anual_Real:11:=$r_notaPromedioFinal
							[Alumnos_Calificaciones:208]ExamenAnual_Real:16:=$r_notaExamen
							[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=$r_notaFinal
							
							EVS_ReadStyleData ($l_IdEstiloEvaluación)
							
							[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11)
							[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11)
							[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11)
							[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iEvaluationMode;vlNTA_DecimalesPF)
							
							[Alumnos_Calificaciones:208]ExamenAnual_Nota:17:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]ExamenAnual_Real:16)
							[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]ExamenAnual_Real:16)
							[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]ExamenAnual_Real:16)
							[Alumnos_Calificaciones:208]ExamenAnual_Literal:20:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;iEvaluationMode;vlNTA_DecimalesParciales)
							
							[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
							[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
							[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
							[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;iEvaluationMode;vlNTA_DecimalesNF)
							
							[Alumnos_Calificaciones:208]P01_Eval01_Literal:46:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval01_Real:42;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval01_Nota:43:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval01_Real:42;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval01_Puntos:44:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval01_Real:42;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval01_Simbolo:45:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval01_Real:42)
							
							[Alumnos_Calificaciones:208]P01_Eval02_Literal:51:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval02_Real:47;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval02_Nota:48:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval02_Real:47;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval02_Puntos:49:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval02_Real:47;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval02_Simbolo:50:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval02_Real:47)
							
							[Alumnos_Calificaciones:208]P01_Eval03_Literal:56:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval03_Real:52;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval03_Nota:53:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval03_Real:52;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval03_Puntos:54:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval03_Real:52;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval03_Simbolo:55:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval03_Real:52)
							
							[Alumnos_Calificaciones:208]P01_Eval04_Literal:61:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval04_Real:57;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval04_Nota:58:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval04_Real:57;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval04_Puntos:59:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval04_Real:57;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval04_Simbolo:60:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval04_Real:57)
							
							[Alumnos_Calificaciones:208]P01_Eval05_Literal:66:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval05_Real:62;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval05_Nota:63:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval05_Real:62;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval05_Puntos:64:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval05_Real:62;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval05_Simbolo:65:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval05_Real:62)
							
							[Alumnos_Calificaciones:208]P01_Eval06_Literal:71:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval06_Real:67;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval06_Nota:68:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval06_Real:67;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval06_Puntos:69:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval06_Real:67;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval06_Simbolo:70:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval06_Real:67)
							
							[Alumnos_Calificaciones:208]P01_Eval07_Literal:76:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval07_Real:72;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval07_Nota:73:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval07_Real:72;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval07_Puntos:74:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval07_Real:72;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval07_Simbolo:75:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval07_Real:72)
							
							[Alumnos_Calificaciones:208]P01_Eval08_Literal:81:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval08_Real:77;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval08_Nota:78:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval08_Real:77;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval08_Puntos:79:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval08_Real:77;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval08_Simbolo:80:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval08_Real:77)
							
							[Alumnos_Calificaciones:208]P01_Eval09_Literal:86:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval09_Real:82;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval09_Nota:83:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval09_Real:82;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval09_Puntos:84:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval09_Real:82;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval09_Simbolo:85:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval09_Real:82)
							
							[Alumnos_Calificaciones:208]P01_Eval10_Literal:91:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval10_Real:87;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval10_Nota:88:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval10_Real:87;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval10_Puntos:89:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval10_Real:87;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval10_Simbolo:90:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval10_Real:87)
							
							[Alumnos_Calificaciones:208]P01_Eval11_Literal:96:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval11_Real:92;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval11_Nota:93:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval11_Real:92;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval11_Puntos:94:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval11_Real:92;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval11_Simbolo:95:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval11_Real:92)
							
							[Alumnos_Calificaciones:208]P01_Eval12_Literal:101:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Eval12_Real:97;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P01_Eval12_Nota:98:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval12_Real:97;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval12_Puntos:99:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval12_Real:97;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval12_Simbolo:100:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval12_Real:97)
							
							[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;iEvaluationMode;vlNTA_DecimalesPP)
							If (vi_RoundCPpresent=1)
								[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;0;iGradesDecPP)
								[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;0;iPointsDecPP)
							Else 
								[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;0;11)
								[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;0;11)
							End if 
							[Alumnos_Calificaciones:208]P01_Presentacion_Simbolo:105:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102)
							
							[Alumnos_Calificaciones:208]P01_Control_Literal:111:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Control_Real:107;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P01_Control_Nota:108:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Control_Real:107;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Control_Puntos:109:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Control_Real:107;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Control_Simbolo:110:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Control_Real:107)
							
							[Alumnos_Calificaciones:208]P01_Final_Literal:116:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Final_Real:112;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P01_Final_Nota:113:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Final_Real:112;vi_gTrPAvg;iGradesDecPP)
							[Alumnos_Calificaciones:208]P01_Final_Puntos:114:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Final_Real:112;vi_gTrPAvg;iPointsDecPP)
							[Alumnos_Calificaciones:208]P01_Final_Simbolo:115:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Final_Real:112)
							
							  //2º período
							[Alumnos_Calificaciones:208]P02_Eval01_Literal:121:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval01_Real:117;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval01_Nota:118:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval01_Real:117;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval01_Puntos:119:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval01_Real:117;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval01_Simbolo:120:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval01_Real:117)
							
							[Alumnos_Calificaciones:208]P02_Eval02_Literal:126:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval02_Real:122;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval02_Nota:123:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval02_Real:122;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval02_Puntos:124:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval02_Real:122;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval02_Simbolo:125:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval02_Real:122)
							
							[Alumnos_Calificaciones:208]P02_Eval03_Literal:131:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval03_Real:127;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval03_Nota:128:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval03_Real:127;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval03_Puntos:129:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval03_Real:127;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval03_Simbolo:130:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval03_Real:127)
							
							[Alumnos_Calificaciones:208]P02_Eval04_Literal:136:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval04_Real:132;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval04_Nota:133:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval04_Real:132;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval04_Puntos:134:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval04_Real:132;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval04_Simbolo:135:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval04_Real:132)
							
							[Alumnos_Calificaciones:208]P02_Eval05_Literal:141:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval05_Real:137;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval05_Nota:138:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval05_Real:137;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval05_Puntos:139:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval05_Real:137;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval05_Simbolo:140:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval05_Real:137)
							
							[Alumnos_Calificaciones:208]P02_Eval06_Literal:146:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval06_Real:142;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval06_Nota:143:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval06_Real:142;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval06_Puntos:144:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval06_Real:142;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval06_Simbolo:145:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval06_Real:142)
							
							[Alumnos_Calificaciones:208]P02_Eval07_Literal:151:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval07_Real:147;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval07_Nota:148:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval07_Real:147;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval07_Puntos:149:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval07_Real:147;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval07_Simbolo:150:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval07_Real:147)
							
							[Alumnos_Calificaciones:208]P02_Eval08_Literal:156:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval08_Real:152;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval08_Nota:153:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval08_Real:152;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval08_Puntos:154:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval08_Real:152;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval08_Simbolo:155:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval08_Real:152)
							
							[Alumnos_Calificaciones:208]P02_Eval09_Literal:161:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval09_Real:157;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval09_Nota:158:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval09_Real:157;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval09_Puntos:159:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval09_Real:157;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval09_Simbolo:160:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval09_Real:157)
							
							[Alumnos_Calificaciones:208]P02_Eval10_Literal:166:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval10_Real:162;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval10_Nota:163:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval10_Real:162;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval10_Puntos:164:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval10_Real:162;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval10_Simbolo:165:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval10_Real:162)
							
							[Alumnos_Calificaciones:208]P02_Eval11_Literal:171:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval11_Real:167;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval11_Nota:168:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval11_Real:167;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval11_Puntos:169:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval11_Real:167;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval11_Simbolo:170:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval11_Real:167)
							
							[Alumnos_Calificaciones:208]P02_Eval12_Literal:176:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval12_Real:172;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P02_Eval12_Nota:173:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval12_Real:172;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval12_Puntos:174:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval12_Real:172)
							[Alumnos_Calificaciones:208]P02_Eval12_Simbolo:175:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval12_Real:172)
							
							[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;iEvaluationMode;vlNTA_DecimalesPP)
							If (vi_RoundCPpresent=1)
								[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;0;iGradesDecPP)
								[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;0;iPointsDecPP)
							Else 
								[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;0;11)
								[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;0;11)
							End if 
							[Alumnos_Calificaciones:208]P02_Presentacion_Simbolo:180:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177)
							
							[Alumnos_Calificaciones:208]P02_Control_Literal:186:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Control_Real:182;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P02_Control_Nota:183:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Control_Real:182;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Control_Puntos:184:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Control_Real:182;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Control_Simbolo:185:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Control_Real:182)
							
							[Alumnos_Calificaciones:208]P02_Final_Literal:191:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Final_Real:187;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P02_Final_Nota:188:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Final_Real:187;vi_gTrPAvg;iGradesDecPP)
							[Alumnos_Calificaciones:208]P02_Final_Puntos:189:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Final_Real:187;vi_gTrPAvg;iPointsDecPP)
							[Alumnos_Calificaciones:208]P02_Final_Simbolo:190:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Final_Real:187)
							
							  //3er período
							[Alumnos_Calificaciones:208]P03_Eval01_Literal:196:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval01_Real:192;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval01_Nota:193:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval01_Real:192;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval01_Puntos:194:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval01_Real:192;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval01_Simbolo:195:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval01_Real:192)
							
							[Alumnos_Calificaciones:208]P03_Eval02_Literal:201:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval02_Real:197;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval02_Nota:198:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval02_Real:197;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval02_Puntos:199:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval02_Real:197;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval02_Simbolo:200:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval02_Real:197)
							
							[Alumnos_Calificaciones:208]P03_Eval03_Literal:206:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval03_Real:202;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval03_Nota:203:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval03_Real:202;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval03_Puntos:204:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval03_Real:202;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval03_Simbolo:205:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval03_Real:202)
							
							[Alumnos_Calificaciones:208]P03_Eval04_Literal:211:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval04_Real:207;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval04_Nota:208:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval04_Real:207;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval04_Puntos:209:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval04_Real:207;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval04_Simbolo:210:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval04_Real:207)
							
							[Alumnos_Calificaciones:208]P03_Eval05_Literal:216:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval05_Real:212;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval05_Nota:213:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval05_Real:212;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval05_Puntos:214:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval05_Real:212;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval05_Simbolo:215:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval05_Real:212)
							
							[Alumnos_Calificaciones:208]P03_Eval06_Literal:221:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval06_Real:217;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval06_Nota:218:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval06_Real:217;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval06_Puntos:219:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval06_Real:217;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval06_Simbolo:220:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval06_Real:217)
							
							[Alumnos_Calificaciones:208]P03_Eval07_Literal:226:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval07_Real:222;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval07_Nota:223:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval07_Real:222;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval07_Puntos:224:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval07_Real:222;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval07_Simbolo:225:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval07_Real:222)
							
							[Alumnos_Calificaciones:208]P03_Eval08_Literal:231:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval08_Real:227;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval08_Nota:228:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval08_Real:227;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval08_Puntos:229:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval08_Real:227;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval08_Simbolo:230:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval08_Real:227)
							
							[Alumnos_Calificaciones:208]P03_Eval09_Literal:236:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval09_Real:232;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval09_Nota:233:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval09_Real:232;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval09_Puntos:234:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval09_Real:232;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval09_Simbolo:235:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval09_Real:232)
							
							[Alumnos_Calificaciones:208]P03_Eval10_Literal:241:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval10_Real:237;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval10_Nota:238:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval10_Real:237;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval10_Puntos:239:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval10_Real:237;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval10_Simbolo:240:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval10_Real:237)
							
							[Alumnos_Calificaciones:208]P03_Eval11_Literal:246:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval11_Real:242;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval11_Nota:243:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval11_Real:242;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval11_Puntos:244:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval11_Real:242;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval11_Simbolo:245:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval11_Real:242)
							
							[Alumnos_Calificaciones:208]P03_Eval12_Literal:251:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Eval12_Real:247;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P03_Eval12_Nota:248:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval12_Real:247;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval12_Puntos:249:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval12_Real:247;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval12_Simbolo:250:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval12_Real:247)
							
							[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;iEvaluationMode;vlNTA_DecimalesPP)
							If (vi_RoundCPpresent=1)
								[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;0;iGradesDecPP)
								[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;0;iPointsDecPP)
							Else 
								[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;0;11)
								[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;0;11)
							End if 
							[Alumnos_Calificaciones:208]P03_Presentacion_Simbolo:255:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252)
							
							[Alumnos_Calificaciones:208]P03_Control_Literal:261:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Control_Real:257;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P03_Control_Nota:258:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Control_Real:257;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Control_Puntos:259:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Control_Real:257;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Control_Simbolo:260:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Control_Real:257)
							
							[Alumnos_Calificaciones:208]P03_Final_Literal:266:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Final_Real:262;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P03_Final_Nota:263:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Final_Real:262;vi_gTrPAvg;iGradesDecPP)
							[Alumnos_Calificaciones:208]P03_Final_Puntos:264:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Final_Real:262;vi_gTrPAvg;iPointsDecPP)
							[Alumnos_Calificaciones:208]P03_Final_Simbolo:265:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Final_Real:262)
							
							  //4º período
							[Alumnos_Calificaciones:208]P04_Eval01_Literal:271:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval01_Real:267;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval01_Nota:268:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval01_Real:267;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval01_Puntos:269:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval01_Real:267;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval01_Simbolo:270:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval01_Real:267)
							
							[Alumnos_Calificaciones:208]P04_Eval02_Literal:276:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval02_Real:272;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval02_Nota:273:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval02_Real:272;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval02_Puntos:274:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval02_Real:272;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval02_Simbolo:275:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval02_Real:272)
							
							[Alumnos_Calificaciones:208]P04_Eval03_Literal:281:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval03_Real:277;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval03_Nota:278:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval03_Real:277;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval03_Puntos:279:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval03_Real:277;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval03_Simbolo:280:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval03_Real:277)
							
							[Alumnos_Calificaciones:208]P04_Eval04_Literal:286:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval04_Real:282;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval04_Nota:283:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval04_Real:282;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval04_Puntos:284:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval04_Real:282;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval04_Simbolo:285:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval04_Real:282)
							
							[Alumnos_Calificaciones:208]P04_Eval05_Literal:291:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval05_Real:287;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval05_Nota:288:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval05_Real:287;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval05_Puntos:289:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval05_Real:287;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval05_Simbolo:290:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval05_Real:287)
							
							[Alumnos_Calificaciones:208]P04_Eval06_Literal:296:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval06_Real:292;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval06_Nota:293:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval06_Real:292;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval06_Puntos:294:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval06_Real:292;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval06_Simbolo:295:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval06_Real:292)
							
							[Alumnos_Calificaciones:208]P04_Eval07_Literal:301:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval07_Real:297;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval07_Nota:298:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval07_Real:297;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval07_Puntos:299:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval07_Real:297;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval07_Simbolo:300:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval07_Real:297)
							
							[Alumnos_Calificaciones:208]P04_Eval08_Literal:306:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval08_Real:302;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval08_Nota:303:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval08_Real:302;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval08_Puntos:304:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval08_Real:302;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval08_Simbolo:305:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval08_Real:302)
							
							[Alumnos_Calificaciones:208]P04_Eval09_Literal:311:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval09_Real:307;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval09_Nota:308:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval09_Real:307;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval09_Puntos:309:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval09_Real:307;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval09_Simbolo:310:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval09_Real:307)
							
							[Alumnos_Calificaciones:208]P04_Eval10_Literal:316:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval10_Real:312;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval10_Nota:313:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval10_Real:312;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval10_Puntos:314:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval10_Real:312;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval10_Simbolo:315:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval10_Real:312)
							
							[Alumnos_Calificaciones:208]P04_Eval11_Literal:321:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval11_Real:317;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval11_Nota:318:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval11_Real:317;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval11_Puntos:319:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval11_Real:317;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval11_Simbolo:320:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval11_Real:317)
							
							[Alumnos_Calificaciones:208]P04_Eval12_Literal:326:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Eval12_Real:322;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P04_Eval12_Nota:323:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval12_Real:322;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval12_Puntos:324:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval12_Real:322;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval12_Simbolo:325:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval12_Real:322)
							
							[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;iEvaluationMode;vlNTA_DecimalesPP)
							If (vi_RoundCPpresent=1)
								[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;0;iGradesDecPP)
								[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;0;iPointsDecPP)
							Else 
								[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;0;11)
								[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;0;11)
							End if 
							[Alumnos_Calificaciones:208]P04_Presentacion_Simbolo:330:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327)
							
							[Alumnos_Calificaciones:208]P04_Control_Literal:336:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Control_Real:332;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P04_Control_Nota:333:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Control_Real:332;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Control_Puntos:334:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Control_Real:332;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Control_Simbolo:335:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Control_Real:332)
							
							[Alumnos_Calificaciones:208]P04_Final_Literal:341:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Final_Real:337;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P04_Final_Nota:338:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Final_Real:337;vi_gTrPAvg;iGradesDecPP)
							[Alumnos_Calificaciones:208]P04_Final_Puntos:339:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Final_Real:337;vi_gTrPAvg;iPointsDecPP)
							[Alumnos_Calificaciones:208]P04_Final_Simbolo:340:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Final_Real:337)
							
							  //5º período
							[Alumnos_Calificaciones:208]P05_Eval01_Literal:346:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval01_Real:342;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval01_Nota:343:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval01_Real:342;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval01_Puntos:344:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval01_Real:342;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval01_Simbolo:345:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval01_Real:342)
							
							[Alumnos_Calificaciones:208]P05_Eval02_Literal:351:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval02_Real:347;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval02_Nota:348:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval02_Real:347;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval02_Puntos:349:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval02_Real:347;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval02_Simbolo:350:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval02_Real:347)
							
							[Alumnos_Calificaciones:208]P05_Eval03_Literal:356:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval03_Real:352;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval03_Nota:353:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval03_Real:352;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval03_Puntos:354:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval03_Real:352;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval03_Simbolo:355:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval03_Real:352)
							
							[Alumnos_Calificaciones:208]P05_Eval04_Literal:361:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval04_Real:357;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval04_Nota:358:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval04_Real:357;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval04_Puntos:359:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval04_Real:357;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval04_Simbolo:360:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval04_Real:357)
							
							[Alumnos_Calificaciones:208]P05_Eval05_Literal:366:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval05_Real:362;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval05_Nota:363:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval05_Real:362;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval05_Puntos:364:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval05_Real:362;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval05_Simbolo:365:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval05_Real:362)
							
							[Alumnos_Calificaciones:208]P05_Eval06_Literal:371:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval06_Real:367;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval06_Nota:368:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval06_Real:367;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval06_Puntos:369:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval06_Real:367;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval06_Simbolo:370:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval06_Real:367)
							
							[Alumnos_Calificaciones:208]P05_Eval07_Literal:376:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval07_Real:372;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval07_Nota:373:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval07_Real:372;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval07_Puntos:374:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval07_Real:372;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval07_Simbolo:375:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval07_Real:372)
							
							[Alumnos_Calificaciones:208]P05_Eval08_Literal:381:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval08_Real:377;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval08_Nota:378:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval08_Real:377;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval08_Puntos:379:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval08_Real:377;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval08_Simbolo:380:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval08_Real:377)
							
							[Alumnos_Calificaciones:208]P05_Eval09_Literal:386:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval09_Real:382;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval09_Nota:383:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval09_Real:382;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval09_Puntos:384:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval09_Real:382;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval09_Simbolo:385:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval09_Real:382)
							
							[Alumnos_Calificaciones:208]P05_Eval10_Literal:391:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval10_Real:387;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval10_Nota:388:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval10_Real:387;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval10_Puntos:389:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval10_Real:387;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval10_Simbolo:390:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval10_Real:387)
							
							[Alumnos_Calificaciones:208]P05_Eval11_Literal:396:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval11_Real:392;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval11_Nota:393:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval11_Real:392;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval11_Puntos:394:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval11_Real:392;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval11_Simbolo:395:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval11_Real:392)
							
							[Alumnos_Calificaciones:208]P05_Eval12_Literal:401:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Eval12_Real:397;iEvaluationMode;vlNTA_DecimalesParciales)
							[Alumnos_Calificaciones:208]P05_Eval12_Nota:398:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval12_Real:397;vi_gTrPAvg;iGradesDecPP)
							[Alumnos_Calificaciones:208]P05_Eval12_Puntos:399:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval12_Real:397;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval12_Simbolo:400:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval12_Real:397)
							
							[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;iEvaluationMode;vlNTA_DecimalesPP)
							If (vi_RoundCPpresent=1)
								[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;0;iGradesDecPP)
								[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;0;iPointsDecPP)
							Else 
								[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;0;11)
								[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;0;11)
							End if 
							[Alumnos_Calificaciones:208]P05_Presentacion_Simbolo:405:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402)
							
							[Alumnos_Calificaciones:208]P05_Control_Literal:411:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Control_Real:407;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P05_Control_Nota:408:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Control_Real:407)
							[Alumnos_Calificaciones:208]P05_Control_Puntos:409:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Control_Real:407;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Control_Simbolo:410:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Control_Real:407)
							
							[Alumnos_Calificaciones:208]P05_Final_Literal:416:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Final_Real:412;iEvaluationMode;vlNTA_DecimalesPP)
							[Alumnos_Calificaciones:208]P05_Final_Nota:413:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Final_Real:412;vi_gTrPAvg;iGradesDecPP)
							[Alumnos_Calificaciones:208]P05_Final_Puntos:414:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Final_Real:412;vi_gTrPAvg;iPointsDecPP)
							[Alumnos_Calificaciones:208]P05_Final_Simbolo:415:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Final_Real:412)
							
							$l_recNumCalificaciones:=Record number:C243([Alumnos_Calificaciones:208])
							$t_userName:=USR_GetUserName 
							
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval10_Literal:91;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval07_Literal:76;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval04_Literal:61;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Eval01_Literal:46;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Control_Literal:111;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P01_Final_Literal:116;"Importación de calificaciones";$t_userName)
							
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval10_Literal:166;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval07_Literal:151;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval04_Literal:136;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Eval01_Literal:121;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Control_Literal:186;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Final_Literal:191;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Control_Literal:186;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P02_Final_Literal:191;"Importación de calificaciones";$t_userName)
							
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval10_Literal:241;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval07_Literal:226;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval04_Literal:211;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Eval01_Literal:196;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Control_Literal:261;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P03_Final_Literal:266;"Importación de calificaciones";$t_userName)
							
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval10_Literal:316;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval07_Literal:301;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval04_Literal:286;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Eval01_Literal:271;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Control_Literal:336;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P04_Final_Literal:341;"Importación de calificaciones";$t_userName)
							
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval12_Literal:401;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval11_Literal:396;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval10_Literal:391;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval09_Literal:386;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval08_Literal:381;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval07_Literal:376;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval06_Literal:371;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval05_Literal:366;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval04_Literal:361;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Eval01_Literal:346;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Control_Literal:411;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]P05_Final_Literal:416;"Importación de calificaciones";$t_userName)
							
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]Anual_Literal:15;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;"Importación de calificaciones";$t_userName)
							EV2_UpdateInfoCalificaciones ($l_recNumCalificaciones;->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;"Importación de calificaciones";$t_userName)
							
							
							$l_modoImpresionActas:=iPrintActa  //conservo en una variable el modo de impresión en acta del estilo de la asignatura
							$l_sinReprobacion:=vi_SinReprobacion
							
							$b_convertirA_EstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
							$l_IdEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
							If (($b_convertirA_EstiloOficial) & ([Asignaturas:18]NotaOficial_conEstiloAsignatura:95=False:C215))
								EVS_ReadStyleData ($l_IdEstiloOficial)
							End if 
							
							EV2_Calculos_Oficial ($l_modoImpresionActas)
							EV2_AprobacionReprobacion 
							
							SAVE RECORD:C53([Alumnos_Calificaciones:208])
							KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones:208])
							EVS_ReadStyleData ($l_IdEstiloEvaluación)
							
						End if 
						
						$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
						If ($l_recNum<0)
							CREATE RECORD:C68([Alumnos_ComplementoEvaluacion:209])
							[Alumnos_ComplementoEvaluacion:209]Año:3:=<>GYear
							[Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4:=[Alumnos_Calificaciones:208]NIvel_Numero:4
							[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=[Alumnos_Calificaciones:208]ID_Asignatura:5
							[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=[Alumnos_Calificaciones:208]ID_Alumno:6
							SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
						End if 
						
						If ($t_observaciones1#"")
							[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=$t_observaciones1
						End if 
						If ($t_observaciones2#"")
							[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=$t_observaciones2
						End if 
						If ($t_observaciones3#"")
							[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29:=$t_observaciones3
						End if 
						If ($t_observaciones4#"")
							[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34:=$t_observaciones4
						End if 
						If ($t_observaciones5#"")
							[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39:=$t_observaciones5
						End if 
						If ($t_observacionesFinales#"")
							[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=$t_observacionesFinales
						End if 
						If (vCR_Replacement#"")
							[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;vCR_Replacement;Char:C90(Carriage return:K15:38))
							[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;vCR_Replacement;Char:C90(Carriage return:K15:38))
							[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;vCR_Replacement;Char:C90(Carriage return:K15:38))
							[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;vCR_Replacement;Char:C90(Carriage return:K15:38))
							[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;vCR_Replacement;Char:C90(Carriage return:K15:38))
							[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;vCR_Replacement;Char:C90(Carriage return:K15:38))
						End if 
						SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
						
						$t_asignatura_y_curso:=[Asignaturas:18]denominacion_interna:16+[Alumnos:2]curso:20
						
						$el:=Find in array:C230($at_asignaturasImportadas;$t_asignatura_y_curso)
						If ($el=-1)
							APPEND TO ARRAY:C911($at_asignaturasImportadas;$t_asignatura_y_curso)
							LOG_RegisterEvt ("Importación de notas actuales con promedios para la asignatura "+[Asignaturas:18]denominacion_interna:16+", para el curso "+[Alumnos:2]curso:20+", realizada con éxito.")
						End if 
				End case 
			End if 
			RECEIVE PACKET:C104($h_referenciaArchivoImportacion;$t_registro;"\r")
		End while 
		CLOSE DOCUMENT:C267($h_referenciaArchivoImportacion)
		USE CHARACTER SET:C205(*;0)
		USE CHARACTER SET:C205(*;1)
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		FLUSH CACHE:C297
		
		ALL RECORDS:C47([Asignaturas:18])
		
		READ WRITE:C146([Profesores:4])
		ALL RECORDS:C47([Profesores:4])
		SELECTION TO ARRAY:C260([Profesores:4];$al_recNumprofesores)
		For ($i;1;Size of array:C274($al_recNumprofesores))
			GOTO RECORD:C242([Profesores:4];$al_recNumprofesores{$i})
			_O_ALL SUBRECORDS:C109([Profesores:4]Asignaturas:13)
			While (Not:C34(_O_End subselection:C37([Profesores:4]Asignaturas:13)))
				_O_DELETE SUBRECORD:C96([Profesores:4]Asignaturas:13)
				_O_ALL SUBRECORDS:C109([Profesores:4]Asignaturas:13)
			End while 
			QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
			AT_DistinctsFieldValues (->[Asignaturas:18]Asignatura:3;->$at_camposEnRegistro)
			SF_Array2SubTable (->[Profesores:4]Asignaturas:13;->$at_camposEnRegistro;->[Profesores]Asignaturas'Asignatura)
			SAVE RECORD:C53([Profesores:4])
		End for 
		
		For ($i;1;Size of array:C274($al_RecNumAsignaturas))
			EV2_ResultadosAsignatura ($al_RecNumAsignaturas{$i})
		End for 
		
		READ WRITE:C146([Alumnos:2])
		ALL RECORDS:C47([Alumnos:2])
		APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Porcentaje_asistencia:56:=100)
		
		dbu_ReparaConducta 
		SET BLOB SIZE:C606($x_blobRecNumAlumnos;0)
		dbu_CalculaSituacionFinal ($x_blobRecNumAlumnos;False:C215)
		FLUSH CACHE:C297
		
		If (Size of array:C274($at_erroresImportacion)>0)
			If (Application type:C494=4D Remote mode:K5:5)
				$t_rutaLogErrores:=SYS_CarpetaAplicacion (CLG_DocumentosLocal)+"Logs"+Folder separator:K24:12+"Errores import notas.txt"
				CREATE FOLDER:C475($t_rutaLogErrores;*)
			Else 
				$t_rutaLogErrores:=SYS_CarpetaAplicacion (CLG_Estructura)+"Logs"+Folder separator:K24:12+"Errores import notas.txt"
			End if 
			CREATE FOLDER:C475($t_rutaLogErrores;*)
			
			
			$h_refArchivoErrores:=Create document:C266($t_rutaLogErrores)
			For ($i;1;Size of array:C274($at_erroresImportacion))
				IO_SendPacket ($h_refArchivoErrores;$at_erroresImportacion{$i}+"\r")
			End for 
			CLOSE DOCUMENT:C267($h_refArchivoErrores)
			CD_Dlog (0;String:C10(Size of array:C274($at_erroresImportacion))+" registros de notas no pudieron ser importados.\r\rDetalles en el archivo: "+$t_rutaLogErrores)
			SHOW ON DISK:C922($t_rutaLogErrores)
		End if 
		
		UNLOAD RECORD:C212([Asignaturas:18])
		UNLOAD RECORD:C212([Alumnos:2])
		UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
		UNLOAD RECORD:C212([Profesores:4])
		
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([Profesores:4])
		
		0xDev_AvoidTriggerExecution (False:C215)
	Else 
		CD_Dlog (0;"El documento de texto no pudo ser abierto.")
	End if 
End if 
