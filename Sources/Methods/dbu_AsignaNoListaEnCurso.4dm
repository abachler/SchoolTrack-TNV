//%attributes = {}
  //dbu_AsignaNoListaEnCurso

MESSAGES OFF:C175
If (Application type:C494#4D Server:K5:6)
	iOK:=CD_Dlog (0;__ ("¿Desea Ud. reasignar el Nº de orden de los alumnos en los cursos?");__ ("");__ ("Si");__ ("Cancelar"))
Else 
	iOK:=1
End if 
If (iOK=1)
	READ WRITE:C146([Alumnos:2])
	READ WRITE:C146([Cursos:3])
	ALL RECORDS:C47([Cursos:3])
	CREATE SET:C116([Cursos:3];"a")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando números de orden a los alumnos en los cursos..."))
	For ($k;1;Records in set:C195("a"))
		USE SET:C118("a")
		GOTO SELECTED RECORD:C245([Cursos:3];$k)
		If (Locked:C147([Cursos:3]))
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			$Process:=IT_UThermometer (1;0;__ ("Esperando que se libere el registro del curso ")+[Cursos:3]Curso:1)
			While (Locked:C147([Cursos:3]))
				LOAD RECORD:C52([Cursos:3])
			End while 
			IT_UThermometer (-2;$Process)
			$records:=Records in set:C195("a")
			$l_ProgressProcID:=IT_Progress (1;$k/$records*100;$l_ProgressProcID;__ ("Asignando números de orden a los alumnos en los cursos..."))
			READ WRITE:C146([Cursos:3])
			TRACE:C157
		End if 
		[Cursos:3]Numero_de_Alumnos:11:=AL_AsignaNoLista 
		[Cursos:3]LastNumber:12:=[Cursos:3]Numero_de_Alumnos:11
		SAVE RECORD:C53([Cursos:3])
		$set:=Records in set:C195("a")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/$set)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	KRL_UnloadReadOnly (->[Alumnos:2])
	KRL_UnloadReadOnly (->[Cursos:3])
End if 
