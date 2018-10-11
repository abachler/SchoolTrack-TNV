Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		If ([MPA_DefinicionCompetencias:187]Competencia:6#"")
			_O_ENABLE BUTTON:C192(bSave)
		Else 
			_O_DISABLE BUTTON:C193(bSave)
		End if 
		Self:C308->:=ST_clearUnNecessaryCR (Self:C308->)
		If (Self:C308->#"")
			If (atMPA_EtapasArea=0)
				atMPA_EtapasArea:=1
			End if 
			$arrPointer:=Get pointer:C304("atEVLG_Competencias_E"+String:C10(atMPA_EtapasArea))
			If (Is new record:C668([MPA_DefinicionCompetencias:187]))
				$el:=Find in array:C230($arrPointer->;Self:C308->)
				If ($el>0)
					CD_Dlog (0;__ ("Esta Competencia ya esta asignada a esta etapa.\r\rNo es posible duplicar una Competencia en una etapa."))
					Self:C308->:=""
				End if 
			Else 
				$currentRecNum:=Record number:C243([MPA_DefinicionCompetencias:187])
				For ($i;1;Size of array:C274($arrPointer->))
					Case of 
						: ($arrPointer->{$i}="")
							$i:=Size of array:C274($arrPointer->)
						: (($currentRecNum#alEVLG_Competencias_RecNums{$i}{atMPA_EtapasArea}) & ($arrPointer->{$i}=Self:C308->))
							CD_Dlog (0;__ ("Esta Competencia ya esta asignada a esta etapa.\r\rNo es posible duplicar una Competencia en una etapa."))
							Self:C308->:=""
							$i:=Size of array:C274($arrPointer->)
					End case 
				End for 
			End if 
		End if 
		
	: (Form event:C388=On After Keystroke:K2:26)
		Self:C308->:=Get edited text:C655
		If ([MPA_DefinicionCompetencias:187]Competencia:6#"")
			_O_ENABLE BUTTON:C192(bSave)
		Else 
			_O_DISABLE BUTTON:C193(bSave)
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		Self:C308->:=ST_clearUnNecessaryCR (Self:C308->)
End case 


