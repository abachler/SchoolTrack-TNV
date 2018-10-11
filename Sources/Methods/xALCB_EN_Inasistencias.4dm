//%attributes = {}
  //xALCB_EN_Inasistencias

C_LONGINT:C283($1;$2)
C_LONGINT:C283($1;$2)
AL_GetCurrCell (xALP_ConductaAlumnos;vCol;vRow)
Case of 
		  // : (◊aCdtaLong1{vRow} # 0)
		  //AL_ExitCell (areaCdta)
	: (vCol>1)
		If (<>aCdtaDate{vRow}=!00-00-00!)
			AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
		End if 
End case 