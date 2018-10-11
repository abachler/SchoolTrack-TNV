  // Metodos y Comandos.Botón()
  // Por: Alberto Bachler: 25/02/13, 18:13:09
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($i;$l_color;$l_estilo;$l_icon;$l_idComando;$l_itemTemas)
C_POINTER:C301($y_lastObject)
C_TEXT:C284($t_Autorizado;$t_descripcion;$t_nombreComando;$t_sintaxis)

ARRAY LONGINT:C221($al_ComandosSeleccionados;0)
$y_lastObject:=Focus object:C278

If ($y_lastObject->=hl_temas)
	$l_itemTemas:=Selected list items:C379(hl_temas;$al_ComandosSeleccionados;*)
	If ((Macintosh option down:C545 | Windows Alt down:C563) & Shift down:C543)
		For ($i;1;Size of array:C274($al_ComandosSeleccionados))
			DELETE FROM LIST:C624(hl_temas;$al_ComandosSeleccionados{$i})
		End for 
	Else 
		For ($i;1;Size of array:C274($al_ComandosSeleccionados))
			If (List item parent:C633(hl_temas;$al_ComandosSeleccionados{$i})<0)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$al_ComandosSeleccionados{$i})
				GET LIST ITEM:C378(hl_temas;*;$l_idComando;$t_nombreComando)
				GET LIST ITEM PARAMETER:C985(hl_temas;$l_IdComando;"Sintaxis";$t_sintaxis)
				GET LIST ITEM PARAMETER:C985(hl_temas;$l_IdComando;"Descripcion";$t_descripcion)
				GET LIST ITEM PARAMETER:C985(hl_temas;$l_IdComando;"Autorizado";$t_Autorizado)
				DELETE FROM LIST:C624(hl_temas;$al_ComandosSeleccionados{$i})
				APPEND TO LIST:C376(hl_comandos;$t_nombreComando;$l_idComando)
				SET LIST ITEM PARAMETER:C986(hl_comandos;$l_IdComando;"Sintaxis";$t_sintaxis)
				SET LIST ITEM PARAMETER:C986(hl_comandos;$l_IdComando;"Descripcion";$t_descripcion)
				SET LIST ITEM PARAMETER:C986(hl_comandos;$l_IdComando;"Autorizado";$t_Autorizado)
				GET LIST ITEM PROPERTIES:C631(hl_comandos;$l_IdComando;$b_editable;$l_estilo;$l_icon;$l_color)
				Case of 
					: ($t_autorizado="")
						$l_color:=0
					: ($t_autorizado="1")
						$l_color:=0x7F00
					: ($t_autorizado="0")
						$l_color:=0x00FF0000
				End case 
				SET LIST ITEM PROPERTIES:C386(hl_comandos;$l_IdComando;$b_editable;$l_estilo;$l_icon;$l_color)
			End if 
		End for 
	End if 
End if 
SORT LIST:C391(hl_comandos)
