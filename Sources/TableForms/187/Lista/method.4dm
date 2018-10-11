If (Form event:C388=On Display Detail:K2:22)
	$recNum:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;[MPA_DefinicionCompetencias:187]ID_Area:11)
	If ($recNum>=0)
		GOTO RECORD:C242([MPA_DefinicionAreas:186];$recNum)
	End if 
End if 
