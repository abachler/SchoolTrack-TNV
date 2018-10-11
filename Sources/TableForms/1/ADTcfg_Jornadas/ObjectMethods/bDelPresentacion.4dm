$line:=AL_GetLine (xALP_Presentations)
If ($line>0)
	If (adPST_PresentDate{$line}>!00-00-00!)
		$secs:=SYS_DateTime2Secs (adPST_PresentDate{$ilne};aLPST_PresentTime{$ilne})
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]secs_Presentación:23=$secs)
		ARRAY LONGINT:C221(aLong1;0)
		ARRAY LONGINT:C221(aLong1;Records in selection:C76([ADT_Candidatos:49]))
		OK:=KRL_Array2Selection (->aLong1;->[ADT_Candidatos:49]secs_Presentación:23)
	End if 
	
	AT_Delete ($line;1;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
	AL_UpdateArrays (xALP_Presentations;-2)
	AL_SetLine (xALP_Presentations;0)
	If (Size of array:C274(adPST_PresentDate)=0)
		_O_DISABLE BUTTON:C193(bDelPresentacion)
	End if 
End if 