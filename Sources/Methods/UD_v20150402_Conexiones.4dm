//%attributes = {}
  //UD_v20150402_Conexiones
  //MONO CONEXIONES
  //crea la relación con alumnos_conexiones con alumnos por el uuid del alumno
C_LONGINT:C283($i)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando Conexiones...")
READ ONLY:C145([Alumnos:2])
ALL RECORDS:C47([Alumnos:2])
ARRAY LONGINT:C221($al_rn_alu;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_rn_alu;"")

For ($i;1;Size of array:C274($al_rn_alu))
	GOTO RECORD:C242([Alumnos:2];$al_rn_alu{$i})
	ARRAY TEXT:C222($at_uuid;0)
	_O_ALL SUBRECORDS:C109([Alumnos:2]Conexiones:18)
	SF_Subtable2Array (->[Alumnos:2]Conexiones:18;->[Alumnos]Conexiones'Auto_UUID;->$at_uuid)
	
	If (Size of array:C274($at_uuid)>0)
		READ WRITE:C146([Alumnos_Conexiones:212])
		QUERY WITH ARRAY:C644([Alumnos_Conexiones:212]Auto_UUID:6;$at_uuid)
		APPLY TO SELECTION:C70([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72)
		KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
	End if 
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_rn_alu))
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)