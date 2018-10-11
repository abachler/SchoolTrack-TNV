  //DC OBJETO 2.2
Case of 
	: (alProEvt=AL Single click event)
		$line:=AL_GetLine ((Self:C308->))
		BU_Refresh_Inscripciones (1;alBU_IdRecorrido{$line})
		IT_SetButtonState (($line#0);->bDel)
	: (alProEvt=AL Double click event)
		$line:=AL_GetLine (Self:C308->)
		READ WRITE:C146([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1=alBU_IdRecorrido{$line})
		WDW_OpenFormWindow (->[BU_Rutas_Recorridos:33];"input";-1;4)  //Para abrir la ventana....
		KRL_ModifyRecord (->[BU_Rutas_Recorridos:33];"input")  //Para abrir el formulario.....
		CLOSE WINDOW:C154
		BU_Refresh_Recorridos (1;[BU_Rutas:26]ID:12)
		$er:=Size of array:C274(alBU_IdRecorrido)
		IT_SetButtonState (($er>0);->bDel;->bPrintItems)
End case 
