//%attributes = {}
  //PCSrun_AS_AsignaNumerosDeLista

C_LONGINT:C283($2;$l_nivel)  //MONO 184433
$mode:=$1
EVS_LoadStyles 
If (Count parameters:C259=2)  //MONO 184433
	$l_nivel:=$2  //MONO 184433
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel)  //MONO 184433
Else 
	ALL RECORDS:C47([Asignaturas:18])  //MONO 184433
End if 
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando números de orden a los alumnos en las asignaturas..."))
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
	If (Not:C34(Locked:C147([Asignaturas:18])))
		[Asignaturas:18]Numero_de_alumnos:49:=AS_fmNosOrden ($mode)
		[Asignaturas:18]LastNumber:54:=[Asignaturas:18]Numero_de_alumnos:49
	End if 
	SAVE RECORD:C53([Asignaturas:18])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Asignando números de orden a los alumnos en las asignaturas..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)