//%attributes = {}
  //NTA_SetSingleCellColorsev

Case of 
	: (iEvaluationMode=Simbolos)
		If ($1<rpctMinimum)
			AL_SetCellColor (xALP_SubEvals;vCol;vRow;0;0;aInt2D1;"Red";0;"";0)
		Else 
			AL_SetCellColor (xALP_SubEvals;vCol;vRow;0;0;aInt2D1;"Blue";0;"";0)
		End if 
	: ($1=-1)
		AL_SetCellColor (xALP_SubEvals;vCol;vRow;0;0;aInt2D1;"";240;"";0)
	: ($1=-2)
		AL_SetCellColor (xALP_SubEvals;vCol;vRow;0;0;aInt2D1;"";10;"";0)
	: (($1#0) & ($1<rpctMinimum))
		AL_SetCellColor (xALP_SubEvals;vCol;vRow;0;0;aInt2D1;"Red";0;"";0)
	Else 
		AL_SetCellColor (xALP_SubEvals;vCol;vRow;0;0;aInt2D1;"Blue";0;"";0)
End case 