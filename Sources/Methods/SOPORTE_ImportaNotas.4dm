//%attributes = {}
  // Método: SOPORTE_ImportaNotas
  // código original de: 
  // modificado por Alberto Bachler Klein el 17/02/18, 15:40:44
  // - normalización, declaración de variables, limpieza
  // - eliminación de llamados a STR_ReadGlobals
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BLOB:C604($x_recNumArray)
C_BOOLEAN:C305($b_importarRegistro)
C_LONGINT:C283($el;$i;$l_idCurso;$l_caracteresProcesados;$l_IdAlumno;$l_IdAsignatura;$l_IdEstiloEvaluación;$l_IdProfesor;$l_numeroFilaEnArchivo;$l_numeroListaEnCurso)
C_LONGINT:C283($l_numeroNivel;$l_registrosCreados;$l_registrosProcesados;$l_tamañoDocumento;$p;$l_totalregistros;$l_totalaprobados)
C_TIME:C306($h_refArchivoErrores;$h_refDocumento)
C_POINTER:C301($y_identificadorAlumno)
C_REAL:C285($r_notaReal1;$r_notaReal10;$r_notaReal11;$r_notaReal12;$r_notaReal13;$r_notaReal14;$r_notaReal15;$r_notaReal16;$r_notaReal17;$r_notaReal18)
C_REAL:C285($r_notaReal19;$r_notaReal2;$r_notaReal20;$r_notaReal21;$r_notaReal22;$r_notaReal23;$r_notaReal24;$r_notaReal25;$r_notaReal26;$r_notaReal27)
C_REAL:C285($r_notaReal28;$r_notaReal29;$r_notaReal3;$r_notaReal30;$r_notaReal31;$r_notaReal32;$r_notaReal33;$r_notaReal34;$r_notaReal35;$r_notaReal36)
C_REAL:C285($r_notaReal37;$r_notaReal38;$r_notaReal39;$r_notaReal4;$r_notaReal40;$r_notaReal41;$r_notaReal42;$r_notaReal43;$r_notaReal44;$r_notaReal45)
C_REAL:C285($r_notaReal46;$r_notaReal47;$r_notaReal48;$r_notaReal49;$r_notaReal5;$r_notaReal50;$r_notaReal51;$r_notaReal52;$r_notaReal53;$r_notaReal54)
C_REAL:C285($r_notaReal55;$r_notaReal56;$r_notaReal57;$r_notaReal58;$r_notaReal59;$r_notaReal6;$r_notaReal60;$r_notaReal7;$r_notaReal8;$r_notaReal9)
C_TEXT:C284($t_abreviaturaAsignatura;$t_asignatura_y_curso;$t_codigoAsignatura;$t_cursoAlumno;$t_cursoAsignatura;$t_identificadorAlumno;$t_indentificadorProfesor;$t_llaveRegistroCalificaciones;$t_nombreInternoAsignatura;$t_nombreNivel)
C_TEXT:C284($t_nombreOficialAsignatura;$t_nombreProfesor;$t_nombreProfesorFirmante;$t_observacionesFinal;$t_observacionesP1;$t_observacionesP2;$t_observacionesP3;$t_observacionesP4;$t_observacionesP5;$t_registro)
C_TEXT:C284($t_rutaDocumento;$t_rutaLogErrores;$t_origenDelArchivo)

ARRAY LONGINT:C221($al_RecNumAsignaturasRecalculos;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_erroresImportacion;0)
ARRAY TEXT:C222($at_nomAsigCurso;0)
ARRAY TEXT:C222($at_camposEnRegistro;0)  // ASM 20150312 ticket 141085 

If (False:C215)
	C_POINTER:C301(SOPORTE_ImportaNotas ;$1)
	C_TEXT:C284(SOPORTE_ImportaNotas ;$2)
	C_TEXT:C284(SOPORTE_ImportaNotas ;$3)
