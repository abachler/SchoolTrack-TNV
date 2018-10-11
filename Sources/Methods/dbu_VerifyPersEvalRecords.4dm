//%attributes = {}
  //dbu_VerifyPersEvalRecords


$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando registros de evaluación personal…"))
QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;>=;Nivel_AdmisionDirecta*1;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29;<;Nivel_Egresados*1)
APPLY TO SELECTION:C70([Alumnos:2];dbu_ßVerifyPersEvalRecords )
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)