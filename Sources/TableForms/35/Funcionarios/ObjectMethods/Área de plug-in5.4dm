
Case of 
	: (alProEvt=AL Single click event)
		
		AL_UpdateArrays (xalp_BUFunc;0)
		AL_UpdateArrays (xalp_BUListaFunc;0)
		$line:=AL_GetLine (Self:C308->)
		BU_CtrListasProfesores (alBU_IdRecorrido{$line})
		IT_SetButtonState (False:C215;->bDelFunc)
		AL_UpdateArrays (xalp_BUFunc;-2)
		AL_UpdateArrays (xalp_BUListaFunc;-2)
		AL_SetLine (xalp_BUFunc;0)
		
	: (alProEvt=AL Double click event)
		
		
End case 