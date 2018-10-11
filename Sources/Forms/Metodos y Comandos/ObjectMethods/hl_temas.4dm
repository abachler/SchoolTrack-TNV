  // Metodos y Comandos.hl_temas()
  // Por: Alberto Bachler: 24/02/13, 10:10:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_actualizarTema;$b_desplegada;$b_editable)
C_LONGINT:C283($i;$i_Comandos;$l_abajo;$l_arriba;$l_color;$l_derecha;$l_estilo;$l_icon;$l_idComando;$l_idTema;$l_indiceItem)
C_LONGINT:C283($l_itemComandos;$l_itemsAutorizados;$l_itemSeleccionado;$l_itemsNoAutorizados;$l_itemTemas;$l_izquierda;$l_primerElemento;$l_proceso;$l_RefItemSeleccionado;$l_sublista)
C_LONGINT:C283($l_sublistaOrigen;$l_sublistaTema;$l_sublistaTemaDestino;$l_temaOrigen)
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_autorizado;$t_descripcion;$t_helpTip;$t_itemsPopup;$t_nombreComando;$t_NombreItemSeleccionado;$t_nombreTema;$t_sintaxis)

ARRAY LONGINT:C221($al_ComandosSeleccionados;0)
ARRAY LONGINT:C221($al_ReferenciasComandos;0)
ARRAY TEXT:C222($at_nombresComandos;0)
ARRAY LONGINT:C221($al_ReferenciasComandos;0)
ARRAY TEXT:C222($at_nombresComandos;0)

