Case of 
	: (alProEvt=-5)
		AL_GetDrgSrcRow (Self:C308->;$line)
		AL_GetDrgArea (Self:C308->;$area;$pId)
		Case of 
			: ($area=xALP_PlanNivel)
				AL_UpdateArrays (xALP_PlanNivel;-2)
				For ($i;1;Size of array:C274(aSubject))
					aOrder{$i}:=$i
				End for 
			: ($area=xALP_Subsectores)
				AL_UpdateArrays (xALP_PlanNivel;0)
				AT_Delete ($line;1;->aSubject;->aOrder;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
				For ($i;1;Size of array:C274(aSubject))
					aOrder{$i}:=$i
				End for 
				AL_UpdateArrays (xALP_PlanNivel;-2)
		End case 
End case 