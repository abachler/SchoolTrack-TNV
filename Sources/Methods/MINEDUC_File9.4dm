//%attributes = {}
  //MINEDUC_File9

If (Count parameters:C259=1)
	$folder:=$1
Else 
	$folder:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 

READ ONLY:C145([Alumnos:2])
QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Cursos:3]; & [Cursos:3]Nivel_Numero:7=12;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1)

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos:2];[Cursos:3]cl_CodigoTipoEnseñanza:21;[Alumnos:2]apellidos_y_nombres:40;>)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))
$fileName:=$folder+"A"+$rolBD+"_9.txt"
$fileRef:=Create document:C266($fileName;"TEXT")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Nómina de estudiantes licenciados (")+$rolBD+__ ("_9.txt)"))
$numeroRegistro:=0
While (Not:C34(End selection:C36([Alumnos:2])))
	$numeroRegistro:=$numeroRegistro+1
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]curso:20)
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
	
	Case of 
		: ([Cursos:3]cl_CodigoTipoEnseñanza:21>0)
			$codeEns:=String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21)
		: ([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41>0)
			$codeEns:=String:C10([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41)
		Else 
			$codeEns:="ERR"
	End case 
	
	Case of 
		: ([Cursos:3]cl_CodigoEspecialidadTP:29>0)
			$codeEspecialidad:=String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21)
		Else 
			$codeEspecialidad:="0"
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
	
	Case of 
		: (($codeEns="410") | ($codeEns="510") | ($codeEns="610") | ($codeEns="710") | ($codeEns="810"))
			$tipolicencia:="1"
		: ($codeEns="310")
			$tipolicencia:="2"
		: (($codeEns="460") | ($codeEns="461") | ($codeEns="560") | ($codeEns="561") | ($codeEns="660") | ($codeEns="661") | ($codeEns="760") | ($codeEns="761") | ($codeEns="860") | ($codeEns="861"))
			$tipolicencia:="3"
		: (($codeEns="360") | ($codeEns="361"))
			$tipolicencia:="4"
	End case 
	
	$record:="9"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$codeEspecialidad+"\t"+String:C10(<>gYear)+"\t"+String:C10($numeroRegistro)+"\t"+[Alumnos:2]Apellido_paterno:3+"\t"+[Alumnos:2]Apellido_materno:4+"\t"+[Alumnos:2]Nombres:2+"\t"+$run+"\t"+$dv+"\t"+$tipolicencia+"\r"
	SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
	NEXT RECORD:C51([Alumnos:2])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]);__ ("Generando archivo Nómina de estudiantes licenciados(")+$rolBD+__ ("_9.txt)"))
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLOSE DOCUMENT:C267($fileref)