End if 

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;"Cualquier acción que afecte la situación académica de los alumnos ha sido bloquea"+"da a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+".")
Else 
	
	Case of 
		: (Count parameters:C259>0)
			$y_identificadorAlumno:=$1
			$t_origenDelArchivo:=$2
			$t_rutaDocumento:=$3
		Else 
			$h_refDocumento:=Open document:C264("")
	End case 
	$l_tamañoDocumento:=Get document size:C479(document)
	
	0xDev_AvoidTriggerExecution (True:C214)
	
	$p:=IT_UThermometer (1;0;"Normalizando identificador...")
	READ WRITE:C146([Alumnos:2])
	ALL RECORDS:C47([Alumnos:2])
	APPLY TO SELECTION:C70([Alumnos:2];$y_identificadorAlumno->:=ST_GetCleanString ($y_identificadorAlumno->))
	$p:=IT_UThermometer (-2;$p)
	
	If ($t_origenDelArchivo#"")
		If ($t_origenDelArchivo="Win")
			USE CHARACTER SET:C205("windows-1252";1)
			USE CHARACTER SET:C205("windows-1252";0)
		Else 
			USE CHARACTER SET:C205("MacRoman";1)
			USE CHARACTER SET:C205("MacRoman";0)
		End if 
	Else 
		If (SYS_IsWindows )
			USE CHARACTER SET:C205("windows-1252";1)
			USE CHARACTER SET:C205("windows-1252";0)
		Else 
			USE CHARACTER SET:C205("MacRoman";1)
			USE CHARACTER SET:C205("MacRoman";0)
		End if 
	End if 
	
	
	STR_LeeConfiguracion 
	EVS_ReadStyleData (-5)
	
	READ WRITE:C146([Alumnos_Calificaciones:208])
	READ WRITE:C146([Asignaturas:18])
	$h_refDocumento:=Open document:C264(document;Read mode:K24:5)
	RECEIVE PACKET:C104($h_refDocumento;$t_registro;"\r")
	  //para el log ticket 147179
	$l_totalregistros:=0
	$l_totalaprobados:=0
	  //
	$l_registrosCreados:=0
	$l_registrosProcesados:=0
	$l_caracteresProcesados:=0
	$l_numeroFilaEnArchivo:=0
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Importando registros de notas... ")
	While ((ok=1) & ($t_registro#""))
		$l_numeroFilaEnArchivo:=$l_numeroFilaEnArchivo+1
		$l_caracteresProcesados:=$l_caracteresProcesados+Length:C16($t_registro)+1
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_caracteresProcesados/$l_tamañoDocumento;"Importando Registros de notas... ")
		AT_Initialize (->$at_camposEnRegistro)
		AT_Text2Array (->$at_camposEnRegistro;$t_registro;"\t")
		ARRAY TEXT:C222($at_camposEnRegistro;100)
		$t_identificadorAlumno:=ST_GetCleanString ($at_camposEnRegistro{1})
		$l_numeroListaEnCurso:=Num:C11(ST_GetCleanString ($at_camposEnRegistro{2}))
		$t_codigoAsignatura:=ST_GetCleanString ($at_camposEnRegistro{3})
		$t_nombreOficialAsignatura:=ST_GetCleanString ($at_camposEnRegistro{4})
		$t_nombreInternoAsignatura:=ST_GetCleanString ($at_camposEnRegistro{5})
		$t_abreviaturaAsignatura:=ST_GetCleanString ($at_camposEnRegistro{6})
		$t_indentificadorProfesor:=ST_GetCleanString ($at_camposEnRegistro{7})
		$l_IdEstiloEvaluación:=Num:C11(ST_GetCleanString ($at_camposEnRegistro{8}))
		$t_cursoAsignatura:=Substring:C12(ST_GetCleanString ($at_camposEnRegistro{9});1;10)
		
		  //contabilizo los registros ticket 147179
		$l_totalregistros:=$l_totalregistros+1
		  //
		
		$b_importarRegistro:=True:C214
		Case of 
			: ($t_identificadorAlumno="")
				APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: Identificador de alumno inexistente"+"\t"+$t_registro)
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
					$b_importarRegistro:=False:C215
					
				: (Records in selection:C76([Alumnos:2])>1)
					APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: No existe correspondencia única con un alumno"+"\t"+$t_registro)
					$b_importarRegistro:=False:C215
					
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
						$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluación)
						Case of 
							: ($recNum<0)
								$l_IdAsignatura:=0
								APPEND TO ARRAY:C911($at_erroresImportacion;"Línea "+String:C10($l_numeroFilaEnArchivo)+" ERROR: Estilo de evaluación inexistente"+"\t"+$t_registro)
						End case 
					End if 
					
					If ($l_IdAsignatura#0)
						APPEND TO ARRAY:C911($al_RecNumAsignaturasRecalculos;$recNum)
						
						AT_Inc (0)
						AT_Inc (9)
						$r_notaReal1:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal2:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal3:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal4:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal5:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal6:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal7:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal8:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal9:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal10:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal11:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal12:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal13:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal14:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal15:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal16:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal17:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal18:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal19:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal20:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal21:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal22:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal23:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal24:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal25:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal26:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal27:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal28:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal29:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal30:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal31:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal32:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal33:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal34:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal35:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal36:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal37:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal38:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal39:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal40:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal41:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal42:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal43:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal44:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal45:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal46:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal47:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal48:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal49:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal50:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal51:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal52:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal53:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal54:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal55:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal56:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal57:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal58:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal59:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$r_notaReal60:=NTA_StringValue2Percent ($at_camposEnRegistro{AT_Inc };$l_IdEstiloEvaluación)
						$t_observacionesP1:=$at_camposEnRegistro{AT_Inc }
						$t_observacionesP2:=$at_camposEnRegistro{AT_Inc }
						$t_observacionesP3:=$at_camposEnRegistro{AT_Inc }
						$t_observacionesP4:=$at_camposEnRegistro{AT_Inc }
						$t_observacionesP5:=$at_camposEnRegistro{AT_Inc }
						$t_observacionesFinal:=$at_camposEnRegistro{AT_Inc }
						
						AS_CreaRegistrosEvaluacion ($l_IdAlumno;$l_IdAsignatura)
						$t_llaveRegistroCalificaciones:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->$l_numeroNivel;->$l_IdAsignatura;->$l_IdAlumno)
						KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveRegistroCalificaciones;True:C214)
						
						[Alumnos_Calificaciones:208]P01_Eval01_Real:42:=$r_notaReal1
						[Alumnos_Calificaciones:208]P01_Eval02_Real:47:=$r_notaReal2
						[Alumnos_Calificaciones:208]P01_Eval03_Real:52:=$r_notaReal3
						[Alumnos_Calificaciones:208]P01_Eval04_Real:57:=$r_notaReal4
						[Alumnos_Calificaciones:208]P01_Eval05_Real:62:=$r_notaReal5
						[Alumnos_Calificaciones:208]P01_Eval06_Real:67:=$r_notaReal6
						[Alumnos_Calificaciones:208]P01_Eval07_Real:72:=$r_notaReal7
						[Alumnos_Calificaciones:208]P01_Eval08_Real:77:=$r_notaReal8
						[Alumnos_Calificaciones:208]P01_Eval09_Real:82:=$r_notaReal9
						[Alumnos_Calificaciones:208]P01_Eval10_Real:87:=$r_notaReal10
						[Alumnos_Calificaciones:208]P01_Eval11_Real:92:=$r_notaReal11
						[Alumnos_Calificaciones:208]P01_Eval12_Real:97:=$r_notaReal12
						[Alumnos_Calificaciones:208]P02_Eval01_Real:117:=$r_notaReal13
						[Alumnos_Calificaciones:208]P02_Eval02_Real:122:=$r_notaReal14
						[Alumnos_Calificaciones:208]P02_Eval03_Real:127:=$r_notaReal15
						[Alumnos_Calificaciones:208]P02_Eval04_Real:132:=$r_notaReal16
						[Alumnos_Calificaciones:208]P02_Eval05_Real:137:=$r_notaReal17
						[Alumnos_Calificaciones:208]P02_Eval06_Real:142:=$r_notaReal18
						[Alumnos_Calificaciones:208]P02_Eval07_Real:147:=$r_notaReal19
						[Alumnos_Calificaciones:208]P02_Eval08_Real:152:=$r_notaReal20
						[Alumnos_Calificaciones:208]P02_Eval09_Real:157:=$r_notaReal21
						[Alumnos_Calificaciones:208]P02_Eval10_Real:162:=$r_notaReal22
						[Alumnos_Calificaciones:208]P02_Eval11_Real:167:=$r_notaReal23
						[Alumnos_Calificaciones:208]P02_Eval12_Real:172:=$r_notaReal24
						[Alumnos_Calificaciones:208]P03_Eval01_Real:192:=$r_notaReal25
						[Alumnos_Calificaciones:208]P03_Eval02_Real:197:=$r_notaReal26
						[Alumnos_Calificaciones:208]P03_Eval03_Real:202:=$r_notaReal27
						[Alumnos_Calificaciones:208]P03_Eval04_Real:207:=$r_notaReal28
						[Alumnos_Calificaciones:208]P03_Eval05_Real:212:=$r_notaReal29
						[Alumnos_Calificaciones:208]P03_Eval06_Real:217:=$r_notaReal30
						[Alumnos_Calificaciones:208]P03_Eval07_Real:222:=$r_notaReal31
						[Alumnos_Calificaciones:208]P03_Eval08_Real:227:=$r_notaReal32
						[Alumnos_Calificaciones:208]P03_Eval09_Real:232:=$r_notaReal33
						[Alumnos_Calificaciones:208]P03_Eval10_Real:237:=$r_notaReal34
						[Alumnos_Calificaciones:208]P03_Eval11_Real:242:=$r_notaReal35
						[Alumnos_Calificaciones:208]P03_Eval12_Real:247:=$r_notaReal36
						[Alumnos_Calificaciones:208]P04_Eval01_Real:267:=$r_notaReal37
						[Alumnos_Calificaciones:208]P04_Eval02_Real:272:=$r_notaReal38
						[Alumnos_Calificaciones:208]P04_Eval03_Real:277:=$r_notaReal39
						[Alumnos_Calificaciones:208]P04_Eval04_Real:282:=$r_notaReal40
						[Alumnos_Calificaciones:208]P04_Eval05_Real:287:=$r_notaReal41
						[Alumnos_Calificaciones:208]P04_Eval06_Real:292:=$r_notaReal42
						[Alumnos_Calificaciones:208]P04_Eval07_Real:297:=$r_notaReal43
						[Alumnos_Calificaciones:208]P04_Eval08_Real:302:=$r_notaReal44
						[Alumnos_Calificaciones:208]P04_Eval09_Real:307:=$r_notaReal45
						[Alumnos_Calificaciones:208]P04_Eval10_Real:312:=$r_notaReal46
						[Alumnos_Calificaciones:208]P04_Eval11_Real:317:=$r_notaReal47
						[Alumnos_Calificaciones:208]P04_Eval12_Real:322:=$r_notaReal48
						[Alumnos_Calificaciones:208]P05_Eval01_Real:342:=$r_notaReal49
						[Alumnos_Calificaciones:208]P05_Eval02_Real:347:=$r_notaReal50
						[Alumnos_Calificaciones:208]P05_Eval03_Real:352:=$r_notaReal51
						[Alumnos_Calificaciones:208]P05_Eval04_Real:357:=$r_notaReal52
						[Alumnos_Calificaciones:208]P05_Eval05_Real:362:=$r_notaReal53
						[Alumnos_Calificaciones:208]P05_Eval06_Real:367:=$r_notaReal54
						[Alumnos_Calificaciones:208]P05_Eval07_Real:372:=$r_notaReal55
						[Alumnos_Calificaciones:208]P05_Eval08_Real:377:=$r_notaReal56
						[Alumnos_Calificaciones:208]P05_Eval09_Real:382:=$r_notaReal57
						[Alumnos_Calificaciones:208]P05_Eval10_Real:387:=$r_notaReal58
						[Alumnos_Calificaciones:208]P05_Eval11_Real:392:=$r_notaReal59
						[Alumnos_Calificaciones:208]P05_Eval12_Real:397:=$r_notaReal60
						
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
						[Alumnos_Calificaciones:208]P02_Eval11_Puntos:169:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval11_Real:167)
						[Alumnos_Calificaciones:208]P02_Eval11_Simbolo:170:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval11_Real:167)
						
						[Alumnos_Calificaciones:208]P02_Eval12_Literal:176:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Eval12_Real:172;iEvaluationMode;vlNTA_DecimalesParciales)
						[Alumnos_Calificaciones:208]P02_Eval12_Nota:173:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval12_Real:172;0;iGradesDec)
						[Alumnos_Calificaciones:208]P02_Eval12_Puntos:174:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval12_Real:172;0;iPointsDec)
						[Alumnos_Calificaciones:208]P02_Eval12_Simbolo:175:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval12_Real:172)
						
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
						[Alumnos_Calificaciones:208]P05_Eval12_Nota:398:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval12_Real:397;0;iGradesDec)
						[Alumnos_Calificaciones:208]P05_Eval12_Puntos:399:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval12_Real:397;0;iPointsDec)
						[Alumnos_Calificaciones:208]P05_Eval12_Simbolo:400:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval12_Real:397)
						
						
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
						
						
						SAVE RECORD:C53([Alumnos_Calificaciones:208])
						
						$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
						If ($recNum<0)
							CREATE RECORD:C68([Alumnos_ComplementoEvaluacion:209])
							[Alumnos_ComplementoEvaluacion:209]Año:3:=<>GYear
							[Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4:=[Alumnos_Calificaciones:208]NIvel_Numero:4
							[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=[Alumnos_Calificaciones:208]ID_Asignatura:5
							[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=[Alumnos_Calificaciones:208]ID_Alumno:6
							SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
						End if 
						
						If ($t_observacionesP1#"")
							[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=$t_observacionesP1
						End if 
						If ($t_observacionesP2#"")
							[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=$t_observacionesP2
						End if 
						If ($t_observacionesP3#"")
							[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29:=$t_observacionesP3
						End if 
						If ($t_observacionesP4#"")
							[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34:=$t_observacionesP4
						End if 
						If ($t_observacionesP5#"")
							[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39:=$t_observacionesP5
						End if 
						If ($t_observacionesFinal#"")
							[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=$t_observacionesFinal
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
						$el:=Find in array:C230($at_nomAsigCurso;$t_asignatura_y_curso)
						If ($el=-1)
							APPEND TO ARRAY:C911($at_nomAsigCurso;$t_asignatura_y_curso)
							LOG_RegisterEvt ("Importación de notas parciales actuales para la asignatura "+[Asignaturas:18]denominacion_interna:16+", para el curso "+[Alumnos:2]curso:20+", realizada con éxito.")
						End if 
					End if 
					$l_totalaprobados:=$l_totalaprobados+1
			End case 
		End if 
		RECEIVE PACKET:C104($h_refDocumento;$t_registro;"\r")
	End while 
	
	  //para el log de actividades segun ticket 147179 
	C_TEXT:C284($t_identificadorimportador)
	Case of 
		: (KRL_isSameField ($y_identificadorAlumno;->[Alumnos:2]RUT:5))
			$t_identificadorimportador:="Alumnos Rut"
		: (KRL_isSameField ($y_identificadorAlumno;->[Alumnos:2]IDNacional_2:71))
			$t_identificadorimportador:="Identificador Nacional 2"
		: (KRL_isSameField ($y_identificadorAlumno;->[Alumnos:2]IDNacional_3:70))
			$t_identificadorimportador:="Identificador Nacional 3"
		: (KRL_isSameField ($y_identificadorAlumno;->[Alumnos:2]Codigo_interno:6))
			$t_identificadorimportador:="Alumnos Codigo Interno"
	End case 
	C_TEXT:C284($log)
	
	$log:=__ ("Se realizo la importacion de notas con el archivo ")+$t_rutaDocumento+" y con el identificador "+$t_identificadorimportador
	LOG_RegisterEvt ($log)
	
	  // /
	
	CLOSE DOCUMENT:C267($h_refDocumento)
	USE CHARACTER SET:C205(*;0)
	USE CHARACTER SET:C205(*;1)
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumAsignaturasRecalculos)
	EV2dbu_Recalculos ($x_recNumArray;False:C215)
	
	READ WRITE:C146([Profesores:4])
	ALL RECORDS:C47([Profesores:4])
	SELECTION TO ARRAY:C260([Profesores:4];$al_recNums)
	For ($i;1;Size of array:C274($al_recNums))
		GOTO RECORD:C242([Profesores:4];$al_recNums{$i})
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
	
	0xDev_AvoidTriggerExecution (False:C215)
	
	If (Size of array:C274($at_erroresImportacion)>0)
		If (Application type:C494=4D Remote mode:K5:5)
			$t_rutaLogErrores:=SYS_CarpetaAplicacion (CLG_DocumentosLocal)+"Logs"+Folder separator:K24:12+"Errores import notas.txt"
			CREATE FOLDER:C475($t_rutaLogErrores;*)
		Else 
			$t_rutaLogErrores:=SYS_CarpetaAplicacion (CLG_DocumentosLocal)+"Logs"+Folder separator:K24:12+"Errores import notas.txt"
		End if 
		CREATE FOLDER:C475($t_rutaLogErrores;*)
		
		
		$h_refArchivoErrores:=Create document:C266($t_rutaLogErrores)
		For ($i;1;Size of array:C274($at_erroresImportacion))
			SEND PACKET:C103($h_refArchivoErrores;$at_erroresImportacion{$i}+"\r")
		End for 
		CLOSE DOCUMENT:C267($h_refArchivoErrores)
		CD_Dlog (0;String:C10(Size of array:C274($at_erroresImportacion))+" registros de notas no pudieron ser importados.\r\rDetalles en el archivo: "+document)
		SHOW ON DISK:C922($t_rutaLogErrores)
	End if 
	
	  //para mostrar cuantos registros se importaron realmente segun ticket 147179 
	CD_Dlog (0;"Se Importaron "+String:C10($l_totalaprobados)+" de un total de "+String:C10($l_totalregistros)+" registros")
	  //
	
	
	USE CHARACTER SET:C205(*;0)
	USE CHARACTER SET:C205(*;1)
	
	UNLOAD RECORD:C212([Asignaturas:18])
	UNLOAD RECORD:C212([Alumnos:2])
	UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
	UNLOAD RECORD:C212([Profesores:4])
	
	READ ONLY:C145([Asignaturas:18])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([Alumnos_Calificaciones:208])
	READ ONLY:C145([Profesores:4])
	
End if 