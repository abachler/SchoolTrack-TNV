//%attributes = {}
  //dbu_CountClassStudents

MESSAGES OFF:C175
  //$message:=RP_GetIdxString (21112;27)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Contabilizando alumnos en cursos…"))
READ WRITE:C146([Cursos:3])
ALL RECORDS:C47([Cursos:3])
While (Not:C34(End selection:C36([Cursos:3])))
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Curso:7=[Cursos:3]Curso:1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=<>gYear;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=[Cursos:3]Nivel_Numero:7)
	
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_SintesisAnual:210]ID_Alumno:4;"")
	QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Status:50#"Retirado@")
	ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
	LAST RECORD:C200([Alumnos:2])
	[Cursos:3]Numero_de_Alumnos:11:=Records in selection:C76([Alumnos:2])
	[Cursos:3]LastNumber:12:=[Alumnos:2]no_de_lista:53
	SAVE RECORD:C53([Cursos:3])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Cursos:3])/Records in table:C83([Cursos:3]))
	NEXT RECORD:C51([Cursos:3])
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)