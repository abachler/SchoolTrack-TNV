
For ($i;1;Size of array:C274(aSubEvalId))
	$el:=Find in array:C230(aIdAlumnos_a_Recalcular;aSubEvalID{$i})
	If ($el<0)
		APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;aSubEvalID{$i})
	End if 
	$valorAntesRecalculo:=aRealSubEvalP1{$i}
	ASsev_Average ($i)
	If ($valorAntesRecalculo#aRealSubEvalP1{$i})
		modSubEvals:=True:C214
	End if 
	
	  //If (◊gNaColor)
	ARRAY INTEGER:C220(aInt2D1;0;0)
	NTA_SetSingleCellColorsev (aRealSubEvalP1{$i})
End for 

AL_UpdateArrays (xALP_SubEvals;-1)
  //End if 