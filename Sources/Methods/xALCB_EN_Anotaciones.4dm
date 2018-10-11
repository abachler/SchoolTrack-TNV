//%attributes = {}
  //xALCB_EN_Anotaciones

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
AL_GetCurrCell (xALP_ConductaAlumnos;vCol;vRow)
Case of 
	: (vCol=3)
		If (adSTRal_FechaAnotacion{vRow}=!00-00-00!)
			BEEP:C151
			AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
		End if 
	: (vCol=2)
		If (adSTRal_FechaAnotacion{vRow}=!00-00-00!)
			BEEP:C151
			AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
		End if 
End case 