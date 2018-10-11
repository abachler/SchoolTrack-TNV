//%attributes = {}
  //ASev2_ColorCeldasXPais

ARRAY INTEGER:C220($al_arregloD2Celdas;2;0)
Case of 
	: (<>gCountryCode="ar")
		If (aNtaReprobada{vRow})
			If (aRealNtaF{vRow}<rPctMinimum) & (aRealNtaF{vRow}>0)
				AL_SetCellColor (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;"Red";0;"";0)
			Else 
				AL_SetCellColor (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;"Black";0;"";0)
			End if 
		Else 
			AL_SetCellColor (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;"Black";0;"";0)
		End if 
	Else 
		If (aNtaReprobada{vRow})
			AL_SetCellColor (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;"Red";0;"";0)
		Else 
			AL_SetCellColor (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;"Black";0;"";0)
		End if 
End case 
