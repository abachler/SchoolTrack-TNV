
C_TEXT:C284($intereses)
ARRAY TEXT:C222($aIntereses;0)
_O_C_INTEGER:C282($indice)
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$item:=Selected list items:C379(Self:C308->)
		  //agregar intereses a la familia si aun no la tiene
		
		
		If ([Familia:78]Intereses:40="")
			  //en caso de que la familia no tenga intereses, para el primer elemento
			READ WRITE:C146([Familia:78])
			[Familia:78]Intereses:40:=<>aFamiliaIntereses{$item}
			SAVE RECORD:C53([Familia:78])
		Else 
			$intereses:=[Familia:78]Intereses:40
			AT_AppendItems2TextArray (->$aIntereses;$intereses)
			
			  //buscar si ya se tiene el interes ingresado
			$indice:=Find in array:C230($aIntereses;<>aFamiliaIntereses{$item})
			If ($indice=-1)
				  //si no lo encuentra
				APPEND TO ARRAY:C911($aIntereses;<>aFamiliaIntereses{$item})
				$intereses:=AT_array2text (->$aIntereses)
				READ WRITE:C146([Familia:78])
				[Familia:78]Intereses:40:=$intereses
				SAVE RECORD:C53([Familia:78])
			Else 
				  //si lo encuentra, lo borro del arreglo
				AT_Delete ($indice;1;->$aIntereses)
				$intereses:=AT_array2text (->$aIntereses)
				READ WRITE:C146([Familia:78])
				[Familia:78]Intereses:40:=$intereses
				SAVE RECORD:C53([Familia:78])
			End if 
		End if 
		
		  //para que se actualicen los intereses
		
		READ ONLY:C145([Familia:78])
		$intereses:=[Familia:78]Intereses:40
		AT_AppendItems2TextArray (->$aIntereses;$intereses)
		
		
		hl_intereses:=New list:C375
		For ($i;1;Size of array:C274(<>aFamiliaIntereses))
			APPEND TO LIST:C376(hl_intereses;<>aFamiliaIntereses{$i};$i)
			GET LIST ITEM:C378(hl_intereses;$i;$ref;$text)
			GET LIST ITEM PROPERTIES:C631(hl_intereses;$ref;$enterable)
			If (Find in array:C230($aIntereses;<>aFamiliaIntereses{$i})#-1)
				  //si lo encuentra
				SET LIST ITEM PROPERTIES:C386(hl_intereses;$ref;$enterable;Bold:K14:2;0)
			End if 
		End for 
		_O_REDRAW LIST:C382(hl_intereses)
		
		
End case 
