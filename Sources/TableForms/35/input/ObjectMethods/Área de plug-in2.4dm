
Case of 
	: (alProEvt=AL Single click event)
		
		AL_UpdateArrays (xalp_Inscritos;0)
		AL_UpdateArrays (xALP_Trans1;0)
		$line:=AL_GetLine (Self:C308->)
		BU_CtrListas (<>aCursos{<>acursos};alBU_IdRecorrido{$line})
		IT_SetButtonState ((Size of array:C274(alBU_ALID)>0);->bPrintAL)
		IT_SetButtonState (False:C215;->bDelAL)
		AL_UpdateArrays (xALP_Trans1;-2)
		AL_UpdateArrays (xalp_Inscritos;-2)
		AL_SetLine (xalp_Inscritos;0)
	: (alProEvt=AL Double click event)
		
		
End case 
