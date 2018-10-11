Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vr_OldEvCondcutualValue:=[ADT_Candidatos:49]Evaluación_conductual:38
	: (Form event:C388=On Data Change:K2:15)
		If ([ADT_Candidatos:49]Evaluación_conductual:38#0)
			Case of 
				: ([ADT_Candidatos:49]Evaluación_conductual:38<<>vrPST_minEvConductual)
					CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado es inferior al mínimo autorizado.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_minEvConductual)))
					[ADT_Candidatos:49]Evaluación_conductual:38:=vr_OldEvCondcutualValue
					GOTO OBJECT:C206(Self:C308->)
				: ([ADT_Candidatos:49]Evaluación_conductual:38><>vrPST_maxEvConductual)
					CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado es superior al máximo autorizado.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_maxEvConductual)))
					[ADT_Candidatos:49]Evaluación_conductual:38:=vr_OldEvCondcutualValue
					GOTO OBJECT:C206(Self:C308->)
				: (Dec:C9([ADT_Candidatos:49]Evaluación_conductual:38/<>vrPST_StepEvConductual)>0)
					CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado esta fuera de los intervalos definidos.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_StepEvConductual)))
					[ADT_Candidatos:49]Evaluación_conductual:38:=vr_OldEvCondcutualValue
					GOTO OBJECT:C206(Self:C308->)
				: (Length:C16(Substring:C12(String:C10(Dec:C9([ADT_Candidatos:49]Evaluación_conductual:38));3))><>vrPST_precisionEvConductual)
					BEEP:C151
					[ADT_Candidatos:49]Evaluación_conductual:38:=Round:C94([ADT_Candidatos:49]Evaluación_conductual:38;<>vrPST_precisionEvConductual)
			End case 
		End if 
End case 