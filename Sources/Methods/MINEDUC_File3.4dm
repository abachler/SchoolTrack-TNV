//%attributes = {}
  //MINEDUC_File3

If (Count parameters:C259=1)
	$folder:=$1
Else 
	$folder:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 

$d1:=DT_GetDateFromDayMonthYear (30;4;<>gYear)
READ ONLY:C145([Alumnos:2])
QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
QUERY SELECTION WITH ARRAY:C1050([Cursos:3]Nivel_Numero:7;al_NivelesRech)
KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Retirado@";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Promovido anticipadamente@")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Fecha_de_retiro:42>$d1)
ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))
$fileName:=$folder+"A"+$rolBD+"_3.txt"
$fileRef:=Create document:C266($fileName;"TEXT")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Estudiantes del curso (")+$rolBD+__ ("_3.txt)"))
$LastCurso:=""
While (Not:C34(End selection:C36([Alumnos:2])))
	
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
	If ([Alumnos:2]Codigo_Comuna:79#"")
		$comuna:=[Alumnos:2]Codigo_Comuna:79
	Else 
		$comuna:="ERR"
	End if 
	
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
	
	$record:="3"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$codeEns+"\t"+$grade+"\t"+[Cursos:3]Letra_Oficial_del_Curso:18+"\t"+String:C10(<>gYear)+"\t"+$run+"\t"+$dv+"\t"+$comuna+"\r"
	SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
	NEXT RECORD:C51([Alumnos:2])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]);__ ("Generando archivo Estudiantes del curso  (")+$rolBD+__ ("_3.txt)"))
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLOSE DOCUMENT:C267($fileref)