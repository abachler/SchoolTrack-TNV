//%attributes = {}
  //dbu_ZeroingPonderaciones


  //ALL RECORDS([Asignaturas])
  //SELECTION TO ARRAY([Asignaturas];$aRecNums)

  //$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inicializando ponderaciones y coeficientes ")+String(<>gYear))
  //$fatObjectName:="Blob_ConfigNotas/"+"@"
  //READ WRITE([XShell_FatObjects])
  //QUERY([XShell_FatObjects];[XShell_FatObjects]FatObjectName=$fatObjectName)
  //SELECTION TO ARRAY([XShell_FatObjects];$aRecNums)
  //$n:=Size of array($aRecNums)
  //For ($i;1;$n)
  //GOTO RECORD([XShell_FatObjects];$aRecNums{$i})
  //AS_PropEval_Lectura ([XShell_FatObjects]FatObjectName)
  //For ($j;1;Size of array(arAS_EvalPropPercent))
  //arAS_EvalPropPercent{$j}:=0
  //arAS_EvalPropCoefficient{$j}:=1
  //End for 
  //vlAS_CalcMethod:=0
  //AS_PropEval_Escritura ([XShell_FatObjects]FatObjectName)
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$n)
  //End for 
  //$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
