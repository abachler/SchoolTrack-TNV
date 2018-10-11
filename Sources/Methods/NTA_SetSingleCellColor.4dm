//%attributes = {}
  //NTA_SetSingleCellColor

Case of 
	: (iEvaluationMode=Simbolos)
		Case of 
			: ($1=-1)
				AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";240;"";0)
			: ($1=-2)
				AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";10;"";0)
			: ($1=-4)
				AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";16;"";0)
			Else 
				If ($1<rpctMinimum)
					AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";4;"";0)
				Else 
					AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";7;"";0)
				End if 
		End case 
	: ($1=-1)
		AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";240;"";0)
	: ($1=-2)
		AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";10;"";0)
	: ($1=-4)
		AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";16;"";0)
	: (($1>=vrNTA_MinimoEscalaReferencia) & ($1<rpctMinimum))
		AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";4;"";0)
	Else 
		AL_SetCellColor (xALP_ASNotas;vCol;vRow;0;0;aInt2D1;"";7;"";0)
End case 