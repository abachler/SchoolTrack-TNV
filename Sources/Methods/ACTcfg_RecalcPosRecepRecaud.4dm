//%attributes = {}
  //ACTcfg_RecalcPosRecepRecaud

AL_UpdateArrays (xALP_RecepRecaud;0)
For ($i;1;Size of array:C274(alACT_Campo))
	If (alACT_Campo{$i}>1)
		If (alACT_Largo{$i}>0)
			$PosIni:=alACT_PosFinal{$i-1}+1
		Else 
			$PosIni:=alACT_PosFinal{$i-1}
		End if 
	Else 
		$PosIni:=1
	End if 
	If (alACT_Largo{$i}>0)
		$PosFinal:=$PosIni+alACT_Largo{$i}-1
	Else 
		$PosFinal:=$PosIni
	End if 
	alACT_PosIni{$i}:=$PosIni
	alACT_PosFinal{$i}:=$PosFinal
	atACT_Posicion{$i}:=String:C10($PosIni)+" - "+String:C10($PosFinal)
End for 
AL_UpdateArrays (xALP_RecepRecaud;-2)