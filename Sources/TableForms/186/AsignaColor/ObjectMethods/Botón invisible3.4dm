Case of 
	: (Form event:C388=On Clicked:K2:4)
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
			For ($i;1;Size of array:C274(lb_logrosaprendizajes))
				If (lb_logrosaprendizajes{$i})
					READ WRITE:C146([MPA_DefinicionCompetencias:187])
					QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=al_IDlogrosAprendizajes{$i})
					[MPA_DefinicionCompetencias:187]color_rgb:33:=Choose:C955($ref_color<0;0;$ref_color)
					SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
					KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
					al_colorLogros{$i}:=$ref_color
				End if 
			End for 
		End if 
End case 