Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284($recomendaciones)
		ARRAY TEXT:C222($aRecomendaciones;0)
		hl_recomendacionesEnfermeria:=New list:C375
		
		$recomendaciones:=[Alumnos_EventosEnfermeria:14]Recomendaciones:17
		AT_AppendItems2TextArray (->$aRecomendaciones;$recomendaciones)
		
		For ($i;1;Size of array:C274(<>recomendacionesEnfermeria))
			APPEND TO LIST:C376(hl_recomendacionesEnfermeria;<>recomendacionesEnfermeria{$i};$i)
			GET LIST ITEM:C378(hl_recomendacionesEnfermeria;$i;$ref;$text)
			GET LIST ITEM PROPERTIES:C631(hl_recomendacionesEnfermeria;$ref;$enterable)
			If (Find in array:C230($aRecomendaciones;<>recomendacionesEnfermeria{$i})#-1)
				  //si lo encuentra
				SET LIST ITEM PROPERTIES:C386(hl_recomendacionesEnfermeria;$ref;$enterable;Bold:K14:2;0)
			End if 
		End for 
		_O_REDRAW LIST:C382(hl_recomendacionesEnfermeria)
End case 
