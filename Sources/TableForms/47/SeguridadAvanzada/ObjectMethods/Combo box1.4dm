
Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		l_Maximo:=al_ListaMaxC{0}
		$l_pos:=Find in array:C230(al_ListaMaxC;l_Maximo)
		If ($l_pos>0)
			l_Maximo:=al_ListaMaxC{$l_pos}
		Else 
			l_Maximo:=al_ListaMaxC{Size of array:C274(al_ListaMaxC)}
			al_ListaMaxC{0}:=l_Maximo
		End if 
		
		ARRAY LONGINT:C221(al_ListaMinMAY;0)
		APPEND TO ARRAY:C911(al_ListaMinMAY;0)
		For ($i;1;l_Maximo)
			APPEND TO ARRAY:C911(al_ListaMinMAY;$i)
		End for 
		al_ListaMinMAY{0}:=0
		
		ARRAY LONGINT:C221(al_ListaMinNum;0)
		APPEND TO ARRAY:C911(al_ListaMinNum;0)
		For ($i;1;l_Maximo)
			APPEND TO ARRAY:C911(al_ListaMinNum;$i)
		End for 
		al_ListaMinNum{0}:=0
		
		
		
End case 
