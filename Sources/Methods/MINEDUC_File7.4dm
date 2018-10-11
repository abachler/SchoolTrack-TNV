//%attributes = {}
  // MINEDUC_File7()
  // Por: Alberto Bachler K.: 28-02-14, 20:22:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($1)

C_DATE:C307($d_fechaActa)
C_LONGINT:C283($i_registros;$l_altas;$l_bajas;$l_matricula30Abril;$l_matricula30Noviembre;$l_promovidos;$l_reprobadosAsistencia;$l_reprobadosRendimiento)
C_TIME:C306($h_refArchivo)
C_TEXT:C284($t_codigoEnseñanza;$t_codigoNivel;$t_codigoPlanEstudios;$t_decretoEvaluacion;$t_decretoPlanEstudios;$t_digitoVerificadorRol;$t_digitoVerificadorRUN;$t_Director;$t_encargadoActa;$t_nombreArchivo)
C_TEXT:C284($t_profesorJefe;$t_registro;$t_RolBasedatos;$t_run;$t_rutaCarpeta)

ARRAY LONGINT:C221($al_recNum;0)

If (False:C215)
	C_TEXT:C284(MINEDUC_File7 ;$1)
End if 


EVS_LoadStyles 


If (Count parameters:C259=1)
	$t_rutaCarpeta:=$1
Else 
	$t_rutaCarpeta:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 


READ ONLY:C145([Cursos:3])
QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
QUERY SELECTION WITH ARRAY:C1050([Cursos:3]Nivel_Numero:7;al_NivelesRech)

ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Letra_del_curso:9)
SELECTION TO ARRAY:C260([Cursos:3];$al_recNum)
$t_RolBasedatos:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$t_digitoVerificadorRol:=Substring:C12($t_RolBasedatos;Length:C16($t_RolBasedatos))
$t_RolBasedatos:=Substring:C12($t_RolBasedatos;1;Length:C16($t_RolBasedatos)-1)
$t_nombreArchivo:=$t_rutaCarpeta+"A"+$t_RolBasedatos+"_7.txt"
$h_refArchivo:=Create document:C266($t_nombreArchivo;"TEXT")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Acta del curso (")+$t_RolBasedatos+__ ("_7.txt)"))


