Case of 
	: (alproEvt=AL Object resize event)
		
	: (alproEvt=AL Single click event)
		  //20131209 RCH Para mostrar detalle
		$l_columna:=AL_GetColumn (Self:C308->)
		$l_row:=AL_GetClickedRow (Self:C308->)
		If ($l_columna>0)
			$y_punteroArreglo:=Get pointer:C304("aQR_Text"+String:C10($l_columna))
			If ($l_row<=Size of array:C274($y_punteroArreglo->))
				IT_MuestraInfoDetallada_Texto ($y_punteroArreglo->{$l_row};[NTC_Notificaciones:190]Encabezado:12+"\r"+String:C10([NTC_Notificaciones:190]Fecha_creacion:2;System date long:K1:3)+", "+String:C10([NTC_Notificaciones:190]Hora_creacion:3))
			End if 
		End if 
		
End case 