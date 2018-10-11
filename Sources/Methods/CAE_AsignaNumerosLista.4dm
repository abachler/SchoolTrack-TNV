//%attributes = {}
  //CAE_AsignaNumerosLista

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando números de orden a los alumnos en los cursos..."))
READ WRITE:C146([Alumnos:2])
READ WRITE:C146([Cursos:3])

ARRAY LONGINT:C221($aRecNums;0)
C_LONGINT:C283($1;$l_nivel)  //MONO 184433
If (Count parameters:C259=1)  //MONO 184433
	$l_nivel:=$1  //MONO 184433
	QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$l_nivel)  //MONO 184433
Else 
	ALL RECORDS:C47([Cursos:3])  //MONO 184433
End if 

LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Cursos:3])
	GOTO RECORD:C242([Cursos:3];$aRecNums{$i})
	[Cursos:3]Numero_de_Alumnos:11:=AL_AsignaNoLista 
	[Cursos:3]LastNumber:12:=[Cursos:3]Numero_de_Alumnos:11
	SAVE RECORD:C53([Cursos:3])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Asignando números de orden a los alumnos en los cursos..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
UNLOAD RECORD:C212([Alumnos:2])
UNLOAD RECORD:C212([Cursos:3])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Cursos:3])