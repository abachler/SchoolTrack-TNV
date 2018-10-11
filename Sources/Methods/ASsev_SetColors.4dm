//%attributes = {}
  //ASsev_SetColors


C_LONGINT:C283($i;$k)
If (iEvaluationMode#Simbolos)
	ARRAY INTEGER:C220(aSetRed;2;0)
	ARRAY INTEGER:C220(aSetRed{1};0)
	ARRAY INTEGER:C220(aSetRed{2};0)
	ARRAY INTEGER:C220(aSetBleu;2;0)
	ARRAY INTEGER:C220(aSetBleu{1};0)
	ARRAY INTEGER:C220(aSetBleu{2};0)
	ARRAY INTEGER:C220(aSetGreen;2;0)
	ARRAY INTEGER:C220(aSetGreen{1};0)
	ARRAY INTEGER:C220(aSetGreen{2};0)
	ARRAY INTEGER:C220(aSetViol;2;0)
	ARRAY INTEGER:C220(aSetViol{1};0)
	ARRAY INTEGER:C220(aSetViol{2};0)
	
	ARRAY TEXT:C222($aArrayNames;0)
	$err:=AL_GetArrayNames (xALP_SubEvals;$aArrayNames)
	$arrayName:=$aArrayNames{vCol}
	$colPromedio:=Find in array:C230($aArrayNames;"aSubEvalP1")
	$colControles:=Find in array:C230($aArrayNames;"aSubEvalControles")
	$colParciales:=Find in array:C230($aArrayNames;"aSubEval1")
	
	
	For ($k;1;Size of array:C274(aSubEvalID))
		NTA_SetCellClr (aRealSubEvalP1{$k};$colPromedio;$k)
		If ($colControles>0)
			NTA_SetCellClr (aRealSubEvalControles{$k};$colControles;$k)
		End if 
		
		For ($i;1;12)
			NTA_SetCellClr (aRealSubEvalArrPtr{$i}->{$k};$colParciales+$i-1;$k)
		End for 
	End for 
	
	AL_SetCellColor (xALP_SubEvals;0;0;0;0;aSetRed;"";4)
	AL_SetCellColor (xALP_SubEvals;0;0;0;0;aSetBleu;"";7)
	AL_SetCellColor (xALP_SubEvals;0;0;0;0;aSetGreen;"";10)
	AL_SetCellColor (xALP_SubEvals;0;0;0;0;aSetViol;"";240)
	ARRAY INTEGER:C220(aSetRed;0;0)
	ARRAY INTEGER:C220(aSetRed;2;0)
	ARRAY INTEGER:C220(aSetRed{1};0)
	ARRAY INTEGER:C220(aSetRed{2};0)
	ARRAY INTEGER:C220(aSetBleu;0;0)
	ARRAY INTEGER:C220(aSetBleu;2;0)
	ARRAY INTEGER:C220(aSetBleu{1};0)
	ARRAY INTEGER:C220(aSetBleu{2};0)
	ARRAY INTEGER:C220(aSetGreen;2;0)
	ARRAY INTEGER:C220(aSetGreen{1};0)
	ARRAY INTEGER:C220(aSetGreen{2};0)
	ARRAY INTEGER:C220(aSetViol;2;0)
	ARRAY INTEGER:C220(aSetViol{1};0)
	ARRAY INTEGER:C220(aSetViol{2};0)
End if 
