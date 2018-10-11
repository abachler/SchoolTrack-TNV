Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		viPST_OldSectNumber:=Self:C308->
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: (Self:C308-><viPST_OldSectNumber)
				$nextTodelete:=Self:C308->+1
				For ($i;$nextToDelete;viPST_OldSectNumber)
					$section:=Char:C90(64+$i)
					QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Section:7=$section)
					SELECTION TO ARRAY:C260([ADT_Examenes:122]Total:11;aInt1)
					$sum:=AT_GetSumArray (->aInt1)
					ARRAY INTEGER:C220(aInt1;0)
					If ($sum=0)
						KRL_DeleteSelection (->[ADT_Examenes:122])
					End if 
				End for 
			: (Self:C308->>viPST_OldSectNumber)
				PST_CreateExamSesions 
				viPST_OldSectNumber:=Self:C308->
		End case 
End case 

Case of 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
		  //si se puede cambiar la cantidad máxima de postulantes
		If (VMaximoPostulantesEnterable=1)
			
			  //calculo los aspirantes por seccion
			iPST_MaxPerSection:=Int:C8(iPST_MaxCandidates/(iPST_Groups*iPST_Sections))
		Else 
			  //calculo el total de aspirantes
			iPST_MaxCandidates:=iPST_Groups*iPST_Sections*iPST_MaxPerSection
		End if 
		
End case 

