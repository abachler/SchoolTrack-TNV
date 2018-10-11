Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vr_OldExamValue:=[ADT_Candidatos:49]Puntaje_examen:15
	: (Form event:C388=On Data Change:K2:15)
		If ([ADT_Candidatos:49]Puntaje_examen:15#0)
			Case of 
				: ([ADT_Candidatos:49]Puntaje_examen:15<<>vrPST_minPoints)
					CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado es inferior al mínimo autorizado.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_minPoints)))
					[ADT_Candidatos:49]Puntaje_examen:15:=vr_OldExamValue
					GOTO OBJECT:C206(Self:C308->)
				: ([ADT_Candidatos:49]Puntaje_examen:15><>vrPST_maxPoints)
					CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado es superior al máximo autorizado.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_maxPoints)))
					[ADT_Candidatos:49]Puntaje_examen:15:=vr_OldExamValue
					GOTO OBJECT:C206(Self:C308->)
				: (Dec:C9([ADT_Candidatos:49]Puntaje_examen:15/<>vrPST_Step)>0)
					CD_Dlog (0;Replace string:C233(__ ("El puntaje ingresado esta fuera de los intervalos definidos.\rPor favor verifique e intente nuevamente.");__ ("^0");String:C10(<>vrPST_Step)))
					[ADT_Candidatos:49]Puntaje_examen:15:=vr_OldExamValue
					GOTO OBJECT:C206(Self:C308->)
				: (Length:C16(Substring:C12(String:C10(Dec:C9([ADT_Candidatos:49]Puntaje_examen:15));3))><>vrPST_precision)
					BEEP:C151
					[ADT_Candidatos:49]Puntaje_examen:15:=Round:C94([ADT_Candidatos:49]Evaluación_conductual:38;<>vrPST_precision)
			End case 
		End if 
End case 