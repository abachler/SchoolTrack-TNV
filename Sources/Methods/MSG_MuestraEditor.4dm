//%attributes = {}
  // MSG_MuestraEditor()
  // Por: Alberto Bachler: 25/03/13, 11:51:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_estadoProceso;$l_IdProcesoSoporte;$l_NumeroProceso)
C_TEXT:C284($t_texto)


vl_IdMensaje:=0
GET MACRO PARAMETER:C997(Highlighted method text:K5:18;$t_texto)
If ($t_texto#"")
	vl_IdMensaje:=Num:C11($t_texto)
End if 
vb_mensajesEditables:=True:C214
$l_NumeroProceso:=Process number:C372("Editor de Mensajes")
$l_estadoProceso:=Process state:C330($l_NumeroProceso)

Case of 
	: ($l_estadoProceso<0)
		$l_IdProcesoSoporte:=New process:C317(Current method name:C684;128000;"Editor de Mensajes";vl_IdMensaje;vb_mensajesEditables)
		
	: ($l_estadoProceso#0)
		RESUME PROCESS:C320($l_NumeroProceso)
		SET PROCESS VARIABLE:C370($l_NumeroProceso;vl_IdMensaje;vl_IdMensaje;vb_mensajesEditables;vb_mensajesEditables)
		BRING TO FRONT:C326($l_NumeroProceso)
		POST OUTSIDE CALL:C329($l_NumeroProceso)
		
	Else 
		
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
		
		WDW_OpenFormWindow (->[xShell_MensajesAplicacion:244];"Editor";-1;8)
		DIALOG:C40([xShell_MensajesAplicacion:244];"Editor")
		CLOSE WINDOW:C154
		
		If (OK=1)
			SET MACRO PARAMETER:C998(Highlighted method text:K5:18;"MSG_TextoMensaje(\""+<>vt_RefMensaje+"\")")
		End if 
		HL_ClearList (hl_Modulos;hl_componentes;hl_acciones;hl_mensajes)
		
End case 