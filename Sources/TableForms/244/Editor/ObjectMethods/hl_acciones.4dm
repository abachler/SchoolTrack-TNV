  // [xShell_MensajesAplicacion].Editor.hl_modulos()
  // Por: Alberto Bachler: 25/03/13, 15:17:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
		
	: (Form event:C388=On Clicked:K2:4)
		vl_tipoSeleccion:=1
		MSG_ProcesaEventos ("ListaMensajes")
		
	: (Form event:C388=On Data Change:K2:15)
		vl_tipoSeleccion:=1
		MSG_ProcesaEventos ("EdicionAccion")
		
	: (Form event:C388=On Double Clicked:K2:5)
		PROCESS PROPERTIES:C336(Current process:C322;$t_nombreProceso;$l_estadoProceso;$l_tiempo)
		If ($t_nombreProceso#"Editor de Mensajes")
			QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Modulo:1=[xShell_MensajesAplicacion:244]Modulo:1;*)
			QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Componente:2=[xShell_MensajesAplicacion:244]Componente:2;*)
			QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Acción:3=[xShell_MensajesAplicacion:244]Acción:3;*)
			QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Tipo:6=0)
			
			
			
			ARRAY TEXT:C222($at_Mensajes;0)
			ARRAY TEXT:C222($at_tags;0)
			
			<>vt_Confirmacion_Codigo:=""
			ARRAY LONGINT:C221($al_RecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([xShell_MensajesAplicacion:244];$al_RecNums;"")
			For ($i_mensajes;1;Size of array:C274($al_RecNums))
				KRL_GotoRecord (->[xShell_MensajesAplicacion:244];$al_RecNums{$i_mensajes};False:C215)
				$t_mensaje:=String:C10([xShell_MensajesAplicacion:244]ID:5)+"/"+[xShell_MensajesAplicacion:244]Referencia:7
				If (Find in array:C230($at_Mensajes;$t_mensaje)<0)
					APPEND TO ARRAY:C911($at_Mensajes;"IT_Confirmacion_AgregaElemento (MSG_TextoMensaje(\""+$t_mensaje+"\"))")
				End if 
				
				$l_posicionTag:=Position:C15("$";[xShell_MensajesAplicacion:244]Mensaje:4)
				$t_caracteresFinTag:=" .,;:-*+/= !¡¿\\|{}[]'?)&#\"\r\t<>"
				While ($l_posicionTag>0)
					$t_tag:="$"
					$l_numeroCaracteres:=1
					For ($i;$l_posicionTag+1;Length:C16([xShell_MensajesAplicacion:244]Mensaje:4))
						$t_caracter:=[xShell_MensajesAplicacion:244]Mensaje:4[[$i]]
						If (Position:C15($t_caracter;$t_caracteresFinTag)>0)
							$i:=Length:C16([xShell_MensajesAplicacion:244]Mensaje:4)+1
						Else 
							$t_tag:=$t_tag+$t_caracter
							$l_numeroCaracteres:=$l_numeroCaracteres+1
						End if 
					End for 
					If (Find in array:C230($at_tags;$t_tag)<0)
						APPEND TO ARRAY:C911($at_tags;$t_tag)
					End if 
					$l_posicionTag:=Position:C15("$";[xShell_MensajesAplicacion:244]Mensaje:4;$l_posicionTag+$l_numeroCaracteres)
				End while 
			End for 
			
			If (Size of array:C274($at_Mensajes)>0)
				$t_codigo:="  // Inicializo el componente IT_Confirmacion\r"
				$t_codigo:=$t_codigo+"IT_Confirmacion_Inicializa\r\r"
				$t_codigo:=$t_codigo+"  //Cargo los elementos que se mostrarán en el mensaje de confirmación\r"
				$t_codigo:=$t_codigo+AT_array2text (->$at_Mensajes;"\r")
			End if 
			
			If (Size of array:C274($at_tags)>0)
				SORT ARRAY:C229($at_tags;>)
				For ($i;1;Size of array:C274($at_tags))
					Case of 
						: ($at_tags{$i}="$d_@")
							$at_tags{$i}:="$l_Error:=IT_Confirmacion_AgregaTagValor(\""+$at_tags{$i}+"\";String("+$at_tags{$i}+";System date abbreviated))"
						: ($at_tags{$i}="$h_@")
							$at_tags{$i}:="$l_Error:=IT_Confirmacion_AgregaTagValor(\""+$at_tags{$i}+"\";String("+$at_tags{$i}+";HH MM SS))"
						: ($at_tags{$i}="$l_@")
							$at_tags{$i}:="$l_Error:=IT_Confirmacion_AgregaTagValor(\""+$at_tags{$i}+"\";String("+$at_tags{$i}+"))"
						Else 
							$at_tags{$i}:="$l_Error:=IT_Confirmacion_AgregaTagValor(\""+$at_tags{$i}+"\";"+$at_tags{$i}+")"
					End case 
				End for 
				$t_codigoTagValores:=AT_array2text (->$at_tags;"\r")
			End if 
			$t_codigo:=$t_codigo+"\r\r"
			$t_codigo:=$t_codigo+"// Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje\r"
			$t_codigo:=$t_codigo+$t_codigoTagValores
			$t_codigo:=$t_codigo+"\r\r"
			$t_codigo:=$t_codigo+"  // Muestro el cuadro de diálogo de confirmación\r"
			$t_codigo:=$t_codigo+"  // pasa en $t_textoLog el encabezado para el registro de actividades\r"
			$t_codigo:=$t_codigo+"$t_Textolog:=\"\"\r"
			$t_codigo:=$t_codigo+"$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje($t_TextoLog)\r"
			
			
			<>vt_Confirmacion_Codigo:=$t_codigo
			
			ACCEPT:C269
		End if 
		
End case 