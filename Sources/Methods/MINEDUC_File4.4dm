//%attributes = {}
  //MINEDUC_File4

If (Count parameters:C259=1)
	$folder:=$1
Else 
	$folder:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 

QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
QUERY SELECTION WITH ARRAY:C1050([Cursos:3]Nivel_Numero:7;al_NivelesRech)

KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1)
CREATE SET:C116([Alumnos:2];"AlumnosEnCursos")

ALL RECORDS:C47([xxSTR_Materias:20])
SELECTION TO ARRAY:C260([xxSTR_Materias:20]Materia:2;$aMaterias;[xxSTR_Materias:20]Codigo:10;$aCodigo)

CREATE EMPTY SET:C140([Alumnos:2];"alumnos")

READ ONLY:C145([Alumnos:2])
USE SET:C118("AlumnosEnCursos")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo")
CREATE SET:C116([Alumnos:2];"Activos")

USE SET:C118("AlumnosEnCursos")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42>vdSTR_Periodos_InicioEjercicio;*)
QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50="Promovido anticipadamente@")
CREATE SET:C116([Alumnos:2];"PromoAnticipada")

  //MONO ticket: 139218
  //$d1:=DT_GetDateFromDayMonthYear (30;11;<>gYear)
USE SET:C118("AlumnosEnCursos")
  //QUERY SELECTION([Alumnos];[Alumnos]Fecha_de_retiro>=$d1;*)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42>vdSTR_Periodos_InicioEjercicio;*)
QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50="Retirado@")
CREATE SET:C116([Alumnos:2];"Retiros")

UNION:C120("Alumnos";"Activos";"Alumnos")
UNION:C120("Alumnos";"PromoAnticipada";"Alumnos")
UNION:C120("Alumnos";"Retiros";"Alumnos")

USE SET:C118("Alumnos")
ARRAY LONGINT:C221($al_niveles_encontrados;0)
AT_DistinctsFieldValues (->[Alumnos:2]nivel_numero:29;->$al_niveles_encontrados)

If (SYS_IsMacintosh )
	USE CHARACTER SET:C205("MacRoman";0)
Else 
	USE CHARACTER SET:C205("windows-1252";0)
End if 

$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))

