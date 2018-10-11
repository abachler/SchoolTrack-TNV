


C_TEXT:C284($hobbies)
ARRAY TEXT:C222($aHobbies;0)
_O_C_INTEGER:C282($indice)
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$item:=Selected list items:C379(Self:C308->)
		  //agregar valores a la familia si aun no la tiene
		
		
		If ([Familia:78]Hobbies:41="")
			  //en caso de que la familia no tenga intereses, para el primer elemento
			READ WRITE:C146([Familia:78])
			[Familia:78]Hobbies:41:=<>aFamiliaHobbies{$item}
			SAVE RECORD:C53([Familia:78])
		Else 
			$hobbies:=[Familia:78]Hobbies:41
			AT_AppendItems2TextArray (->$aHobbies;$hobbies)
			
			  //buscar si ya se tiene el interes ingresado
			$indice:=Find in array:C230($aHobbies;<>aFamiliaHobbies{$item})
			If ($indice=-1)
				  //si no lo encuentra
				APPEND TO ARRAY:C911($aHobbies;<>aFamiliaHobbies{$item})
				$hobbies:=AT_array2text (->$aHobbies)
				READ WRITE:C146([Familia:78])
				[Familia:78]Hobbies:41:=$hobbies
				SAVE RECORD:C53([Familia:78])
			Else 
				  //si lo encuentra, lo borro del arreglo
				AT_Delete ($indice;1;->$aHobbies)
				$hobbies:=AT_array2text (->$aHobbies)
				READ WRITE:C146([Familia:78])
				[Familia:78]Hobbies:41:=$hobbies
				SAVE RECORD:C53([Familia:78])
			End if 
		End if 
		
		  //para que se actualicen los hobbies
		
		READ ONLY:C145([Familia:78])
		$hobbies:=[Familia:78]Hobbies:41
		AT_AppendItems2TextArray (->$aHobbies;$hobbies)
		
		
		hl_hobbies:=New list:C375
		For ($i;1;Size of array:C274(<>aFamiliaHobbies))
			APPEND TO LIST:C376(hl_hobbies;<>aFamiliaHobbies{$i};$i)
			GET LIST ITEM:C378(hl_hobbies;$i;$ref;$text)
			GET LIST ITEM PROPERTIES:C631(hl_hobbies;$ref;$enterable)
			If (Find in array:C230($aHobbies;<>aFamiliaHobbies{$i})#-1)
				  //si lo encuentra
				SET LIST ITEM PROPERTIES:C386(hl_hobbies;$ref;$enterable;Bold:K14:2;0)
			End if 
		End for 
		_O_REDRAW LIST:C382(hl_hobbies)
		
End case 
