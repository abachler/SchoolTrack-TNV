//%attributes = {}
  //ACTcfg_RecalculaFillerLength

For ($i;1;Size of array:C274(alACT_FillerPositions))
	alACT_Largo{alACT_FillerPositions{$i}}:=vl_LargoReg-alACT_PosFinal{alACT_FillerPositions{$i}-1}
	ACTcfg_RecalcPosRecepRecaud 
End for 