  // CDOC_HistorialMetodo.lb_actual()
  // Por: Alberto Bachler: 16/04/13, 13:40:50
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Contextual click:C713)
	ARRAY TEXT:C222(at_CodigoActual_Codigo;0)
	ARRAY LONGINT:C221(al_CodigoActual_linea;0)
	
	$t_textoMenu:=AT_array2text (->at_Modificaciones_DTS)
	$l_Opcion:=Pop up menu:C542("En esta versión;Ultima versión en repositorio;(-;"+$t_textoMenu)
	
	If ($l_Opcion>0)
		Case of 
			: ($l_Opcion=1)
				ARRAY TEXT:C222($at_metodos_Nombres;0)
				ARRAY LONGINT:C221($al_metodos_Ids;0)
				4D_GetMethodList (->$at_metodos_Nombres;->$al_metodos_Ids)
				$l_elemento:=Find in array:C230($at_metodos_Nombres;vt_NombreMetodo)
				If ($l_elemento>0)
					$l_IdMetodo:=$al_metodos_Ids{$l_elemento}
					$t_codigo:=4D_GetMethodTextByID ($l_IdMetodo)
					$error:=API Get Resource Timestamp ("CC4D";$l_IdMetodo;$d_fecha;$t_hora)
					OBJECT SET TITLE:C194(*;"vl_tituloCodigo_Actual";"En esta versión")
					AT_Text2Array (->at_CodigoActual_Codigo;$t_codigo;"\r")
					ARRAY LONGINT:C221(al_CodigoActual_linea;Size of array:C274(at_CodigoActual_Codigo))
					For ($i;1;Size of array:C274(al_CodigoActual_linea))
						al_CodigoActual_linea{$i}:=$i
					End for 
					vt_fechaAutor_Izquierda:=String:C10($d_fecha;Internal date short special:K1:4)+", "+String:C10($t_hora;HH MM SS:K7:1)
				End if 
				
				
			: ($l_Opcion=2)
				OBJECT SET TITLE:C194(*;"vl_tituloCodigo_Actual";"Ultima versión en repositorio")
				$t_codigo:=at_modificaciones_Codigo{1}
				AT_Text2Array (->at_CodigoActual_Codigo;$t_codigo;"\r")
				ARRAY LONGINT:C221(al_CodigoActual_linea;Size of array:C274(at_CodigoActual_Codigo))
				For ($i;1;Size of array:C274(al_CodigoActual_linea))
					al_CodigoActual_linea{$i}:=$i
				End for 
				vt_fechaAutor_Izquierda:=at_modificaciones_DTS{1}
				
			: ($l_Opcion>3)
				$l_index:=$l_Opcion-3
				OBJECT SET TITLE:C194(*;"vl_tituloCodigo_Actual";"Ultima versión en repositorio")
				$t_codigo:=at_modificaciones_Codigo{$l_index}
				AT_Text2Array (->at_CodigoActual_Codigo;$t_codigo;"\r")
				ARRAY LONGINT:C221(al_CodigoActual_linea;Size of array:C274(at_CodigoActual_Codigo))
				For ($i;1;Size of array:C274(al_CodigoActual_linea))
					al_CodigoActual_linea{$i}:=$i
				End for 
				vt_fechaAutor_Izquierda:=at_modificaciones_DTS{$l_index}
				
		End case 
		vl_lineas_Izquierda:=Size of array:C274(al_CodigoActual_linea)
		vl_largo_Izquierda:=Length:C16($t_codigo)
	End if 
End if 