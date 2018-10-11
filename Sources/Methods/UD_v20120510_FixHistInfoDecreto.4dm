//%attributes = {}
  //UD_v20120510_FixHistInfoDecreto
If (<>gCountryCode="cl")
	ARRAY LONGINT:C221(aQR_longint1;0)
	READ ONLY:C145([Alumnos_Historico:25])
	READ ONLY:C145([Alumnos:2])
	ALL RECORDS:C47([Alumnos_Historico:25])
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Historico:25];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Corrigiendo info decretos en historico...")
	For (vQR_longint1;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Historico:25])
		GOTO RECORD:C242([Alumnos_Historico:25];aQR_longint1{vQR_longint1})
		If (Not:C34(Locked:C147([Alumnos_Historico:25])))
			[Alumnos_Historico:25]DPE_ColegioAnterior:26:=String:C10(KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39))
			[Alumnos_Historico:25]DEyP_ColegioAnterior:27:=String:C10(KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38))
			
			If ([Alumnos_Historico:25]DPE_ColegioAnterior:26="0")
				[Alumnos_Historico:25]DPE_ColegioAnterior:26:=""
			Else 
				[Alumnos_Historico:25]DPE_ColegioAnterior:26:="N° "+Insert string:C231([Alumnos_Historico:25]DPE_ColegioAnterior:26;" de ";(Length:C16([Alumnos_Historico:25]DPE_ColegioAnterior:26)-4)+1)
			End if 
			If ([Alumnos_Historico:25]DEyP_ColegioAnterior:27="0")
				[Alumnos_Historico:25]DEyP_ColegioAnterior:27:=""
			Else 
				[Alumnos_Historico:25]DEyP_ColegioAnterior:27:="N° "+Insert string:C231([Alumnos_Historico:25]DEyP_ColegioAnterior:27;" de ";(Length:C16([Alumnos_Historico:25]DEyP_ColegioAnterior:27)-4)+1)
			End if 
			SAVE RECORD:C53([Alumnos_Historico:25])
		Else 
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Historico:25]Alumno_Numero:1)
			CD_Dlog (0;"El Historico "+String:C10([Alumnos_Historico:25]Año:2)+" del alumno(a) "+[Alumnos:2]apellidos_y_nombres:40+", está siendo utilizado por otro usuario imposible corregir su información en este momento")
		End if 
		KRL_UnloadReadOnly (->[Alumnos_Historico:25])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;vQR_longint1/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 