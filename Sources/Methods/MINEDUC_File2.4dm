//%attributes = {}
  //MINEDUC_File2

If (Count parameters:C259=1)
	$folder:=$1
Else 
	$folder:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 


READ ONLY:C145([Cursos:3])
QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
QUERY SELECTION WITH ARRAY:C1050([Cursos:3]Nivel_Numero:7;al_NivelesRech)
ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Letra_del_curso:9)
$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))
$fileName:=$folder+"A"+$rolBD+"_2.txt"
$fileRef:=Create document:C266($fileName;"TEXT")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Información del curso (")+$rolBD+__ ("_2.txt)"))
While (Not:C34(End selection:C36([Cursos:3])))
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
	
	
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
	  //20111129 AS. cuando no habia profesor jefe asignado al curso ocacionaba error
	If ((Records in selection:C76([Profesores:4])>0) & ([Profesores:4]RUT:27#""))
		$dv:=[Profesores:4]RUT:27[[Length:C16([Profesores:4]RUT:27)]]
		$run:=Substring:C12([Profesores:4]RUT:27;1;Length:C16([Profesores:4]RUT:27)-1)
	Else 
		$dv:=""
		$run:=""
	End if 
	$record:="2"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$codeEns+"\t"+$grade+"\t"+[Cursos:3]Letra_Oficial_del_Curso:18+"\t"+String:C10(<>gYear)+"\t"+$codeDecretoEval+"\t"+$codeDecretoPE+"\t"+$codePE+"\t"+$run+"\t"+$dv+"\r"
	SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
	NEXT RECORD:C51([Cursos:3])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Cursos:3])/Records in selection:C76([Cursos:3]);__ ("Generando archivo Información del curso (")+$rolBD+__ ("_2.txt)"))
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLOSE DOCUMENT:C267($fileref)
