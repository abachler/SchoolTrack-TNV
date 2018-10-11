//%attributes = {}
  //MINEDUC_File1

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
ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))
$fileName:=$folder+"A"+$rolBD+"_1.txt"
$fileRef:=Create document:C266($fileName;"TEXT")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Nómina de estudiantes (")+$rolBD+__ ("_1.txt)"))
While (Not:C34(End selection:C36([Alumnos:2])))
	$indicadorExtranjero:="2"
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
		: ([Alumnos:2]Sexo:49="M")
			$sex:="1"
		: ([Alumnos:2]Sexo:49="F")
			$sex:="2"
		: ([Alumnos:2]Sexo:49="")
			$sex:="ERR"
	End case 
	If ([Alumnos:2]Fecha_de_nacimiento:7=!00-00-00!)
		$date:="ERR"
	Else 
		$date:=String:C10([Alumnos:2]Fecha_de_nacimiento:7;7)
	End if 
	$record:="1"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$run+"\t"+$dv+"\t"+[Alumnos:2]Apellido_paterno:3+"\t"+[Alumnos:2]Apellido_materno:4+"\t"+[Alumnos:2]Nombres:2+"\t"+$sex+"\t"+$date+"\t"+$indicadorExtranjero+"\r"
	SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
	NEXT RECORD:C51([Alumnos:2])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]);__ ("Generando archivo Nómina de estudiantes (")+$rolBD+__ ("_1.txt)"))
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLOSE DOCUMENT:C267($fileref)