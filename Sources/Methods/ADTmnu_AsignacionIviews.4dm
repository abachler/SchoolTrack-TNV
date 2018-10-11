//%attributes = {}
  //ADTmnu_AsignacionIviews

ADTmnu_CheckFamSexGroup 
IT_MODIFIERS 

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia:78])
READ WRITE:C146([ADT_Candidatos:49])
If ((<>option) & (<>command) & (<>Shift))
	ok:=CD_Dlog (0;Replace string:C233(__ ("Usted ha solicitado reasignar horarios para ˆ0. \rSi realiza esta operación deberá comunicar esta modificación a todas las personas que ya tenían horario asignado.\r\r¿Desea realmente reasignar horarios para ˆ0?");__ ("ˆ0");__ ("ENTREVISTAS"));__ ("");__ ("No");__ ("Sí"))
	If (ok=2)
		ALL RECORDS:C47([ADT_Candidatos:49])
	End if 
Else 
	CD_Dlog (0;__ ("Las fechas de entrevista serán asignadas automáticamente a todos los candidatos sin fecha asignada."))
	QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Fecha_de_Entrevista:4=!00-00-00!)
	ok:=2
End if 
If (ok=2)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando fechas para entrevistas…"))
	FIRST RECORD:C50([ADT_Candidatos:49])
	While (Not:C34(End selection:C36([ADT_Candidatos:49])))
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
		If ([Alumnos:2]Familia_Número:24#0)
			QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
			If ([Familia:78]Es_Postulante:18)
				[ADT_Candidatos:49]Es_familia_nueva:27:=True:C214
				READ ONLY:C145([ADT_Entrevistas:121])
				QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=[Alumnos:2]Familia_Número:24)
				If ((Records in selection:C76([ADT_Entrevistas:121])=0) & (viPST_AutoAsigInterview=1))
					$date:=Current date:C33(*)
					READ WRITE:C146([ADT_Entrevistas:121])
					QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=0;*)
					QUERY:C277([ADT_Entrevistas:121]; & [ADT_Entrevistas:121]Date_IView:2>$date)
					ORDER BY:C49([ADT_Entrevistas:121];[ADT_Entrevistas:121]Date_IView:2;>;[ADT_Entrevistas:121]Start_IView:3;>)
					If (Records in selection:C76([ADT_Entrevistas:121])>0)
						[ADT_Entrevistas:121]ID_familia:5:=[Alumnos:2]Familia_Número:24
						SAVE RECORD:C53([ADT_Entrevistas:121])
					End if 
					KRL_ReloadAsReadOnly (->[ADT_Entrevistas:121])
					READ ONLY:C145([Profesores:4])
					RELATE ONE:C42([ADT_Entrevistas:121]ID_Funcionario:1)
					[ADT_Candidatos:49]Fecha_de_Entrevista:4:=[ADT_Entrevistas:121]Date_IView:2
					[ADT_Candidatos:49]Hora_de_entrevista:17:=[ADT_Entrevistas:121]Start_IView:3
					[ADT_Candidatos:49]Entrevistador:20:=[Profesores:4]Apellidos_y_nombres:28
				End if 
				SAVE RECORD:C53([ADT_Candidatos:49])
			End if 
		End if 
		NEXT RECORD:C51([ADT_Candidatos:49])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ADT_Candidatos:49])/Records in selection:C76([ADT_Candidatos:49]);__ ("Asignando fechas para entrevistas"))
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
KRL_UnloadReadOnly (->[ADT_Candidatos:49])
KRL_UnloadReadOnly (->[ADT_Entrevistas:121])