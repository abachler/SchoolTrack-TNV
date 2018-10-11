//%attributes = {}
  //xALCB_EX_EvalAdmision

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_EVals;vCol;vRow)
	Case of 
		: (vCol=4)  //puntajes
			LOAD RECORD:C52([ADT_Candidatos:49])
			If ([ADT_Candidatos:49]Puntaje_examen:15#0)
				Case of 
					: ([ADT_Candidatos:49]Puntaje_examen:15<<>vrPST_minPoints)
						CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado es inferior al mínimo autorizado.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_minPoints)))
						[ADT_Candidatos:49]Puntaje_examen:15:=vr_OldExamValue
						SAVE RECORD:C53([ADT_Candidatos:49])
						AL_GotoCell (xALP_EVals;vCol;vRow)
					: ([ADT_Candidatos:49]Puntaje_examen:15><>vrPST_maxPoints)
						CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado es superior al máximo autorizado.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_maxPoints)))
						[ADT_Candidatos:49]Puntaje_examen:15:=vr_OldExamValue
						SAVE RECORD:C53([ADT_Candidatos:49])
						AL_GotoCell (xALP_EVals;vCol;vRow)
					: (Dec:C9([ADT_Candidatos:49]Puntaje_examen:15/<>vrPST_Step)>0)
						CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado esta fuera de los intervalos definidos.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_Step)))
						[ADT_Candidatos:49]Puntaje_examen:15:=vr_OldExamValue
						SAVE RECORD:C53([ADT_Candidatos:49])
						AL_GotoCell (xALP_EVals;vCol;vRow)
					: (Length:C16(Substring:C12(String:C10(Dec:C9([ADT_Candidatos:49]Puntaje_examen:15));3))><>vrPST_precision)
						BEEP:C151
						[ADT_Candidatos:49]Puntaje_examen:15:=Round:C94([ADT_Candidatos:49]Evaluación_conductual:38;<>vrPST_precision)
						SAVE RECORD:C53([ADT_Candidatos:49])
				End case 
				UNLOAD RECORD:C212([ADT_Candidatos:49])
			End if 
		: (vCol=5)  //puntajes
			LOAD RECORD:C52([ADT_Candidatos:49])
			If ([ADT_Candidatos:49]Evaluación_conductual:38#0)
				Case of 
					: ([ADT_Candidatos:49]Evaluación_conductual:38<<>vrPST_minEvConductual)
						CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado es inferior al mínimo autorizado.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_minEvConductual)))
						[ADT_Candidatos:49]Evaluación_conductual:38:=vr_OldEvCondcutualValue
						SAVE RECORD:C53([ADT_Candidatos:49])
						AL_GotoCell (xALP_EVals;vCol;vRow)
					: ([ADT_Candidatos:49]Evaluación_conductual:38><>vrPST_maxEvConductual)
						CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado es superior al máximo autorizado.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_maxEvConductual)))
						[ADT_Candidatos:49]Evaluación_conductual:38:=vr_OldEvCondcutualValue
						SAVE RECORD:C53([ADT_Candidatos:49])
						AL_GotoCell (xALP_EVals;vCol;vRow)
					: (Dec:C9([ADT_Candidatos:49]Evaluación_conductual:38/<>vrPST_StepEvConductual)>0)
						CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado esta fuera de los intervalos definidos.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_StepEvConductual)))
						[ADT_Candidatos:49]Evaluación_conductual:38:=vr_OldEvCondcutualValue
						SAVE RECORD:C53([ADT_Candidatos:49])
						AL_GotoCell (xALP_EVals;vCol;vRow)
					: (Length:C16(Substring:C12(String:C10(Dec:C9([ADT_Candidatos:49]Evaluación_conductual:38));3))><>vrPST_precisionEvConductual)
						BEEP:C151
						[ADT_Candidatos:49]Evaluación_conductual:38:=Round:C94([ADT_Candidatos:49]Evaluación_conductual:38;<>vrPST_precisionEvConductual)
						SAVE RECORD:C53([ADT_Candidatos:49])
				End case 
				UNLOAD RECORD:C212([ADT_Candidatos:49])
			End if 
	End case 
	AL_UpdateFields (xALP_EVals;1)
End if 