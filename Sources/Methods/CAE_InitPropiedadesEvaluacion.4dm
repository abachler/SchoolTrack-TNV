//%attributes = {}
  //CAE_InitPropiedadesEvaluacion


  // Método modificado por ABK 20110827
  // reemplazo de acceso a subtablas de consolidación (via [Asignaturas]Consolidantes por acceso estandar a tabla [Asignaturas_Consolidantes]
  //--------------------------------


  //C_LONGINT($i;$n)
  //dbu_ASClearUnrelatedEvProps 
  //PERIODOS_Init 
  //If (r1InitPropEvaluacion=1)
  //$fatObjectName:="Blob_ConfigNotas/"+"@"
  //READ WRITE([XShell_FatObjects])
  //QUERY([XShell_FatObjects];[XShell_FatObjects]FatObjectName=$fatObjectName)
  //ARRAY LONGINT($aRecNums;0)
  //SELECTION TO ARRAY([XShell_FatObjects];$aRecNums)
  //LONGINT ARRAY FROM SELECTION([XShell_FatObjects];$aRecNums;"")
  //$n:=Size of array($aRecNums)
  //$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inicializando propiedades de evaluación ")+String(<>gYear))
  //For ($i;1;$n)
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$n)
  //GOTO RECORD([XShell_FatObjects];$aRecNums{$i})
  //$id_asignatura:=Num(ST_GetWord ([XShell_FatObjects]FatObjectName;2;"/"))
  //KRL_FindAndLoadRecordByIndex (->[Asignaturas]Numero;->$id_asignatura)
  //$fatObjectName:=[XShell_FatObjects]FatObjectName
  //AScsd_InicializaPropiedades ($id_asignatura)
  //End for 
  //$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
  //Else 
  //$fatObjectName:="Blob_ConfigNotas/"+"@"
  //READ WRITE([XShell_FatObjects])
  //QUERY([XShell_FatObjects];[XShell_FatObjects]FatObjectName=$fatObjectName)
  //ARRAY LONGINT($aRecNums;0)
  //LONGINT ARRAY FROM SELECTION([XShell_FatObjects];$aRecNums;"")
  //$n:=Size of array($aRecNums)
  //$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inicializando propiedades de evaluación ")+String(<>gYear))

  //For ($i;1;$n)
  //$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$n)
  //GOTO RECORD([XShell_FatObjects];$aRecNums{$i})
  //$id_asignatura:=Num(ST_GetWord ([XShell_FatObjects]FatObjectName;2;"/"))
  //KRL_FindAndLoadRecordByIndex (->[Asignaturas]Numero;->$id_asignatura)
  //$fatObjectName:=[XShell_FatObjects]FatObjectName
  //AS_PropEval_Lectura ($fatObjectName)

  //For ($j;1;Size of array(alAS_EvalPropSourceID))
  //adAS_EvalPropDueDate{$j}:=!00-00-00!
  //If ((alAS_EvalPropSourceID{$j}<0) & (bEliminarSubasignaturas=1))
  //alAS_EvalPropSourceID{$j}:=0
  //atAS_EvalPropSourceName{$j}:="Evaluación directa"
  //atAS_EvalPropPrintName{$j}:="Evaluación Parcial N° "+String($j)
  //aiAS_EvalPropEnterable{$j}:=1
  //atAS_EvalPropDescription{$j}:=""
  //atAS_EvalPropClassName{$j}:=""
  //abAS_EvalPropPrintDetail{$j}:=False
  //End if 
  //If ((alAS_EvalPropSourceID{$j}>0) & (bInicializarConsolidaciones=1))
  //alAS_EvalPropSourceID{$j}:=0
  //atAS_EvalPropSourceName{$j}:="Evaluación directa"
  //atAS_EvalPropPrintName{$j}:="Evaluación Parcial N° "+String($j)
  //aiAS_EvalPropEnterable{$j}:=1
  //atAS_EvalPropDescription{$j}:=""
  //atAS_EvalPropClassName{$j}:=""
  //abAS_EvalPropPrintDetail{$j}:=False
  //End if 
  //If (bInitPonderaciones=1)
  //arAS_EvalPropPercent{$j}:=0
  //arAS_EvalPropCoefficient{$j}:=1
  //arAS_EvalPropPonderacion{$j}:=0
  //vi_DecimalesPonderacion:=0
  //vi_PonderacionTruncada:=0
  //End if 
  //End for 
  //If (bInitPonderaciones=1)
  //vlAS_CalcMethod:=0
  //End if 
  //AS_PropEval_Escritura ($i)  //MONO queda pendiente por que se debe cambiar también este método
  //End for 
  //FLUSH CACHE
  //$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
  //End if 

