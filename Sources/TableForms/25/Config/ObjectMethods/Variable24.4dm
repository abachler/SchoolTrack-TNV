AL_RemoveFields (xALP_Hsubjects;1;1)
$err:=AL_InsertFields (xALP_Hsubjects;Table:C252(->[Asignaturas_Historico:84]);1;1;Field:C253(->[Asignaturas_Historico:84]Nombre_interno:3))
AL_SetHeaders (xALP_HSubjects;1;1;__ ("Asignaturas"))
AL_SetWidths (xALP_HSubjects;1;1;200)
AL_SetHdrStyle (xALP_HSubjects;1;"Tahoma";9;1)