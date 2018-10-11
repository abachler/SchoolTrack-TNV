//%attributes = {}
  //dbu_CountSubjectStudents

MESSAGES OFF:C175
  //vMessage:=RP_GetIdxString (21112;28)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Contabilizando alumnos en asignaturas…"))
ARRAY LONGINT:C221($aRecNums;0)
READ WRITE:C146([Asignaturas:18])
C_LONGINT:C283($1;$l_nivel)  //MONO 184433

If (Count parameters:C259=1)
	$l_nivel:=$1  //MONO 184433
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel)  //MONO 184433
Else 
	ALL RECORDS:C47([Asignaturas:18])  //MONO 184433
End if 
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")  //MONO 184433

For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
	
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NoDeLista:10;<)
	[Asignaturas:18]LastNumber:54:=[Alumnos_Calificaciones:208]NoDeLista:10
	[Asignaturas:18]Numero_de_alumnos:49:=Records in selection:C76([Alumnos_Calificaciones:208])
	SAVE RECORD:C53([Asignaturas:18])
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 

UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([Asignaturas:18])
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)