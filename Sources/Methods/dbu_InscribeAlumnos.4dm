//%attributes = {}
  //dbu_InscribeAlumnos

C_TEXT:C284($setName;$1)

If (Count parameters:C259=1)
	$setName:=$1
	USE SET:C118($setName)
	
Else 
	
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=-5;*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<=12;*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50;#;"Retitrado@")
End if 


ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")

$s:=Size of array:C274($aRecNums)
For ($i;1;$s)
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	AL_CreateGradeRecords 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$s;__ ("Incribiendo alumnos en asignaturas..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)