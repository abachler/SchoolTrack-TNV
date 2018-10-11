//%attributes = {}
  //xALCB_EN_EVLG_Evaluaciones

C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row;vCol;vRow)

AL_GetCurrCell ($1;$col;$Row)
  //EVLG_DatosAlumno ($row)
If (vRow#$row)
	vRow:=$row
	vCol:=$col
	POST KEY:C465(Character code:C91(",");256)
	AL_GotoCell ($1;$col;vRow)
End if 


