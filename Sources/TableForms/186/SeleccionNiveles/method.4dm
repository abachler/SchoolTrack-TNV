Case of 
	: (Form event:C388=On Load:K2:1)
		C_PICTURE:C286($pict)
		ARRAY BOOLEAN:C223(lb_NivelesAplicables;0)
		ARRAY BOOLEAN:C223(lb_NivelesAplicables;Size of array:C274(<>al_NumeroNivelesActivos))
		ARRAY PICTURE:C279(ap_MarcaNiveles;Size of array:C274(<>al_NumeroNivelesActivos))
		For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
			$noNivelEnLista:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{$i})
			If (vl_AplicaEnNiveles ?? $noNivelEnLista)
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";$pict)
				ap_MarcaNiveles{$i}:=$pict
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";$pict)
				ap_MarcaNiveles{$i}:=$pict
			End if 
		End for 
		vl_winRef:=Frontmost window:C447
		
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (vl_winRef)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 