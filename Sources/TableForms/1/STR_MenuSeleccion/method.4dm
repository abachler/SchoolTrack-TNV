Case of 
	: (Form event:C388=On Load:K2:1)
		If (Not:C34(muliseleccion))
			OBJECT SET VISIBLE:C603(b_seleccion;False:C215)
		End if 
		ARRAY BOOLEAN:C223(lb_contenido;Size of array:C274(ay_arreglos{1}->))
		If (Size of array:C274(ay_arreglos)>0)
			For ($i;1;Size of array:C274(y_puntero->))
				vt_titulo:=String:C10($i)
				LISTBOX INSERT COLUMN:C829(lb_contenido;$i;"Columna"+String:C10($i);ay_arreglos{$i}->;"titulo"+String:C10($i);vt_titulo)
				LISTBOX SET COLUMN WIDTH:C833(*;"Columna"+String:C10($i);y_tamaño->{$i})
				OBJECT SET TITLE:C194(*;"titulo"+String:C10($i);y_titulo->{$i})
				OBJECT SET ENTERABLE:C238(*;"Columna"+String:C10($i);y_columnaEditable->{$i})
			End for 
		End if 
		
		If (Not:C34(Is nil pointer:C315(y_marcarLineas)))
			For ($i;1;Size of array:C274(y_marcarLineas->))
				lb_contenido{y_marcarLineas->{$i}}:=True:C214
			End for 
		End if 
End case 
