  //Método de Objeto: xALP_ObjxAlu

Case of 
	: (Form event:C388=On Menu Selected:K2:14)
		$menu:=Menu selected:C152\65536
		$line:=Menu selected:C152%65536
		AL_GetCurrCell (Self:C308->;$Col;$Row)
		
	: ((alProEvt=AL Single click event) | (alProEvt=AL Double click event))
		
		$vrow:=AL_GetLine (Self:C308->)
		$vcol:=AL_GetColumn (Self:C308->)
		AS_Edita_Objetivos ($vRow;$vCol)
		AL_UpdateArrays (Self:C308->;-2)
End case 

