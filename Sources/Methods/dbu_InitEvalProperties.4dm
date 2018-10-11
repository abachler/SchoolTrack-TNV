//%attributes = {}
  // MÉTODO: dbu_InitEvalProperties
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 17:33:47
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // dbu_InitEvalProperties()
  // ----------------------------------------------------
C_LONGINT:C283($l_asignaturas;$i)
ARRAY LONGINT:C221($al_recNums;0)



  // CODIGO PRINCIPAL
READ WRITE:C146([xxSTR_Subasignaturas:83])
ALL RECORDS:C47([xxSTR_Subasignaturas:83])
DELETE SELECTION:C66([xxSTR_Subasignaturas:83])

QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="Blob_ConfigNotas/@")
KRL_DeleteSelection (->[XShell_FatObjects:86])

READ WRITE:C146([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18];$al_recNums)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inicializando Propiedades de evaluación"))
For ($l_asignaturas;1;Size of array:C274($al_recNums))
	GOTO RECORD:C242([Asignaturas:18];$al_recNums{$l_asignaturas})
	[Asignaturas:18]Consolidacion_EsConsolidante:35:=False:C215
	[Asignaturas:18]Consolidacion_ConSubasignaturas:31:=False:C215
	[Asignaturas:18]Consolidacion_Metodo:55:=0
	[Asignaturas:18]Consolidacion_TipoPonderacion:50:=0
	[Asignaturas:18]Consolidacion_PorPeriodo:58:=False:C215
	[Asignaturas:18]Consolidacion_Madre_Id:7:=0
	[Asignaturas:18]Consolidacion_Madre_nombre:8:=""
	AScsd_EliminaReferencias ([Asignaturas:18]Numero:1)
	
	AS_PropEval_Lectura 
	For ($i;1;12)
		aiAS_EvalPropColumnIndex{$i}:=$i
		atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
		alAS_EvalPropSourceID{$i}:=0
		aiAS_EvalPropEnterable{$i}:=1
		arAS_EvalPropCoefficient{$i}:=1
		arAS_EvalPropPercent{$i}:=0
		atAS_EvalPropDescription{$i}:=""
		abAS_EvalPropPrintDetail{$i}:=False:C215
		atAS_EvalPropClassName{$i}:=""
		atAS_EvalPropPrintName{$i}:=""
		adAS_EvalPropDueDate{$i}:=!00-00-00!
	End for 
	AS_PropEval_Escritura (0)  //MONO CAMBIO AS_PropEval_Escritura 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_asignaturas/Size of array:C274($al_recNums);__ ("Inicializando Propiedades de evaluación"))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

