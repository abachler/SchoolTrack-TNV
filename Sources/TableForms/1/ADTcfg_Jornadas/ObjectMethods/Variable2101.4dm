AL_UpdateArrays (xALP_Presentations;0)
RESOLVE POINTER:C394(Focus object:C278;$varName;$Table;$Field)
If ($varName="xALP_Presentations")
	$line:=AL_GetLine (xALP_Presentations)
	If ($line>0)
		If (aiPST_Asistentes{$line}=0)
			AT_Delete ($line;1;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
			viPST_NbPresentations:=Size of array:C274(adPST_PresentDate)
		Else 
			ok:=CD_Dlog (0;__ ("Esta presentación tiene asistentes registrados. \rSi la elimina deberá re-asignar una fecha de presentación a todos los asistentes registrados.\r¿Desea realmente eliminar esta presentación?");__ ("");__ ("No");__ ("Sí"))
			If (ok=2)
				$secs:=SYS_DateTime2Secs (adPST_PresentDate{$line};aLPST_PresentTime{$line})
				QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]secs_Presentación:23=$secs)
				ARRAY LONGINT:C221(aLong1;0)
				ARRAY LONGINT:C221(aLong1;Records in selection:C76([ADT_Candidatos:49]))
				OK:=KRL_Array2Selection (->aLong1;->[ADT_Candidatos:49]secs_Presentación:23)
				If (ok=1)
					AT_Delete ($line;1;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
					viPST_NbPresentations:=Size of array:C274(adPST_PresentDate)
				Else 
					CANCEL:C270
				End if 
			End if 
		End if 
	End if 
End if 
AL_UpdateArrays (xALP_Presentations;-2)