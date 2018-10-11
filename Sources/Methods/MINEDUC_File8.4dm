//%attributes = {}
  //MINEDUC_File8

If (Count parameters:C259=1)
	$folder:=$1
Else 
	$folder:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 


READ ONLY:C145([Cursos:3])
QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
QUERY SELECTION WITH ARRAY:C1050([Cursos:3]Nivel_Numero:7;al_NivelesRech)

KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1)
EV2_Calificaciones_SeleccionAL 
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")

QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6>=1;*)
QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6<=12;*)
QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Incluida_en_Actas:44=True:C214)

CREATE EMPTY SET:C140([Asignaturas:18];"Subsectores")
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Asignatura:3;>)
$lastName:=""
While (Not:C34(End selection:C36([Asignaturas:18])))
	If ([Asignaturas:18]Asignatura:3#$lastName)
		ADD TO SET:C119([Asignaturas:18];"Subsectores")
		$lastName:=[Asignaturas:18]Asignatura:3
	End if 
	NEXT RECORD:C51([Asignaturas:18])
End while 
USE SET:C118("Subsectores")


SELECTION TO ARRAY:C260([Asignaturas:18];$aRecNum)
$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))
$fileName:=$folder+"A"+$rolBD+"_8.txt"
$fileRef:=Create document:C266($fileName;"TEXT")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando subsectores, asignaturas o módulos (")+$rolBD+__ ("_8.txt)"))


For ($records;1;Size of array:C274($aRecNum))
	GOTO RECORD:C242([Asignaturas:18];$aRecNum{$records})
	$codigo:=[Asignaturas:18]CHILE_CodigoMineduc:41
	$descripcion:=[Asignaturas:18]Asignatura:3
	$record:="8"+"\t"+$rolBD+"\t"+$rolDV+"\t"+String:C10(<>gYear)+"\t"+$codigo+"\t"+$descripcion+"\r"
	SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$records/Size of array:C274($aRecNum);__ ("Generando subsectores, asignaturas o módulos (")+$rolBD+__ ("_8.txt)"))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLOSE DOCUMENT:C267($fileref)


