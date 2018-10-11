AL_UpdateArrays (xALP_Presentations;0)
Case of 
	: (Self:C308-><Size of array:C274(adPST_PresentDate))
		$elementsTodelete:=Size of array:C274(adPST_PresentDate)-Self:C308->
		$el:=Find in array:C230(aiPST_Asistentes;0)
		If ($el>0)
			OK:=CD_Dlog (0;__ ("El número ingresado es inferior a las presentaciones actualmente programadas. \r¿Desea eliminar las presentaciones sin asistentes registrados?");__ ("");__ ("Sí");__ ("No"))
			If (ok=1)
				For ($i;Size of array:C274(adPST_PresentDate);1;-1)
					If (aiPST_Asistentes{$i}=0)
						AT_Delete ($i;1;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
						$elementsTodelete:=$elementsTodelete-1
						If ($elementsTodelete=0)
							$i:=0
						End if 
					End if 
				End for 
			End if 
		Else 
			OK:=CD_Dlog (0;__ ("El número ingresado es inferior a las presentaciones actualmente programadas, algunas de ellas tienen asistentes registrados.\rSi elimina la presentación perderá la las fechas actualmente asignadas.\r¿Desea realmente eliminar estas presentaciones?");__ ("");__ ("No");__ ("Sí"))
			If (OK=2)
				$elementsTodelete:=Size of array:C274(adPST_PresentDate)-Self:C308->
				For ($i;Size of array:C274(adPST_PresentDate);1;-1)
					$secs:=SYS_DateTime2Secs (adPST_PresentDate{$i};aLPST_PresentTime{$i})
					QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]secs_Presentación:23=$secs)
					ARRAY LONGINT:C221(aLong1;0)
					ARRAY LONGINT:C221(aLong1;Records in selection:C76([ADT_Candidatos:49]))
					OK:=KRL_Array2Selection (->aLong1;->[ADT_Candidatos:49]secs_Presentación:23)
					AT_Delete ($i;1;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
					$elementsTodelete:=$elementsTodelete-1
					If ($elementsTodelete=0)
						$i:=0
					End if 
				End for 
			End if 
		End if 
	: (Self:C308->>Size of array:C274(adPST_PresentDate))
		$rowsToInsert:=Self:C308->-Size of array:C274(adPST_PresentDate)
		AT_Insert (Size of array:C274(adPST_PresentDate)+1;$rowsToInsert;->adPST_PresentDate;->aLPST_PresentTime;->aiPST_Asistentes;->atPST_Place;->atPST_Encargado;->aiADT_IDEntrevistador)
End case 
AL_SetLine (xALP_Presentations;0)
AL_UpdateArrays (xALP_Presentations;Size of array:C274(adPST_PresentDate))