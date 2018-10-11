$line:=AL_GetLine (xALP_PlanNivel)
If ($line>0)
	AL_UpdateArrays (xALP_PlanNivel;0)
	AT_Insert ($line;1;->aSubject;->aOrder;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
	For ($i;1;Size of array:C274(aSubject))
		aOrder{$i}:=$i
	End for 
	AL_UpdateArrays (xALP_PlanNivel;-2)
	GOTO OBJECT:C206(xALP_PlanNivel)
	AL_GotoCell (xALP_PlanNivel;2;$line)
	AL_SetCellHigh (xALP_PlanNivel;1;1)
End if 