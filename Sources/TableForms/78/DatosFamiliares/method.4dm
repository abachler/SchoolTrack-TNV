
ARRAY TEXT:C222($aIntereses;0)
ARRAY TEXT:C222($aValores;0)
ARRAY TEXT:C222($aHobbies;0)
ARRAY TEXT:C222($apreferencias;0)
C_TEXT:C284($preferencias)
C_TEXT:C284($hobbbies)
C_TEXT:C284($valores)
C_TEXT:C284($intereses)
C_REAL:C285($ref)
C_BOOLEAN:C305($enterable)
C_TEXT:C284($text)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		  //carga de la lista de la configuración para las listas jerárquicas
		  //para los intereses
		  //cargar los intereses actuales que tiene la familia
		
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
		
		READ ONLY:C145([Familia:78])
		$preferencias:=[Familia:78]Preferencias:42
		AT_AppendItems2TextArray (->$apreferencias;$preferencias)
		
		
		hl_preferencias:=New list:C375
		For ($i;1;Size of array:C274(<>aFamiliapreferencias))
			APPEND TO LIST:C376(hl_preferencias;<>aFamiliapreferencias{$i};$i)
			GET LIST ITEM:C378(hl_preferencias;$i;$ref;$text)
			GET LIST ITEM PROPERTIES:C631(hl_preferencias;$ref;$enterable)
			If (Find in array:C230($apreferencias;<>aFamiliapreferencias{$i})#-1)
				  //si lo encuentra
				SET LIST ITEM PROPERTIES:C386(hl_preferencias;$ref;$enterable;Bold:K14:2;0)
			End if 
		End for 
		_O_REDRAW LIST:C382(hl_preferencias)
		
	: (Form event:C388=On Close Box:K2:21)
		POST KEY:C465(27;0)
End case 
