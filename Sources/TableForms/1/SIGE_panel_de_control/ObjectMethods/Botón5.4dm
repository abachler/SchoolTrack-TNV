Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (cu_1=1)
			SIGE_IngresoCurso (->at_curso)
		Else 
			
			ARRAY TEXT:C222($at_Curso_P;0)
			
			If (Size of array:C274(LB_SIGE)>0)
				For ($i;1;Size of array:C274(LB_SIGE))
					If (LB_SIGE{$i})
						APPEND TO ARRAY:C911($at_Curso_P;at_Curso_P{$i})
					End if 
				End for 
				SIGE_IngresoCurso (->$at_Curso_P)
			End if 
		End if 
End case 