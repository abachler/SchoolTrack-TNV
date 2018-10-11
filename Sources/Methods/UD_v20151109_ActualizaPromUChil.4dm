//%attributes = {}
  //UD_v20151109_ActualizaPromUChile

C_LONGINT:C283($i)

ARRAY LONGINT:C221($aRecNum;0)

EVS_initialize 
QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=12)
SELECTION TO ARRAY:C260([Alumnos:2];$aRecNum)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Calculando promedios...")
For ($i;1;Size of array:C274($aRecNum))
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];$aRecNum{$i})
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);"Calculando datos Egreso para el alumno(a): "+[Alumnos:2]apellidos_y_nombres:40)
	If ([Alumnos:2]nivel_numero:29=Nivel_Egresados)
		AL_PromedioUChileEgresados_cl 
	Else 
		AL_PromedioUChile_cl 
	End if 
	KRL_UnloadReadOnly (->[Alumnos:2])
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[Alumnos:2])
