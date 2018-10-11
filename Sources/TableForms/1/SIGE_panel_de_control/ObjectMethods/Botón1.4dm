Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (ta_1=1)
			SIGE_ValidarFichaAlumno 
		Else 
			ARRAY LONGINT:C221($al_NumAluSel;0)
			
			If (Size of array:C274(LB_SIGE)>0)
				
				For ($i;1;Size of array:C274(LB_SIGE))
					
					If (LB_SIGE{$i})
						APPEND TO ARRAY:C911($al_NumAluSel;al_alu_fail_verif{$i})
					End if 
					
				End for 
				
				SIGE_ValidarFichaAlumno (->$al_NumAluSel)
				
			End if 
		End if 
End case 