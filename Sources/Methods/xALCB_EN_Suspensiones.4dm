//%attributes = {}
  //xALCB_EN_Suspensiones

C_LONGINT:C283($1;$2)
AL_GetCurrCell (xALP_ConductaAlumnos;vCol;vRow)
Case of 
	: (vCol>2)
		If (<>aCdtaDate{vRow}=!00-00-00!)
			BEEP:C151
			AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
		Else 
			If (<>aCdtaDate2{vRow}=!00-00-00!)
				BEEP:C151
				AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
			Else 
				If ((<>aCdtatext1{vRow}="") & (vCol>3))
					CD_Dlog (0;__ ("Ingrese el motivo de la suspensión."))
					AL_GotoCell (xALP_ConductaAlumnos;2;vRow)
				End if 
			End if 
		End if 
	: (vCol=2)
		If (<>aCdtaDate{vRow}=!00-00-00!)
			BEEP:C151
			AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
		End if 
End case 
