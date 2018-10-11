C_LONGINT:C283($l_colum;$l_linea;$ref_color;$result)
C_POINTER:C301($y_variableColumna)
C_TEXT:C284($t_texto)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$ref_color:=0
		$t_texto:="Quitar color;(-"
		$t_texto:=$t_texto+";Asignar Color"
		$result:=Pop up menu:C542($t_texto;0)
		If ($result=3)
			$ref_color:=Select RGB color:C956
		Else 
			$ref_color:=-255
		End if 
		
		If ($ref_color#0)
			LISTBOX GET CELL POSITION:C971(lb_logrosaprendizajes;$l_colum;$l_linea;$y_variableColumna)
			If ((ok=1) & ($ref_color#0))
				READ WRITE:C146([MPA_DefinicionCompetencias:187])
				QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=al_IDlogrosAprendizajes{$l_linea})
				[MPA_DefinicionCompetencias:187]color_rgb:33:=Choose:C955($ref_color<0;0;$ref_color)
				SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
				KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
				al_colorLogros{$l_linea}:=$ref_color
			End if 
		End if 
		
End case 