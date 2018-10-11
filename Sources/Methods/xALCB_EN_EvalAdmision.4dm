//%attributes = {}
  //xALCB_EN_EvalAdmision

C_LONGINT:C283($1;$2;$3)
C_LONGINT:C283(vCol;vRow)

AL_GetCurrCell (xALP_Evals;vCol;vRow)
Case of 
	: (vCol=4)  //puntajes
		vr_OldExamValue:=[ADT_Candidatos:49]Puntaje_examen:15
	: (vCol=5)  //
		vr_OldEvCondcutualValue:=[ADT_Candidatos:49]Evaluación_conductual:38
End case 