//%attributes = {}
  // MÉTODO: dbu_RecalculaPromediosSubAsig
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 18:10:32
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // dbu_RecalculaPromediosSubAsig()
  // ----------------------------------------------------
C_BLOB:C604($x_recNumArray)
C_LONGINT:C283($l_elemento;$i;$iSubEval;$j;$k;$l_ProgressProcID;$l_recNumAsignaturas;$l_offsetBlob)
C_REAL:C285($r_valorAntesRecalculo)

ARRAY LONGINT:C221($al_recNumsAsignatura;0)
ARRAY LONGINT:C221($al_recNumsAsignatura_Recalculo;0)
ARRAY LONGINT:C221($aRecNums;0)



  // CODIGO PRINCIPAL
EVS_LoadStyles 

ALL RECORDS:C47([xxSTR_Subasignaturas:83])
ORDER BY:C49([xxSTR_Subasignaturas:83]ID_Mother:6;>)
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Subasignaturas:83];$al_recNumsAsignatura;"")

$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;0;__ ("Recalculando promedios de subasignaturas..."))
For ($i;1;Size of array:C274($al_recNumsAsignatura))
	READ WRITE:C146([xxSTR_Subasignaturas:83])
	GOTO RECORD:C242([xxSTR_Subasignaturas:83];$al_recNumsAsignatura{$i})
	$l_recNumAsignaturas:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[xxSTR_Subasignaturas:83]ID_Mother:6)
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	vi_lastGradeView:=iEvaluationMode
	
	ASsev_InitArrays 
	<>crtSEvalPerPtr:=->aSubEvalP1
	ARRAY REAL:C219(aRealTemp;0)
	ARRAY POINTER:C280(aSubEvalArrPtr;12)
	ARRAY POINTER:C280(aRealSubEvalArrPtr;12)
	ARRAY TEXT:C222(aRealSubEvalArrNames;12)
	For ($k;1;12)
		aSubEvalArrPtr{$k}:=Get pointer:C304("aSubEval"+String:C10($k))
		aRealSubEvalArrPtr{$k}:=Get pointer:C304("aRealSubEval"+String:C10($k))
		aRealSubEvalArrNames{$k}:="aRealSubEval"+String:C10($k)
	End for 
	
	  //MONO TICKET 187315 
	  //$l_offsetBlob:=0
	  //$l_offsetBlob:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_offsetBlob;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalID;"aSubEvalID")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStdNme;"aSubEvalStdNme")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalCurso;"aSubEvalCurso")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStatus;"aSubEvalStatus")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalOrden;"aSubEvalOrden")
	
	For ($j;1;Size of array:C274(aSubEvalArrPtr))
		  //$l_offsetBlob:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_offsetBlob;aRealSubEvalArrPtr{$j})
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
	End for 
	  //$l_offsetBlob:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_offsetBlob;->aRealSubEvalP1)
	  //$l_offsetBlob:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_offsetBlob;->aRealSubEvalControles)
	  //$l_offsetBlob:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_offsetBlob;->aRealSubEvalPresentacion)
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalP1;"aRealSubEvalP1")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalControles;"aRealSubEvalControles")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
	
	_O_ARRAY STRING:C218(5;aSubEvalP1;Size of array:C274(aRealSubEvalP1))
	_O_ARRAY STRING:C218(5;aSubEvalPresentacion;Size of array:C274(aRealSubEvalP1))
	_O_ARRAY STRING:C218(5;aSubEvalControles;Size of array:C274(aRealSubEvalP1))
	modSubEvals:=False:C215
	For ($iSubEval;1;Size of array:C274(aSubEvalId))
		$r_valorAntesRecalculo:=aRealSubEvalP1{$iSubEval}
		ASsev_Average ($iSubEval)
		If ($r_valorAntesRecalculo#aRealSubEvalP1{$iSubEval})
			modSubEvals:=True:C214
		End if 
	End for 
	
	If (modSubEvals)
		SET BLOB SIZE:C606([xxSTR_Subasignaturas:83]Data:4;0)
		$l_elemento:=Find in array:C230($al_recNumsAsignatura_Recalculo;$l_recNumAsignaturas)
		If ($l_elemento<0)
			APPEND TO ARRAY:C911($al_recNumsAsignatura_Recalculo;$l_recNumAsignaturas)
		End if 
		ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
	End if 
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumsAsignatura)*100;"Recalculando promedios de subasignaturas...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Size of array:C274($al_recNumsAsignatura)>0)
	BLOB_Variables2Blob (->$x_recNumArray;0;->$al_recNumsAsignatura_Recalculo)
	EV2dbu_Recalculos ($x_recNumArray)
End if 

