$line:=AL_GetLine (xALP_PlanNivel)
If ($line>0)
	AL_UpdateArrays (xALP_PlanNivel;0)
	AT_Delete ($line;1;->aSubject;->aOrder;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
	For ($i;1;Size of array:C274(aSubject))
		aOrder{$i}:=$i
	End for 
	AL_UpdateArrays (xALP_PlanNivel;-2)
Else 
	BEEP:C151
End if 