
C_LONGINT:C283($i)
ARRAY INTEGER:C220(aSelect;0)
$rslt:=AL_GetSelect (xALP_List;aSelect)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inscribiendo a los alumnos seleccionados en ")+[Asignaturas:18]denominacion_interna:16)
ARRAY LONGINT:C221(aTempID;Size of array:C274(aSelect))
For ($i;1;Size of array:C274(aSelect))
	aTempID{$i}:=aIDsAlumnos{aSelect{$i}}
End for 
$idAsignatura:=[Asignaturas:18]Numero:1
$recNum:=Record number:C243([Asignaturas:18])
QRY_QueryWithArray (->[Alumnos:2]numero:1;->aTempID)
QUERY:C277([Cursos:3];[Cursos:3]Curso:1=aClsSel{aClsSel})
ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	AS_CreaRegistrosEvaluacion ([Alumnos:2]numero:1;$idAsignatura)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
KRL_GotoRecord (->[Asignaturas:18];$recNum;True:C214)

InscriptOK:=True:C214
AL_UpdateArrays (xALP_List;0)
For ($i;Size of array:C274(aSelect);1;-1)
	AT_Delete (aSelect{$i};1;->aIDsAlumnos;->aNombresAlumnos)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
AL_UpdateArrays (xALP_List;Size of array:C274(aNombresAlumnos))