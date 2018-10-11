C_TEXT:C284($valores)
ARRAY TEXT:C222($aValores;0)
_O_C_INTEGER:C282($indice)
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$item:=Selected list items:C379(Self:C308->)
		  //agregar valores a la familia si aun no la tiene
		
		
		If ([Familia:78]Valores:43="")
			  //en caso de que la familia no tenga intereses, para el primer elemento
			READ WRITE:C146([Familia:78])
			[Familia:78]Valores:43:=<>aFamiliaValores{$item}
			SAVE RECORD:C53([Familia:78])
		Else 
			$valores:=[Familia:78]Valores:43
			AT_AppendItems2TextArray (->$aValores;$valores)
			
			  //buscar si ya se tiene el interes ingresado
			$indice:=Find in array:C230($aValores;<>aFamiliaValores{$item})
			If ($indice=-1)
				  //si no lo encuentra
				APPEND TO ARRAY:C911($aValores;<>aFamiliaValores{$item})
				$valores:=AT_array2text (->$aValores)
				READ WRITE:C146([Familia:78])
				[Familia:78]Valores:43:=$valores
				SAVE RECORD:C53([Familia:78])
			Else 
				  //si lo encuentra, lo borro del arreglo
				AT_Delete ($indice;1;->$aValores)
				$valores:=AT_array2text (->$aValores)
				READ WRITE:C146([Familia:78])
				[Familia:78]Valores:43:=$valores
				SAVE RECORD:C53([Familia:78])
			End if 
		End if 
		
		  //para que se actualicen los intereses
		
		READ ONLY:C145([Familia:78])
		$valores:=[Familia:78]Valores:43
		AT_AppendItems2TextArray (->$aValores;$valores)
		
		
		hl_valores:=New list:C375
		For ($i;1;Size of array:C274(<>aFamiliaValores))
			APPEND TO LIST:C376(hl_valores;<>aFamiliaValores{$i};$i)
			GET LIST ITEM:C378(hl_valores;$i;$ref;$text)
			GET LIST ITEM PROPERTIES:C631(hl_valores;$ref;$enterable)
			If (Find in array:C230($aValores;<>aFamiliaValores{$i})#-1)
				  //si lo encuentra
				SET LIST ITEM PROPERTIES:C386(hl_valores;$ref;$enterable;Bold:K14:2;0)
			End if 
		End for 
		_O_REDRAW LIST:C382(hl_valores)
		
		
End case 
