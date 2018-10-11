//%attributes = {}
  //CU_DefaultJefaturaRepSettings

C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
  //MONO 205952
ARRAY INTEGER:C220(aiCU_DispersionRango;0)
ARRAY INTEGER:C220(aiCU_DispersionRango;8)
ARRAY TEXT:C222(atCU_DispersionFrom;0)
ARRAY TEXT:C222(atCU_DispersionTo;0)
ARRAY REAL:C219(arCU_DispersionFrom;0)
ARRAY REAL:C219(arCU_DispersionTo;0)
ARRAY TEXT:C222(atCU_DispersionFrom;8)
ARRAY TEXT:C222(atCU_DispersionTo;8)
ARRAY REAL:C219(arCU_DispersionFrom;8)
ARRAY REAL:C219(arCU_DispersionTo;8)


If (vlEVS_DefaultStyleID=0)  //MONO 205952
	READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
	ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
	ORDER BY:C49([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1;>)
	vlEVS_DefaultStyleID:=[xxSTR_EstilosEvaluacion:44]ID:1
	REDUCE SELECTION:C351([xxSTR_EstilosEvaluacion:44];0)
End if 

EVS_ReadStyleData (vlEVS_DefaultStyleID)
For ($i;1;Size of array:C274(aiCU_DispersionRango))
	aiCU_DispersionRango{$i}:=$i
End for 
arCU_DispersionFrom{1}:=Round:C94(1/7*100;11)
arCU_DispersionTo{1}:=Round:C94(3.9/7*100;11)
arCU_DispersionFrom{2}:=Round:C94(4/7*100;11)
arCU_DispersionTo{2}:=Round:C94(4.9/7*100;11)
arCU_DispersionFrom{3}:=Round:C94(5/7*100;11)
arCU_DispersionTo{3}:=Round:C94(5.9/7*100;11)
arCU_DispersionFrom{4}:=Round:C94(6/7*100;11)
arCU_DispersionTo{4}:=Round:C94(7/7*100;11)
For ($i;1;8)
	atCU_DispersionFrom{$i}:=NTA_PercentValue2StringValue (arCU_DispersionFrom{$i};iEvaluationMode)
	atCU_DispersionTo{$i}:=NTA_PercentValue2StringValue (arCU_DispersionTo{$i};iEvaluationMode)
End for 
iPosAnot:=3
iNegAnot:=3
iDet:=3
iSusp:=1
bNoPbl:=1
r0_Todas:=0
r1_EnPromedioInterno:=1
r1_EnPromedioOficial:=0
r3_madres:=0
rAvgMinAsignaturaPercent:=Round:C94(4/7*100;11)
rAvgSupPercent:=Round:C94(6/7*100;11)
rAvgInfPercent:=Round:C94(4/7*100;11)
rAvgMinPercent:=rPctMinimum
vl_sinprofesor:=0  //MONO 205952

ARRAY TEXT:C222(aEvStyleType;2)
  // MOD Ticket N° 209201 Patricio Aliaga 20180705
  //$el:=Find in array(aEvStyleID;vlEVS_DefaultStyleID)
  //If ($el>0)
  //vi_SelectedStyle:=$el
vi_SelectedStyle:=vlEVS_DefaultStyleID
  //End if 
vi_StyleType:=1

  //settings default blob preferences
BLOB_Variables2Blob (->xBlob;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->r3_Madres;->vl_sinprofesor)  //MONO 205952
PREF_SetBlob (0;"DispersionNotasEnInformeJefatura";xBlob)