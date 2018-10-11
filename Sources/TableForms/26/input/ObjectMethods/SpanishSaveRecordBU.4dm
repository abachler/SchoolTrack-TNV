Case of 
	: ([BU_Rutas:26]Numero_Ruta:1=0)
		OK:=CD_Dlog (1;__ ("Debe ingresar un número para la Ruta");__ ("");__ ("Ok"))
	: ([BU_Rutas:26]Letra:8="")
		OK:=CD_Dlog (1;__ ("Debe ingresar la Letra de la Ruta");__ ("");__ ("Ok"))
	Else 
		
		For ($i;1;Size of array:C274(atBU_NomCom))
			BU_AddComunasLista ([BU_Rutas:26]ID:12;atBU_NomCom{$i})
		End for 
		
		$er:=Size of array:C274(atQuitar)
		If ($er>0)
			For ($i;1;Size of array:C274(atQuitar))
				BU_DelComunasLista ([BU_Rutas:26]ID:12;atQuitar{$i})
			End for 
		End if 
		
		SAVE RECORD:C53([BU_Rutas:26])
		_O_ENABLE BUTTON:C192(b_Add)
		If (sMatBus="")
			_O_DISABLE BUTTON:C193(bAddInscripción)
		Else 
			_O_ENABLE BUTTON:C192(bAddInscripción)
		End if 
		
		
		If ($er>0)
			_O_ENABLE BUTTON:C192(bDel)
			_O_ENABLE BUTTON:C192(bPrintItems)
		Else 
			_O_DISABLE BUTTON:C193(bDel)
			_O_DISABLE BUTTON:C193(bPrintItems)
		End if 
		
		If (Size of array:C274(alBU_IdRecorrido)>0)
			_O_ENABLE BUTTON:C192(bDel)
			_O_ENABLE BUTTON:C192(bPrintItems)
			
		End if 
		CANCEL:C270
		BU_SaveRutas 
		vb_ValidateTransaction:=True:C214
End case 