For ($x;1;Size of array:C274($al_niveles_encontrados))
	
	USE SET:C118("Alumnos")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=$al_niveles_encontrados{$x})
	ORDER BY:C49([Alumnos:2];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	
	$fileRef:=Create document:C266($folder+"RECH_file4_nivel_"+String:C10($al_niveles_encontrados{$x})+"_rol_"+<>gRolBD;"TEXT")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo Antecedentes académicos de los estudiantes "+$rolBD+" nivel "+String:C10($al_niveles_encontrados{$x}))
	
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
	For ($records;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Alumnos:2];$aRecNums{$records})
		  //If (([Alumnos]Status="Retirado@") & ([Alumnos]Fecha_de_retiro<=vdSTR_Periodos_InicioEjercicio))
		If ([Alumnos:2]Status:50="Retirado@")  //20151124 ASM TICKET 153075 (reviso en conjunto con Luisa)
			  // no enviar nada    
		Else 
			
			$status:=[Alumnos:2]Status:50
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
			
			Case of 
				: ([Cursos:3]cl_CodigoTipoEnseñanza:21=10)  // parvularia
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=160) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=163))  // basica comuna adultos o básica escuelas carceles
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21>=211) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=216))  // Deficiencia auditiva, mental, visual, alteraciones del lenguaje
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				: ([Cursos:3]cl_CodigoTipoEnseñanza:21=361)  // media HC Adultos Decreto 12
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=460) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=461))  // TP Comercial adultos y decreto 152
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=560) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=561))  // TP Industrial adultos y decreto 152
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=660) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=661))  // TP Técnica adultos y decreto 152
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=760) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=761))  // TP Agrícola adultos y decreto 152
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=860) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=861))  // TP Marítima adultos y decreto 152
					$grade:=[Cursos:3]cl_CodigoNivelEspecial:36
				Else 
					Case of 
						: ([Cursos:3]Nivel_Numero:7=-2)
							$grade:="4"
						: ([Cursos:3]Nivel_Numero:7=-1)
							$grade:="5"
						: ([Cursos:3]Nivel_Numero:7>8)
							$grade:=String:C10([Cursos:3]Nivel_Numero:7-8)
						Else 
							$grade:=String:C10([Cursos:3]Nivel_Numero:7)
					End case 
			End case 
			
			$letraCurso:=[Cursos:3]Letra_Oficial_del_Curso:18
			
			
			Case of 
				: ([Cursos:3]cl_CodigoDecretoEvaluacion:24>0)
					$codeDecretoEval:=String:C10([Cursos:3]cl_CodigoDecretoEvaluacion:24)
				: ([xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38>0)
					$codeDecretoEval:=String:C10([xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38)
				Else 
					$codeDecretoEval:="ERR"
			End case 
			Case of 
				: ([Cursos:3]cl_CodigoDecretoPlanEstudios:22>0)
					$codeDecretoPE:=String:C10([Cursos:3]cl_CodigoDecretoPlanEstudios:22)
				: ([xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39>0)
					$codeDecretoPE:=String:C10([xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39)
				Else 
					$codeDecretoPE:="ERR"
			End case 
			
			Case of 
				: ([Cursos:3]cl_CodigoPlanEstudios:23>0)
					$codePE:=String:C10([Cursos:3]cl_CodigoPlanEstudios:23)
				: ([xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40>0)
					$codePE:=String:C10([xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40)
				Else 
					$codePE:="ERR"
			End case 
			
			Case of 
				: ([Cursos:3]cl_CodigoTipoEnseñanza:21>0)
					$codeEns:=String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21)
				: ([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41>0)
					$codeEns:=String:C10([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41)
				Else 
					$codeEns:="ERR"
			End case 
			
			If (([Alumnos:2]RUT:5="") & ([Alumnos:2]Nacionalidad:8#"Chilen@"))
				$indicadorExtranjero:="1"
				$run:=[Alumnos:2]NoPasaporte:87
				$DV:=""
			Else 
				$rut:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)
				If (Num:C11(Substring:C12($rut;1;1))>0)
					$dv:=$rut[[Length:C16($rut)]]
					$run:=Substring:C12($rut;1;Length:C16($rut)-1)
				Else 
					$run:="ERR"
					$dv:="ERR"
				End if 
			End if 
			
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#"")
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$aDummy;[Asignaturas:18]Asignatura:3;$asubsector;[Asignaturas:18]Es_Optativa:70;$aEsOptativa;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$aNota;[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7;$adExim;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;$aRegExim)
			
			GOTO RECORD:C242([Alumnos:2];$aRecNums{$records})
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			For ($i;1;Size of array:C274($asubsector))
				$el:=Find in array:C230($aMaterias;$asubsector{$i})
				If ($el>0)
					If (Num:C11($aCodigo{$el})>0)
						$code:=$aCodigo{$el}
					Else 
						$code:="ERR"
					End if 
				Else 
					$code:="ERR"
				End if 
				Case of 
					: ($status="Retirado@")
						$nota:=""
						$concepto:=""
						$eximido:=""
					: (Num:C11($aNota{$i})>0)
						If (Position:C15(",";$aNota{$i})=0)
							$nota:=$aNota{$i}+".0"
						Else 
							$nota:=Replace string:C233($aNota{$i};",";".")
						End if 
						$concepto:=""
						$eximido:=""
					: (($aNota{$i}="EX") | ($adExim{$i}#!00-00-00!) | ($aRegExim{$i}#0))
						$nota:=""
						$concepto:=""
						$eximido:="EX"
					Else 
						$nota:=""
						$concepto:=$aNota{$i}
						$eximido:=""
				End case 
				If (($aEsOptativa{$i}) & ($concepto=""))
					  //dont send anything      
				Else 
					$record:="4"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$codeEns+"\t"+$grade+"\t"+$letraCurso+"\t"+String:C10(<>gYear)+"\t"+$run+"\t"+$dv+"\t"+$codeDecretoPE+"\t"+$codePE+"\t"+$code+"\t"+$nota+"\t"+$concepto+"\t"+$eximido+"\r"
					SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
				End if 
				
			End for 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$records/Size of array:C274($aRecNums);"Generando archivo Antecedentes académicos de los estudiantes "+$rolBD+" nivel "+String:C10($al_niveles_encontrados{$x}))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($fileref)
	
End for 

USE CHARACTER SET:C205(*;0)