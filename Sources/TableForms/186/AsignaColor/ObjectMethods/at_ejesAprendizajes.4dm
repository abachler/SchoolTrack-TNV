C_LONGINT:C283($i;$l_colum;$l_linea;$ref_color;$result)
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
			LISTBOX GET CELL POSITION:C971(lb_ejesaprendizajes;$l_colum;$l_linea;$y_variableColumna)
			If ((ok=1) & ($ref_color#0))
				READ WRITE:C146([MPA_DefinicionEjes:185])
				QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=al_IDejesAprendizajes{$l_linea})
				[MPA_DefinicionEjes:185]color_rgb:26:=Choose:C955($ref_color<0;0;$ref_color)
				SAVE RECORD:C53([MPA_DefinicionEjes:185])
				KRL_UnloadReadOnly (->[MPA_DefinicionEjes:185])
				al_colorEje{$l_linea}:=$ref_color
			End if 
		End if 
	: (Form event:C388=On Clicked:K2:4)
		For ($i;1;Size of array:C274(lb_dimaprendizajes))
			lb_dimaprendizajes{$i}:=False:C215
		End for 
		For ($i;1;Size of array:C274(lb_logrosaprendizajes))
			lb_logrosaprendizajes{$i}:=False:C215
		End for 
End case 

