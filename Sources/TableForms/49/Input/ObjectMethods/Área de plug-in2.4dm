Case of 
	: ((alProEvt=AL Single click event) | (alProEvt=AL Empty Area Single click))
		$row:=AL_GetLine (Self:C308->)
		$col:=AL_GetColumn (Self:C308->)
		
		IT_SetButtonState (($row>0);->bDelColAnt)
		
		If (($row>0) & ($col=1))
			SRtbl_ShowChoiceList (0;"Colegio Anterior";2;->xALP_EducAnterior;False:C215;-><>aPrevSchool)
			If (choiceidx>0)
				atADT_ColAnt_Nombre{$row}:=<>aPrevSchool{choiceidx}
			End if 
		End if 
		
End case 