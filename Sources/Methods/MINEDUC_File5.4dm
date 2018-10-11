//%attributes = {}
  //MINEDUC_File5

If (Count parameters:C259=1)
	$folder:=$1
Else 
	$folder:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 

If (SYS_IsMacintosh )
	USE CHARACTER SET:C205("MacRoman";0)
Else 
	USE CHARACTER SET:C205("windows-1252";0)
End if 


  //MONO ticket: 139218
  //$d1:=DT_GetDateFromDayMonthYear (30;4;<>gYear)
READ ONLY:C145([Alumnos:2])
QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)

QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
QUERY SELECTION WITH ARRAY:C1050([Cursos:3]Nivel_Numero:7;al_NivelesRech)

KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Retirado@";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Promovido anticipadamente@")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Fecha_de_retiro:42>vdSTR_Periodos_InicioEjercicio)
  //QUERY SELECTION([Alumnos]; | [Alumnos]Fecha_de_retiro>$d1)
CREATE SET:C116([Alumnos:2];"alumnos")
ARRAY LONGINT:C221($al_niveles_encontrados;0)
AT_DistinctsFieldValues (->[Alumnos:2]nivel_numero:29;->$al_niveles_encontrados)

$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))
ARRAY LONGINT:C221($aRecNums;0)

For ($x;1;Size of array:C274($al_niveles_encontrados))
	
	USE SET:C118("Alumnos")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=$al_niveles_encontrados{$x})
	ORDER BY:C49([Alumnos:2];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
	
	$fileRef:=Create document:C266($folder+"RECH_file5_nivel_"+String:C10($al_niveles_encontrados{$x})+"_rol_"+<>gRolBD;"TEXT")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo Situación de promoción de los estudiantes "+$rolBD+" nivel "+String:C10($al_niveles_encontrados{$x}))
	$LastCurso:=""
	
	For ($records;1;Size of array:C274($aRecNums))
		
		GOTO RECORD:C242([Alumnos:2];$aRecNums{$records})
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
		If ([Alumnos:2]Status:50="Retirad@")
			$nota:=""
		Else 
			If ([Alumnos:2]Promedio_General_Oficial:32#"")
				$nota:=Replace string:C233(Replace string:C233([Alumnos:2]Promedio_General_Oficial:32;",";".");Char:C90(0);"")
			Else 
				$nota:="ERR"
			End if 
		End if 
		If ([Alumnos:2]Porcentaje_asistencia:56>0)
			$asist:=String:C10(Round:C94([Alumnos:2]Porcentaje_asistencia:56;0))
		Else 
			If ([Alumnos:2]Status:50="Retirad@")
				$asist:=""
			Else 
				$asist:=""
			End if 
		End if 
		
		$obs:=ST_GetCleanString ([Alumnos:2]Observaciones_en_Acta:58)
		If (([Alumnos:2]Situacion_final:33="P") | ([Alumnos:2]Situacion_final:33="Y") | ([Alumnos:2]Situacion_final:33="R"))
			$promo:=[Alumnos:2]Situacion_final:33
		Else 
			$promo:="ERR"
		End if 
		
		
		$record:="5"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$codeEns+"\t"+$grade+"\t"+[Cursos:3]Letra_Oficial_del_Curso:18+"\t"+String:C10(<>gYear)+"\t"+$run+"\t"+$dv+"\t"+$nota+"\t"+$asist+"\t"+$obs+"\t"+$promo+"\t"+"1"+"\r"
		SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$records/Size of array:C274($aRecNums);"Generando archivo Situación de promoción de los estudiantes "+$rolBD+" nivel "+String:C10($al_niveles_encontrados{$x}))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	CLOSE DOCUMENT:C267($fileref)
	
End for 

CLEAR SET:C117("alumnos")
USE CHARACTER SET:C205(*;0)