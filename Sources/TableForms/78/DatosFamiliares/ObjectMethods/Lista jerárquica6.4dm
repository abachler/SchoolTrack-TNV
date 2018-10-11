
C_TEXT:C284($preferencias)
ARRAY TEXT:C222($aPreferencias;0)
_O_C_INTEGER:C282($indice)
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$item:=Selected list items:C379(Self:C308->)
		  //agregar valores a la familia si aun no la tiene
		
		
		If ([Familia:78]Preferencias:42="")
			  //en caso de que la familia no tenga intereses, para el primer elemento
			READ WRITE:C146([Familia:78])
			[Familia:78]Preferencias:42:=<>aFamiliaPreferencias{$item}
			SAVE RECORD:C53([Familia:78])
		Else 
			$preferencias:=[Familia:78]Preferencias:42
			AT_AppendItems2TextArray (->$aPreferencias;$preferencias)
			
			  //buscar si ya se tiene el interes ingresado
			$indice:=Find in array:C230($aPreferencias;<>aFamiliaPreferencias{$item})
			If ($indice=-1)
				  //si no lo encuentra
				APPEND TO ARRAY:C911($aPreferencias;<>aFamiliaPreferencias{$item})
				$preferencias:=AT_array2text (->$aPreferencias)
				READ WRITE:C146([Familia:78])
				[Familia:78]Preferencias:42:=$preferencias
				SAVE RECORD:C53([Familia:78])
			Else 
				  //si lo encuentra, lo borro del arreglo
				AT_Delete ($indice;1;->$aPreferencias)
				$preferencias:=AT_array2text (->$aPreferencias)
				READ WRITE:C146([Familia:78])
				[Familia:78]Preferencias:42:=$preferencias
				SAVE RECORD:C53([Familia:78])
			End if 
		End if 
		
		  //para que se actualicen los preferencias
		
		READ ONLY:C145([Familia:78])
		$preferencias:=[Familia:78]Preferencias:42
		AT_AppendItems2TextArray (->$aPreferencias;$preferencias)
		
		
		hl_preferencias:=New list:C375
		For ($i;1;Size of array:C274(<>aFamiliaPreferencias))
			APPEND TO LIST:C376(hl_preferencias;<>aFamiliaPreferencias{$i};$i)
			GET LIST ITEM:C378(hl_preferencias;$i;$ref;$text)
			GET LIST ITEM PROPERTIES:C631(hl_preferencias;$ref;$enterable)
			If (Find in array:C230($apreferencias;<>aFamiliaPreferencias{$i})#-1)
				  //si lo encuentra
				SET LIST ITEM PROPERTIES:C386(hl_preferencias;$ref;$enterable;Bold:K14:2;0)
			End if 
		End for 
		_O_REDRAW LIST:C382(hl_preferencias)
		
		
End case 
