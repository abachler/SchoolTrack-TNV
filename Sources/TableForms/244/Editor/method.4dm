  // [xShell_MensajesAplicacion].Editor()
  // Por: Alberto Bachler: 23/03/13, 11:51:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_refModulo;$l_refComponente;<>vl_RefAcciones;$l_refMensaje)

Case of 
	: ((Form event:C388=On Load:K2:1) | (Form event:C388=On Outside Call:K2:11))
		vl_tipoSeleccion:=-1
		
		OBJECT SET ENTERABLE:C238(*;"textoSinEstilos@";False:C215)
		$t_nombreFuente:=OBJECT Get font:C1069([xShell_MensajesAplicacion:244]Mensaje:4)
		$l_Indice:=Find in array:C230(at_Fonts;$t_nombreFuente)
		If ($l_indice>0)
			at_Fonts:=$l_Indice
		End if 
		
		
		
		$l_tamañoFuente:=OBJECT Get font size:C1070([xShell_MensajesAplicacion:244]Mensaje:4)
		$l_Indice:=Find in array:C230(al_FontSizes;$l_tamañoFuente)
		If ($l_Indice<0)
			APPEND TO ARRAY:C911(al_FontSizes;$l_tamañoFuente)
			SORT ARRAY:C229(al_FontSizes;>)
		End if 
		al_FontSizes:=Find in array:C230(al_FontSizes;$l_tamañoFuente)
		
		MSG_ProcesaEventos ("ListaComponentes")
		
		OBJECT SET ENTERABLE:C238(*;"@";vb_mensajesEditables)
		OBJECT SET VISIBLE:C603(*;"texto_instruccion";Not:C34(vb_mensajesEditables))
		
		  //REDUCE SELECTION([xShell_MensajesAplicacion];0)
		  //LISTBOX SELECT ROW(hl_modulos;0;Remove from listbox selection)
		  //LISTBOX SELECT ROW(hl_componentes;0;Remove from listbox selection)
		  //LISTBOX SELECT ROW(hl_acciones;0;Remove from listbox selection)
		  //LISTBOX SELECT ROW(hl_mensajes;0;Remove from listbox selection)
		
		If ([xShell_MensajesAplicacion:244]ID:5>0)
			vl_tipoSeleccion:=[xShell_MensajesAplicacion:244]Tipo:6
		Else 
			vl_tipoSeleccion:=-1
		End if 
		IT_SetButtonState (vl_tipoSeleccion=0;->beliminaMensaje)
		IT_SetButtonState (vl_tipoSeleccion=1;->beliminaAccion)
		IT_SetButtonState (vl_tipoSeleccion=2;->beliminaComponente)
		Case of 
			: (vl_tipoSeleccion=0)
				GOTO OBJECT:C206(hl_Mensajes)
			: (vl_tipoSeleccion=1)
				GOTO OBJECT:C206(hl_acciones)
			: (vl_tipoSeleccion=2)
				GOTO OBJECT:C206(hl_componentes)
			Else 
				GOTO OBJECT:C206(hl_modulos)
		End case 
		
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		IT_SetButtonState (vl_tipoSeleccion=0;->beliminaMensaje)
		IT_SetButtonState (vl_tipoSeleccion=1;->beliminaAccion)
		IT_SetButtonState (vl_tipoSeleccion=2;->beliminaComponente)
		Case of 
			: (vl_tipoSeleccion=0)
				GOTO OBJECT:C206(hl_Mensajes)
			: (vl_tipoSeleccion=1)
				GOTO OBJECT:C206(hl_acciones)
			: (vl_tipoSeleccion=2)
				GOTO OBJECT:C206(hl_componentes)
			Else 
				GOTO OBJECT:C206(hl_modulos)
		End case 
		
		
	: (Form event:C388=On Selection Change:K2:29)
		MSG_GuardaRegistro 
		If ([xShell_MensajesAplicacion:244]ID:5>0)
			vl_tipoSeleccion:=[xShell_MensajesAplicacion:244]Tipo:6
		Else 
			vl_tipoSeleccion:=-1
		End if 
		IT_SetButtonState (vl_tipoSeleccion=0;->beliminaMensaje)
		IT_SetButtonState (vl_tipoSeleccion=1;->beliminaAccion)
		IT_SetButtonState (vl_tipoSeleccion=2;->beliminaComponente)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
	: (Form event:C388=On Unload:K2:2)
		
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 