Case of 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($y_objeto;$l_indiceItem;$l_proceso)
		$l_itemTemas:=Drop position:C608
		
		Case of 
			: ($y_objeto->=hl_comandos)
				$l_itemComandos:=Selected list items:C379(hl_comandos;$al_ComandosSeleccionados;*)
				GET LIST ITEM:C378(hl_temas;$l_itemTemas;$l_idTema;$t_nombreTema;$l_sublistaTema)
				If (List item parent:C633(hl_temas;$l_IdTema)=0)
					
				Else 
					$l_IdTema:=List item parent:C633(hl_temas;$l_IdTema)
					SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$l_IdTema)
					GET LIST ITEM:C378(hl_temas;*;$l_idTema;$t_nombreTema;$l_sublistaTema)
				End if 
				If ($l_sublistaTema=0)
					$l_sublistaTema:=New list:C375
				End if 
				For ($i;1;Size of array:C274($al_ComandosSeleccionados))
					SELECT LIST ITEMS BY REFERENCE:C630(hl_comandos;$al_ComandosSeleccionados{$i})
					GET LIST ITEM:C378(hl_comandos;*;$l_idComando;$t_nombreComando)
					GET LIST ITEM PARAMETER:C985(hl_comandos;$l_IdComando;"Sintaxis";$t_sintaxis)
					GET LIST ITEM PARAMETER:C985(hl_comandos;$l_IdComando;"Descripcion";$t_descripcion)
					GET LIST ITEM PARAMETER:C985(hl_comandos;$l_IdComando;"Autorizado";$t_autorizado)
					$l_indiceItem:=Find in list:C952($l_sublistaTema;$t_nombreComando;0)
					If ($l_indiceItem=0)
						APPEND TO LIST:C376($l_sublistaTema;$t_nombreComando;$l_idComando)
					Else 
						GET LIST ITEM:C378($l_sublistaTema;$l_indiceItem;$l_idComando;$t_nombreComando)
					End if 
					SET LIST ITEM PARAMETER:C986(hl_temas;$l_IdComando;"Sintaxis";$t_sintaxis)
					SET LIST ITEM PARAMETER:C986(hl_temas;$l_IdComando;"Descripcion";$t_descripcion)
					SET LIST ITEM PARAMETER:C986(hl_temas;$l_IdComando;"Autorizado";$t_autorizado)
					GET LIST ITEM PROPERTIES:C631(hl_temas;$l_IdComando;$b_editable;$l_estilo;$l_icon;$l_color)
					Case of 
						: ($t_autorizado="")
							$l_color:=0
						: ($t_autorizado="1")
							$l_color:=0x7F00
						: ($t_autorizado="0")
							$l_color:=0x00FF0000
					End case 
					SET LIST ITEM PROPERTIES:C386(hl_temas;$l_IdComando;$b_editable;$l_estilo;$l_icon;$l_color)
					DELETE FROM LIST:C624(hl_comandos;$l_IdComando)
				End for 
				SET LIST ITEM:C385(hl_temas;$l_idTema;$t_nombreTema;$l_idTema;$l_sublistaTema;True:C214)
				SET LIST ITEM PROPERTIES:C386(hl_temas;$l_idTema;False:C215;Bold:K14:2;0)
				SORT LIST:C391(hl_temas)
				
			: ($y_objeto->=Self:C308->)
				$l_primerElemento:=Selected list items:C379(hl_temas;$al_ComandosSeleccionados;*)
				GET LIST ITEM:C378(hl_temas;$l_itemTemas;$l_IdTema;$t_nombreTema;$l_sublistaTemaDestino)
				If (List item parent:C633(hl_temas;$l_IdTema)=0)
					
				Else 
					$l_IdTema:=List item parent:C633(hl_temas;$l_IdTema)
					SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$l_IdTema)
					GET LIST ITEM:C378(hl_temas;*;$l_idTema;$t_nombreTema;$l_sublistaTemaDestino)
				End if 
				If ($l_sublistaTemaDestino=0)
					$l_sublistaTemaDestino:=New list:C375
				End if 
				
				For ($i;1;Size of array:C274($al_ComandosSeleccionados))
					$l_temaOrigen:=List item parent:C633(hl_temas;$al_ComandosSeleccionados{$i})
					If ($l_temaOrigen<0)
						$b_actualizarTema:=True:C214
						SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$al_ComandosSeleccionados{$i})
						GET LIST ITEM:C378(hl_temas;*;$l_IdComando;$t_nombreComando)
						GET LIST ITEM PARAMETER:C985(hl_temas;$l_IdComando;"Sintaxis";$t_sintaxis)
						GET LIST ITEM PARAMETER:C985(hl_temas;$l_IdComando;"Descripcion";$t_descripcion)
						GET LIST ITEM PARAMETER:C985(hl_temas;$l_IdComando;"Autorizado";$t_autorizado)
						DELETE FROM LIST:C624(hl_temas;$l_IdComando)
						APPEND TO LIST:C376($l_sublistaTemaDestino;$t_nombreComando;$l_IdComando)
						SET LIST ITEM PARAMETER:C986($l_sublistaTemaDestino;$l_IdComando;"Sintaxis";$t_sintaxis)
						SET LIST ITEM PARAMETER:C986($l_sublistaTemaDestino;$l_IdComando;"Descripcion";$t_descripcion)
						SET LIST ITEM PARAMETER:C986($l_sublistaTemaDestino;$l_IdComando;"Autorizado";$t_autorizado)
						SET LIST ITEM PARAMETER:C986(hl_temas;$l_IdComando;"Sintaxis";$t_sintaxis)
						SET LIST ITEM PARAMETER:C986(hl_temas;$l_IdComando;"Descripcion";$t_descripcion)
						SET LIST ITEM PARAMETER:C986(hl_temas;$l_IdComando;"Autorizado";$t_autorizado)
						
						GET LIST ITEM PROPERTIES:C631(hl_temas;$l_IdComando;$b_editable;$l_estilo;$l_icon;$l_color)
						Case of 
							: ($t_autorizado="")
								$l_color:=0
							: ($t_autorizado="1")
								$l_color:=0x7F00
							: ($t_autorizado="0")
								$l_color:=0x00FF0000
						End case 
						SET LIST ITEM PROPERTIES:C386(hl_temas;$l_IdComando;$b_editable;$l_estilo;$l_icon;$l_color)
					End if 
				End for 
				
				If ($b_actualizarTema)
					  // actualizo el tema de destino
					
					SET LIST ITEM:C385(hl_temas;$l_IdTema;$t_nombreTema;$l_idTema;$l_sublistaTemaDestino;True:C214)
					SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$l_IdTema)
					GET LIST ITEM:C378(hl_temas;*;$l_IdTema;$t_nombreTema;$l_sublistaTemaDestino;$b_desplegada)
					HL_ReferencedList2Array ($l_sublistaTemaDestino;->$at_nombresComandos;->$al_ReferenciasComandos)
					$l_itemsAutorizados:=0
					$l_itemsNoAutorizados:=0
					For ($i;1;Size of array:C274($al_ReferenciasComandos))
						GET LIST ITEM PARAMETER:C985(hl_temas;$al_ReferenciasComandos{$i};"Autorizado";$t_autorizado)
						$l_itemsAutorizados:=$l_itemsAutorizados+Num:C11($t_autorizado="1")
						$l_itemsNoAutorizados:=$l_itemsNoAutorizados+Num:C11($t_autorizado="0")
					End for 
					Case of 
						: (($l_itemsAutorizados=0) & ($l_itemsNoAutorizados=0))
							SET LIST ITEM PARAMETER:C986(hl_temas;$l_idTema;"Autorizado";"")
							SET LIST ITEM PROPERTIES:C386(hl_temas;$l_idTema;False:C215;Bold:K14:2;0;0)
						: ($l_itemsAutorizados#0)
							SET LIST ITEM PARAMETER:C986(hl_temas;$l_idTema;"Autorizado";"1")
							SET LIST ITEM PROPERTIES:C386(hl_temas;$l_idTema;False:C215;Bold:K14:2;0;0x7F00)
						: ($l_itemsNoAutorizados#0)
							SET LIST ITEM PARAMETER:C986(hl_temas;$l_idTema;"Autorizado";"0")
							SET LIST ITEM PROPERTIES:C386(hl_temas;$l_idTema;False:C215;Bold:K14:2;0;0x00FF0000)
					End case 
					
					  // actualizo el tema de origen
					SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$l_temaOrigen)
					GET LIST ITEM:C378(hl_temas;*;$l_temaOrigen;$t_nombreTema;$l_sublistaOrigen;$b_desplegada)
					
					If (Count list items:C380($l_sublistaOrigen)=0)
						SET LIST ITEM PROPERTIES:C386(hl_temas;$l_temaOrigen;False:C215;Plain:K14:1;0;0)
					Else 
						HL_ReferencedList2Array ($l_sublistaOrigen;->$at_nombresComandos;->$al_ReferenciasComandos)
						$l_itemsAutorizados:=0
						$l_itemsNoAutorizados:=0
						For ($i;1;Size of array:C274($al_ReferenciasComandos))
							GET LIST ITEM PARAMETER:C985(hl_temas;$al_ReferenciasComandos{$i};"Autorizado";$t_autorizado)
							$l_itemsAutorizados:=$l_itemsAutorizados+Num:C11($t_autorizado="1")
							$l_itemsNoAutorizados:=$l_itemsNoAutorizados+Num:C11($t_autorizado="0")
						End for 
						  //For ($i_Comandos;1;Count list items($l_sublistaOrigen))
						  //SELECT LIST ITEMS BY POSITION($l_sublistaOrigen;$i_Comandos)
						  //GET LIST ITEM($l_sublistaOrigen;*;$l_IdComando;$t_nombreComando)
						  //$l_itemsAutorizados:=$l_itemsAutorizados+Num($t_autorizado="1")
						  //$l_itemsNoAutorizados:=$l_itemsNoAutorizados+Num($t_autorizado="0")
						  //End for 
						Case of 
							: (($l_itemsAutorizados=0) & ($l_itemsNoAutorizados=0))
								SET LIST ITEM PARAMETER:C986(hl_temas;$l_temaOrigen;"Autorizado";"")
								SET LIST ITEM PROPERTIES:C386(hl_temas;$l_temaOrigen;False:C215;Bold:K14:2;0;0)
							: ($l_itemsAutorizados#0)
								SET LIST ITEM PARAMETER:C986(hl_temas;$l_temaOrigen;"Autorizado";"1")
								SET LIST ITEM PROPERTIES:C386(hl_temas;$l_temaOrigen;False:C215;Bold:K14:2;0;0x7F00)
							: ($l_itemsNoAutorizados#0)
								SET LIST ITEM PARAMETER:C986(hl_temas;$l_temaOrigen;"Autorizado";"0")
								SET LIST ITEM PROPERTIES:C386(hl_temas;$l_temaOrigen;False:C215;Bold:K14:2;0;0x00FF0000)
						End case 
					End if 
					
				Else 
					HL_ClearList ($l_sublistaTemaDestino)
				End if 
				SORT LIST:C391(hl_temas)
				
		End case 
		
	: (Form event:C388=On Clicked:K2:4)
		
		Case of 
			: (Contextual click:C713)
				$t_itemsPopup:="Autorizar;No mostrar;-;Expandir todo;Contraer todo"
				$l_itemSeleccionado:=Pop up menu:C542($t_itemsPopup)
				Case of 
					: (($l_itemSeleccionado=1) | ($l_itemSeleccionado=2))
						If ($l_itemSeleccionado=1)
							$t_autorizado:="1"
							$l_color:=0x7F00
						Else 
							$t_autorizado:="0"
							$l_color:=0x00FF0000
						End if 
						$l_itemComandos:=Selected list items:C379(hl_temas;$al_ComandosSeleccionados;*)
						For ($i;1;Size of array:C274($al_ComandosSeleccionados))
							If (List item parent:C633(hl_temas;$al_ComandosSeleccionados{$i})=0)
								SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$al_ComandosSeleccionados{$i})
								GET LIST ITEM:C378(hl_temas;*;$l_IdTema;$t_nombreTema;$l_sublista)
								For ($i_Comandos;1;Count list items:C380($l_sublista))
									SELECT LIST ITEMS BY POSITION:C381($l_sublista;$i_Comandos)
									GET LIST ITEM:C378($l_sublista;$i_Comandos;$l_idComando;$t_nombreComando)
									SET LIST ITEM PARAMETER:C986($l_sublista;$l_idComando;"Autorizado";$t_autorizado)
									SET LIST ITEM PROPERTIES:C386($l_sublista;$l_idComando;False:C215;Plain:K14:1;0;$l_color)
								End for 
								SET LIST ITEM PARAMETER:C986(hl_temas;$l_IdTema;"Autorizado";$t_autorizado)
								SET LIST ITEM PROPERTIES:C386(hl_temas;$l_IdTema;False:C215;Bold:K14:2;0;$l_color)
							Else 
								SET LIST ITEM PARAMETER:C986(hl_temas;$al_ComandosSeleccionados{$i};"Autorizado";$t_autorizado)
								SET LIST ITEM PROPERTIES:C386(hl_temas;$al_ComandosSeleccionados{$i};False:C215;Plain:K14:1;0;$l_color)
								$l_idTema:=List item parent:C633(hl_temas;$al_ComandosSeleccionados{$i})
								SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$l_idTema)
								GET LIST ITEM:C378(hl_temas;*;$l_IdTema;$t_nombreTema;$l_sublista)
								SET LIST ITEM PARAMETER:C986($l_sublista;$al_ComandosSeleccionados{$i};"Autorizado";$t_autorizado)
								SET LIST ITEM PROPERTIES:C386($l_sublista;$al_ComandosSeleccionados{$i};False:C215;Plain:K14:1;0;$l_color)
								$l_itemsAutorizados:=0
								For ($i_Comandos;1;Count list items:C380($l_sublista))
									SELECT LIST ITEMS BY POSITION:C381($l_sublista;$i_Comandos)
									GET LIST ITEM PARAMETER:C985($l_sublista;*;"Autorizado";$t_autorizado)
									$l_itemsAutorizados:=$l_itemsAutorizados+Num:C11($t_autorizado="1")
								End for 
								If ($l_itemsAutorizados=0)
									SET LIST ITEM PARAMETER:C986(hl_temas;$l_idTema;"Autorizado";"0")
									SET LIST ITEM PROPERTIES:C386(hl_temas;$l_idTema;False:C215;Bold:K14:2;0;0x00FF0000)
								Else 
									SET LIST ITEM PARAMETER:C986(hl_temas;$l_idTema;"Autorizado";"1")
									SET LIST ITEM PROPERTIES:C386(hl_temas;$l_idTema;False:C215;Bold:K14:2;0;0x7F00)
								End if 
							End if 
							GET LIST ITEM PARAMETER:C985(hl_temas;$al_ComandosSeleccionados{$i};"Autorizado";$t_autorizado)
							GET LIST ITEM PROPERTIES:C631(hl_temas;$al_ComandosSeleccionados{$i};$b_editable;$l_estilo;$l_icon;$l_color)
							Case of 
								: ($t_autorizado="")
									$l_color:=0
								: ($t_autorizado="1")
									$l_color:=0x7F00
								: ($t_autorizado="0")
									$l_color:=0x00FF0000
							End case 
							SET LIST ITEM PROPERTIES:C386(hl_temas;$al_ComandosSeleccionados{$i};$b_editable;$l_estilo;$l_icon;$l_color)
						End for 
						SELECT LIST ITEMS BY POSITION:C381(hl_temas;0)
						
					: ($l_itemSeleccionado=4)
						HL_ExpandAll (hl_temas)
						
					: ($l_itemSeleccionado=5)
						HL_CollapseAll (hl_temas)
						
				End case 
			Else 
				If (List item parent:C633(hl_temas;*)>0)
					GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$l_RefItemSeleccionado;$t_NombreItemSeleccionado)
					GET LIST ITEM PARAMETER:C985(Self:C308->;$l_RefItemSeleccionado;"Sintaxis";$t_sintaxis)
					GET LIST ITEM PARAMETER:C985(Self:C308->;$l_RefItemSeleccionado;"Descripcion";$t_descripcion)
					$t_helpTip:=$t_sintaxis+"\r"+$t_descripcion
					OBJECT GET COORDINATES:C663(Self:C308->;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					API Create Tip ($t_helpTip;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
				End if 
		End case 
		
End case 

