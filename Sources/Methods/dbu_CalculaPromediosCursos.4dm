//%attributes = {}
  //dbu_CalculaPromediosCursos

EVS_LoadStyles 
ALL RECORDS:C47([Cursos:3])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando promedios de los cursos..."))
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Cursos:3];$aRecNums{$i})
	$ignore:=CU_CalculaPromedios ($aRecNums{$i})
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Calculando promedios de los cursos..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

