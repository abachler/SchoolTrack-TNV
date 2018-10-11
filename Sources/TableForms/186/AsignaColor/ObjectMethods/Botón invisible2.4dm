  //Siempre despliego el formulario.
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
			For ($i;1;Size of array:C274(lb_dimaprendizajes))
				If (lb_dimaprendizajes{$i})
					READ WRITE:C146([MPA_DefinicionDimensiones:188])
					QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1=al_IDdimAprendizajes{$i})
					[MPA_DefinicionDimensiones:188]color_rgb:26:=Choose:C955($ref_color<0;0;$ref_color)
					SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
					KRL_UnloadReadOnly (->[MPA_DefinicionDimensiones:188])
					al_colorDim{$i}:=$ref_color
				End if 
			End for 
		End if 
End case 