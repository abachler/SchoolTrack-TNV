//%attributes = {}
  //ADTmnu_AsignacionPresent

ADTmnu_CheckFamSexGroup 
IT_MODIFIERS 

READ ONLY:C145([Familia:78])
READ ONLY:C145([Alumnos:2])
READ WRITE:C146([ADT_Candidatos:49])
If ((<>option) & (<>command) & (<>Shift))
	ok:=CD_Dlog (0;Replace string:C233(__ ("Usted ha solicitado reasignar horarios para ˆ0. \rSi realiza esta operación deberá comunicar esta modificación a todas las personas que ya tenían horario asignado.\r\r¿Desea realmente reasignar horarios para ˆ0?");__ ("ˆ0");__ ("PRESENTACIONES"));__ ("");__ ("No");__ ("Sí"))
	If (ok=2)
		ALL RECORDS:C47([ADT_Candidatos:49])
	End if 
Else 
	CD_Dlog (0;__ ("Las fechas de presentación serán asignadas automáticamente a todos los candidatos sin fecha asignada."))
	QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Fecha_de_presentación:5=!00-00-00!)
	ok:=2
End if 

If (ok=2)
	ARRAY LONGINT:C221($aRNCandidatos;0)
	LONGINT ARRAY FROM SELECTION:C647([ADT_Candidatos:49];$aRNCandidatos;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando fechas para presentaciones…"))
	For ($x;1;Size of array:C274($aRNCandidatos))
		GOTO RECORD:C242([ADT_Candidatos:49];$aRNCandidatos{$x})
		$flia:=[Alumnos:2]Familia_Número:24
		$id:=[ADT_Candidatos:49]Candidato_numero:1
		SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Familia_numero:30=$flia;*)
		QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]secs_Presentación:23#0;*)
		QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]Candidato_numero:1#$id)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($recs=0)
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
			If ([Alumnos:2]Familia_Número:24#0)
				QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
				If ([Familia:78]Es_Postulante:18)
					If ([ADT_Candidatos:49]Asistentes_presentación:22=0)
						If (([Familia:78]Padre_Número:5#0) & ([Familia:78]Madre_Número:6#0))
							[ADT_Candidatos:49]Asistentes_presentación:22:=2
						Else 
							[ADT_Candidatos:49]Asistentes_presentación:22:=1
						End if 
					End if 
					
					$presentationAsigned:=False:C215
					AT_MultiLevelSort (">>";->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
					For ($i;1;Size of array:C274(aiPST_Asistentes))
						If ((aiPST_Asistentes{$i}+[ADT_Candidatos:49]Asistentes_presentación:22)<=viPST_MaxPerPresentation)
							[ADT_Candidatos:49]secs_Presentación:23:=SYS_DateTime2Secs (adPST_PresentDate{$i};aLPST_PresentTime{$i})
							[ADT_Candidatos:49]Fecha_de_presentación:5:=adPST_PresentDate{$i}
							[ADT_Candidatos:49]Hora_de_presentación:18:=aLPST_PresentTime{$i}
							$presentationAsigned:=True:C214
							SAVE RECORD:C53([ADT_Candidatos:49])
							$rn:=Record number:C243([ADT_Candidatos:49])
							While (Semaphore:C143("Saving_parameters"))
								DELAY PROCESS:C323(Current process:C322;5)
							End while 
							aiPST_Asistentes{$i}:=aiPST_Asistentes{$i}+[ADT_Candidatos:49]Asistentes_presentación:22
							PST_SaveParameters 
							If ($rn#-1)
								GOTO RECORD:C242([ADT_Candidatos:49];$rn)
							End if 
							CLEAR SEMAPHORE:C144("Saving_parameters")
							$i:=Size of array:C274(aiPST_Asistentes)+1
						End if 
					End for 
					SAVE RECORD:C53([ADT_Candidatos:49])
				End if 
			End if 
			SAVE RECORD:C53([ADT_Candidatos:49])
		Else 
			PUSH RECORD:C176([ADT_Candidatos:49])
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Familia_numero:30=$flia;*)
			QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]secs_Presentación:23#0;*)
			QUERY:C277([ADT_Candidatos:49]; & ;[ADT_Candidatos:49]Candidato_numero:1#$id)
			$dts:=[ADT_Candidatos:49]secs_Presentación:23
			$fecha:=[ADT_Candidatos:49]Fecha_de_presentación:5
			$hora:=[ADT_Candidatos:49]Hora_de_presentación:18
			POP RECORD:C177([ADT_Candidatos:49])
			[ADT_Candidatos:49]secs_Presentación:23:=$dts
			[ADT_Candidatos:49]Fecha_de_presentación:5:=$fecha
			[ADT_Candidatos:49]Hora_de_presentación:18:=$hora
			SAVE RECORD:C53([ADT_Candidatos:49])
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$x/Size of array:C274($aRNCandidatos))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
KRL_UnloadReadOnly (->[ADT_Candidatos:49])