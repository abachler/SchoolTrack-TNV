//%attributes = {}
  // MSG_ListaTags()
  // Por: Alberto Bachler: 29/05/13, 10:20:41
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


  // fuentes en el editor
ARRAY TEXT:C222(at_fonts;0)
FONT LIST:C460(at_fonts)

  // tamaños de fuentes
ARRAY LONGINT:C221(al_fontSizes;0)
APPEND TO ARRAY:C911(al_fontSizes;9)
APPEND TO ARRAY:C911(al_fontSizes;10)
APPEND TO ARRAY:C911(al_fontSizes;11)
APPEND TO ARRAY:C911(al_fontSizes;12)
APPEND TO ARRAY:C911(al_fontSizes;14)
APPEND TO ARRAY:C911(al_fontSizes;16)
APPEND TO ARRAY:C911(al_fontSizes;18)
APPEND TO ARRAY:C911(al_fontSizes;24)

hl_Modulos:=New list:C375
APPEND TO LIST:C376(hl_Modulos;"SchoolTrack";1)
APPEND TO LIST:C376(hl_Modulos;"MediaTrack";2)
APPEND TO LIST:C376(hl_Modulos;"AccountTrack";3)
APPEND TO LIST:C376(hl_Modulos;"AdmissionTrack";1)
APPEND TO LIST:C376(hl_Modulos;"Común";-1)
SELECT LIST ITEMS BY POSITION:C381(hl_Modulos;1)
hl_componentes:=New list:C375
hl_acciones:=New list:C375
hl_mensajes:=New list:C375

vb_mensajesEditables:=False:C215
vl_IdMensaje:=0

WDW_OpenFormWindow (->[xShell_MensajesAplicacion:244];"Editor";-1;8)
DIALOG:C40([xShell_MensajesAplicacion:244];"Editor")
CLOSE WINDOW:C154

If (OK=1)
	SET MACRO PARAMETER:C998(Highlighted method text:K5:18;<>vt_Confirmacion_Codigo)
End if 
HL_ClearList (hl_Modulos;hl_componentes;hl_acciones;hl_mensajes)
