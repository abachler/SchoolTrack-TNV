//%attributes = {}
  //dbuFM_MuestraNoRelacionados

ALL RECORDS:C47([Familia:78])
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando relaciones con alumnos..."))
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;1/4;__ ("Buscando relaciones con alumnos..."))
KRL_SelectOrphanRecords (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;2/4;__ ("Buscando relaciones con Personas (padres)..."))
KRL_SelectOrphanRecords (->[Personas:7]No:1;->[Familia:78]Padre_Número:5)
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;3/4;__ ("Buscando relaciones con Personas (madres)..."))
KRL_SelectOrphanRecords (->[Personas:7]No:1;->[Familia:78]Madre_Número:6)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)