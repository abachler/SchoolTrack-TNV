
If (Form event:C388=On Data Change:K2:15)
	C_REAL:C285($r_year)
	
	$r_year:=Num:C11(Substring:C12(Self:C308->;1;4))
	
	Case of 
		: (($r_year<2000) | ($r_year>2020))
			CD_Dlog (0;"El período ingresado no parece ser válido, por favor verifíquelo.")
			
	End case 
	
	$l_idItem:=[xxACT_Items:179]ID:1
	ACTcfg_SaveItemdeCargo 
	AL_SetSort (xALP_Items;0)
	AL_UpdateArrays (xALP_Items;0)
	PREF_Set (0;"ACT_pref_filtroItems";Self:C308->)
	ACTitems_FiltroPeriodo ("CreaLista")
	AL_UpdateArrays (xALP_Items;-2)
	ACTitems_SeleccionaLinea ($l_idItem)
End if 