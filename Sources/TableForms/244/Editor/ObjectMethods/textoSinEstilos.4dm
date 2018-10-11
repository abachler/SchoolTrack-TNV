  // [xShell_MensajesAplicacion].Manager.Campo()
  // Por: Alberto Bachler: 25/03/13, 11:22:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_fin;$l_Indice;$l_inicio;$l_tamañoFuente;$l_ColorTexto;$l_colorFondo)
C_TEXT:C284($t_nombreFuente)
C_BOOLEAN:C305(vb_TextoEnEdicion)

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vb_TextoEnEdicion:=False:C215
		
	: ((Form event:C388=On After Keystroke:K2:26) | (Form event:C388=On Before Keystroke:K2:6) | (Form event:C388=On After Edit:K2:43))
		vb_TextoEnEdicion:=True:C214
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
		[xShell_MensajesAplicacion:244]Mensaje:4:=[xShell_MensajesAplicacion:244]Mensaje:4
		MSG_GuardaRegistro 
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		GET HIGHLIGHT:C209([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion)
		If (vl_inicioSeleccion>1)
			If ([xShell_MensajesAplicacion:244]Mensaje:4[[vl_inicioSeleccion-1]]="$")
				vl_inicioSeleccion:=vl_inicioSeleccion-1
				HIGHLIGHT TEXT:C210([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion)
			End if 
		End if 
		
	: ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Mouse Leave:K2:34))
		vb_TextoEnEdicion:=False:C215
		
		
	: (Form event:C388=On Selection Change:K2:29)
		If (Not:C34(vb_TextoEnEdicion))
			GET HIGHLIGHT:C209([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion)
			$t_textoSeleccionado:=ST Get plain text:C1092([xShell_MensajesAplicacion:244]Mensaje:4)
			If ($t_textoSeleccionado#"")
				If ((vl_inicioSeleccion>1) & (vl_inicioSeleccion<Length:C16($t_textoSeleccionado)))
					If ($t_textoSeleccionado[[vl_inicioSeleccion-1]]="$")
						vl_inicioSeleccion:=vl_inicioSeleccion-1
						HIGHLIGHT TEXT:C210([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion)
					End if 
				End if 
			End if 
			If (vl_inicioSeleccion>0)
				ST GET ATTRIBUTES:C1094([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion;Attribute font name:K65:5;$t_nombreFuente)
				ST GET ATTRIBUTES:C1094([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion;Attribute text size:K65:6;$l_tamañoFuente)
				ST GET ATTRIBUTES:C1094([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion;Attribute bold style:K65:1;$l_negritas)
				ST GET ATTRIBUTES:C1094([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion;Attribute italic style:K65:2;$l_cursivas)
				ST GET ATTRIBUTES:C1094([xShell_MensajesAplicacion:244]Mensaje:4;vl_inicioSeleccion;vl_finSeleccion;Attribute underline style:K65:4;$l_subrayado)
				
				
				If ($t_nombreFuente="")
					$t_nombreFuente:=OBJECT Get font:C1069([xShell_MensajesAplicacion:244]Mensaje:4)
				End if 
				$l_Indice:=Find in array:C230(at_Fonts;$t_nombreFuente)
				If ($l_indice>0)
					at_Fonts:=$l_Indice
				End if 
				bNegritas:=$l_negritas
				bCursivas:=$l_cursivas
				bSubrayado:=$l_subrayado
				If ($l_tamañoFuente<0)
					$l_tamañoFuente:=OBJECT Get font size:C1070([xShell_MensajesAplicacion:244]Mensaje:4)
				End if 
				$l_Indice:=Find in array:C230(al_FontSizes;$l_tamañoFuente)
				If ($l_Indice<0)
					APPEND TO ARRAY:C911(al_FontSizes;$l_tamañoFuente)
					SORT ARRAY:C229(al_FontSizes;>)
				End if 
				al_FontSizes:=Find in array:C230(al_FontSizes;$l_tamañoFuente)
			End if 
		End if 
		
		
End case 
