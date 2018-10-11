
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		
		C_TEXT:C284($recomendaciones)
		ARRAY TEXT:C222($aRecomendaciones;0)
		$item:=Selected list items:C379(Self:C308->)
		  //GET LIST ITEM(Self->;*;$ref;$text)
		
		
		  //si es la primera vez que se ingresan recomendaciones
		If ([Alumnos_EventosEnfermeria:14]Recomendaciones:17="")
			[Alumnos_EventosEnfermeria:14]Recomendaciones:17:=<>recomendacionesEnfermeria{$item}
			  //SAVE RECORD([Alumnos_EventosEnfermeria])
		Else 
			$recomendaciones:=[Alumnos_EventosEnfermeria:14]Recomendaciones:17
			AT_AppendItems2TextArray (->$aRecomendaciones;$recomendaciones)
			
			$indice:=Find in array:C230($aRecomendaciones;<>recomendacionesEnfermeria{$item})
			
			If ($indice=-1)
				  //si no lo encuentra
				APPEND TO ARRAY:C911($aRecomendaciones;<>recomendacionesEnfermeria{$item})
				$recomendaciones:=AT_array2text (->$aRecomendaciones)
				[Alumnos_EventosEnfermeria:14]Recomendaciones:17:=$recomendaciones
				  //SAVE RECORD([Alumnos_EventosEnfermeria])
			Else 
				  //si lo encuentra, lo borro del arreglo
				AT_Delete ($indice;1;->$aRecomendaciones)
				$recomendaciones:=AT_array2text (->$aRecomendaciones)
				[Alumnos_EventosEnfermeria:14]Recomendaciones:17:=$recomendaciones
				  //SAVE RECORD([Alumnos_EventosEnfermeria])
			End if 
			  //KRL_UnloadReadOnly (->[Alumnos_EventosEnfermeria])
		End if 
		  //para actualizar la visualizacion de la lista
		$recomendaciones:=[Alumnos_EventosEnfermeria:14]Recomendaciones:17
		AT_AppendItems2TextArray (->$aRecomendaciones;$recomendaciones)
		
		hl_recomendacionesEnfermeria:=New list:C375
		
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
