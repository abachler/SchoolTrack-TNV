READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])

C_LONGINT:C283($i)
ARRAY INTEGER:C220(aSelect;0)
$rslt:=AL_GetSelect (xALP_List;aSelect)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asociando las cuentas al Tercero ")+[ACT_Terceros:138]Nombre_Completo:9)
ARRAY LONGINT:C221(aTempID;Size of array:C274(aSelect))
For ($i;1;Size of array:C274(aSelect))
	aTempID{$i}:=aIDsAlumnos{aSelect{$i}}
	$vl_idAlumno:=aTempID{$i}
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
	KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->$vl_idAlumno)
	ACTter_Datos_ALP ("AsociaCuentas";->[ACT_CuentasCorrientes:175]ID:1)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aSelect);__ ("Asociando las cuentas al Tercero ")+[ACT_Terceros:138]Nombre_Completo:9)
End for 
InscriptOK:=True:C214
AL_UpdateArrays (xALP_List;0)
For ($i;Size of array:C274(aSelect);1;-1)
	AT_Delete (aSelect{$i};1;->aIDsAlumnos;->atACT_CCAlumno;->atACT_CCCurso)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
AL_UpdateArrays (xALP_List;Size of array:C274(atACT_CCAlumno))