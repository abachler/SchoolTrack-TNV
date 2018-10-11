If ((aApoderado{aPersID}="General") | (aApoderado{aPersID}="Cuentas"))
	CD_Dlog (0;__ ("La condición de apoderado de cuentas no puede ser retirada mientras no se asigne otra persona como apoderado de cuentas."))
	bap2:=1
Else 
	If (bap2#bap2InitialState)
		changeAP:=True:C214
	Else 
		changeAP:=False:C215
	End if 
	If (changeAP)
		$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
		If ($accountTrackIsInitialized=1)
			OBJECT MOVE:C664(aiACT_ChangeDeuda2NewAPdo;0;-70)
			OBJECT MOVE:C664(*;"boton@";0;20)
			OBJECT MOVE:C664(*;"Message@";0;20)
			GET WINDOW RECT:C443($left;$top;$right;$bottom)
			SET WINDOW RECT:C444($left;$top-10;$right;$bottom+10)
		End if 
	Else 
		$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
		If ($accountTrackIsInitialized=1)
			OBJECT MOVE:C664(aiACT_ChangeDeuda2NewAPdo;0;70)
			OBJECT MOVE:C664(*;"boton@";0;-20)
			OBJECT MOVE:C664(*;"Message@";0;-20)
			GET WINDOW RECT:C443($left;$top;$right;$bottom)
			SET WINDOW RECT:C444($left;$top+10;$right;$bottom-10)
		End if 
		aiACT_ChangeDeuda2NewAPdo:=0
	End if 
	IT_SetButtonState (changeAP;->aiACT_ChangeDeuda2NewAPdo)
End if 
