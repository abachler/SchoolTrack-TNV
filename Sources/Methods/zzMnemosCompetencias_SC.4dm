//%attributes = {}
  //zzMnemosCompetencias_SC

READ WRITE:C146([MPA_DefinicionCompetencias:187])
QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]Competencia:6="@%@")
While (Not:C34(End selection:C36([MPA_DefinicionCompetencias:187])))
	If ([MPA_DefinicionCompetencias:187]Competencia:6="%@")
		[MPA_DefinicionCompetencias:187]Competencia:6:=Substring:C12([MPA_DefinicionCompetencias:187]Competencia:6;2)
		$next:=Position:C15("%";[MPA_DefinicionCompetencias:187]Competencia:6)
		If ($next>0)
			$mnemo:=Substring:C12([MPA_DefinicionCompetencias:187]Competencia:6;1;$next-1)
			[MPA_DefinicionCompetencias:187]Competencia:6:=Substring:C12([MPA_DefinicionCompetencias:187]Competencia:6;$next+1)
			[MPA_DefinicionCompetencias:187]Mnemo:26:=Uppercase:C13(ST_ClearSpaces ($mnemo))
			[MPA_DefinicionCompetencias:187]Competencia:6:=ST_ClearSpaces ([MPA_DefinicionCompetencias:187]Competencia:6)
		End if 
		$next:=Position:C15("%";[MPA_DefinicionCompetencias:187]Competencia:6)
		If ($next>0)
			[MPA_DefinicionCompetencias:187]Competencia:6:=ST_ClearSpaces (Substring:C12([MPA_DefinicionCompetencias:187]Competencia:6;1;$next-1))
		End if 
	End if 
	SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
	NEXT RECORD:C51([MPA_DefinicionCompetencias:187])
End while 
READ ONLY:C145([MPA_DefinicionCompetencias:187])
