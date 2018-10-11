//%attributes = {}
  //xALSet_CU_AreaConducta

$err:=AL_SetArraysNam (xALP_Conducta_y_asistencia;1;12;"aStdNoLista";"aStdName";"aInasist";"aPctAsist";"aAtrasos";"aAtrasosInter";"aAntP";"aAntN";"aAntNeutras";"aCastigos";"aSusp";"aIDAlumno")
AL_SetHeaders (xALP_Conducta_y_asistencia;1;11;__ ("Nº");__ ("Alumno");__ ("Inasistencia");__ ("% Asist");__ ("Atrasos");__ ("Intersesión");__ ("An. +");__ ("An. -");__ ("An. =");__ ("Medidas Disciplina");__ ("Susp."))

AL_SetColOpts (xALP_Conducta_y_asistencia;0;3;0;1;0;0;0)
AL_SetMiscOpts (xALP_Conducta_y_asistencia;0;0;"'";0;1)
AL_SetSortOpts (xALP_Conducta_y_asistencia;1;1;0;"";1;1)
AL_SetRowOpts (xALP_Conducta_y_asistencia;1;0;0;0;0)
AL_SetWidths (xALP_Conducta_y_asistencia;1;11;20;219;70;50;50;70;40;40;40;120;58)
AL_SetFormat (xALP_Conducta_y_asistencia;1;"##";0)
AL_SetFormat (xALP_Conducta_y_asistencia;3;"##0";0)
AL_SetFormat (xALP_Conducta_y_asistencia;4;"|Pct_1Dec";0)
AL_SetFormat (xALP_Conducta_y_asistencia;5;"### ##0";0)
AL_SetFormat (xALP_Conducta_y_asistencia;6;"### ##0";0)
AL_SetFormat (xALP_Conducta_y_asistencia;7;"### ##0";0)
AL_SetFormat (xALP_Conducta_y_asistencia;8;"### ##0";0)
AL_SetFormat (xALP_Conducta_y_asistencia;9;"### ##0";0)
AL_SetFormat (xALP_Conducta_y_asistencia;10;"### ##0";0)
AL_SetFormat (xALP_Conducta_y_asistencia;11;"### ##0";0)
ALP_SetDefaultAppareance (xALP_Conducta_y_asistencia;9;1;4;1;6)
AL_SetInterface (xALP_Conducta_y_asistencia;AL Force OSX Interface;1;1;0;60;1)
AL_SetEnterable (xALP_Conducta_y_asistencia;0;0)
AL_SetInterface (xALP_Conducta_y_asistencia;-1;1;-1)