For ($i_registros;1;Size of array:C274($al_recNum))
	GOTO RECORD:C242([Cursos:3];$al_recNum{$i_registros})
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
	
	
	Case of 
		: ([Cursos:3]cl_CodigoDecretoEvaluacion:24>0)
			$t_decretoEvaluacion:=String:C10([Cursos:3]cl_CodigoDecretoEvaluacion:24)
		: ([xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38>0)
			$t_decretoEvaluacion:=String:C10([xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38)
		Else 
			$t_decretoEvaluacion:="ERR"
	End case 
	Case of 
		: ([Cursos:3]cl_CodigoDecretoPlanEstudios:22>0)
			$t_decretoPlanEstudios:=String:C10([Cursos:3]cl_CodigoDecretoPlanEstudios:22)
		: ([xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39>0)
			$t_decretoPlanEstudios:=String:C10([xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39)
		Else 
			$t_decretoPlanEstudios:="ERR"
	End case 
	
	Case of 
		: ([Cursos:3]cl_CodigoPlanEstudios:23>0)
			$t_codigoPlanEstudios:=String:C10([Cursos:3]cl_CodigoPlanEstudios:23)
		: ([xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40>0)
			$t_codigoPlanEstudios:=String:C10([xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40)
		Else 
			$t_codigoPlanEstudios:="ERR"
	End case 
	
	Case of 
		: ([Cursos:3]cl_CodigoTipoEnseñanza:21>0)
			$t_codigoEnseñanza:=String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21)
		: ([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41>0)
			$t_codigoEnseñanza:=String:C10([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41)
		Else 
			$t_codigoEnseñanza:="ERR"
	End case 
	
	ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1;<>gYear)
	
	
	Case of 
		: ([Cursos:3]cl_CodigoTipoEnseñanza:21=10)  // parvularia
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		: (([Cursos:3]cl_CodigoTipoEnseñanza:21=160) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=163))  // basica comuna adultos o básica escuelas carceles
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		: (([Cursos:3]cl_CodigoTipoEnseñanza:21>=211) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=216))  // Deficiencia auditiva, mental, visual, alteraciones del lenguaje
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		: ([Cursos:3]cl_CodigoTipoEnseñanza:21=361)  // media HC Adultos Decreto 12
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		: (([Cursos:3]cl_CodigoTipoEnseñanza:21=460) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=461))  // TP Comercial adultos y decreto 152
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		: (([Cursos:3]cl_CodigoTipoEnseñanza:21=560) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=561))  // TP Industrial adultos y decreto 152
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		: (([Cursos:3]cl_CodigoTipoEnseñanza:21=660) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=661))  // TP Técnica adultos y decreto 152
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		: (([Cursos:3]cl_CodigoTipoEnseñanza:21=760) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=761))  // TP Agrícola adultos y decreto 152
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		: (([Cursos:3]cl_CodigoTipoEnseñanza:21=860) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=861))  // TP Marítima adultos y decreto 152
			$t_codigoNivel:=[Cursos:3]cl_CodigoNivelEspecial:36
		Else 
			Case of 
				: ([Cursos:3]Nivel_Numero:7=-2)
					$t_codigoNivel:="4"
				: ([Cursos:3]Nivel_Numero:7=-1)
					$t_codigoNivel:="5"
				: ([Cursos:3]Nivel_Numero:7>8)
					$t_codigoNivel:=String:C10([Cursos:3]Nivel_Numero:7-8)
				Else 
					$t_codigoNivel:=String:C10([Cursos:3]Nivel_Numero:7)
			End case 
	End case 
	
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
	If ((Records in selection:C76([Profesores:4])>0) & ([Profesores:4]RUT:27#""))
		$t_digitoVerificadorRUN:=[Profesores:4]RUT:27[[Length:C16([Profesores:4]RUT:27)]]
		$t_run:=Substring:C12([Profesores:4]RUT:27;1;Length:C16([Profesores:4]RUT:27)-1)
	Else 
		$t_digitoVerificadorRUN:=""
		$t_run:=""
	End if 
	
	MINEDUC_DatosActa 
	$l_matricula30Abril:=iMatDeb
	$l_matricula30Noviembre:=iMatfin
	$l_promovidos:=iOK
	$l_reprobadosAsistencia:=iAbs
	$l_reprobadosRendimiento:=iBad
	$l_bajas:=iret
	$l_altas:=iMatYear
	$t_encargadoActa:=vRespName
	$d_fechaActa:=vd_date
	If ([Cursos:3]ActaEspecificaAlCurso:35)
		$t_Director:=[Cursos:3]Director:33
	Else 
		$t_Director:=<>gRector
	End if 
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
	$t_profesorJefe:=[Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4
	
	$t_registro:="7"+"\t"+$t_RolBasedatos+"\t"+$t_digitoVerificadorRol+"\t"+$t_codigoEnseñanza+"\t"+$t_codigoNivel+"\t"+[Cursos:3]Letra_Oficial_del_Curso:18+"\t"+String:C10(<>gYear)+"\t"+String:C10($l_matricula30Abril)+"\t"+String:C10($l_matricula30Noviembre)+"\t"+String:C10($l_promovidos)+"\t"+String:C10($l_reprobadosAsistencia)+"\t"+String:C10($l_reprobadosRendimiento)+"\t"+String:C10($l_altas)+"\t"+String:C10($l_bajas)+"\t"+$t_encargadoActa+"\t"+String:C10($d_fechaActa;7)+"\t"+$t_Director+"\t"+$t_profesorJefe+"\r"
	SEND PACKET:C103($h_refArchivo;_O_Mac to Win:C463($t_registro))
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);__ ("Generando archivo Acta del curso (")+$t_RolBasedatos+__ ("_7.txt)"))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLOSE DOCUMENT:C267($h_refArchivo)