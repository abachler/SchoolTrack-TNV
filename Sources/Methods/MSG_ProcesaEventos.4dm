//%attributes = {}
  // MSG_ProcesaEventos()
  // Por: Alberto Bachler: 25/03/13, 09:59:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_itemExiste;$b_mensajeEliminado)
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_filaSeleccionada;$l_IdNuevoMensaje;$l_index;$l_Indice;$l_refAccion;$l_refComponente;$l_refMensaje;$l_refModulo;$l_tamañoFuente)
C_TEXT:C284($t_Accion;$t_Componente;$t_evento;$t_Mensaje;$t_moduloSeleccionado;$t_nombreAnterior;$t_Nombrefuente;$t_nombreItem)

ARRAY LONGINT:C221($al_IdMensajes;0)
If (False:C215)
	C_TEXT:C284(MSG_ProcesaEventos ;$1)
End if 

$t_evento:=$1

GET LIST ITEM:C378(hl_modulos;Selected list items:C379(hl_modulos);$l_refModulo;$t_moduloSeleccionado)
GET LIST ITEM:C378(hl_Componentes;Selected list items:C379(hl_Componentes);$l_refComponente;$t_Componente)
GET LIST ITEM:C378(hl_Acciones;Selected list items:C379(hl_Acciones);$l_refAccion;$t_Accion)
GET LIST ITEM:C378(hl_Mensajes;Selected list items:C379(hl_Mensajes);$l_refMensaje;$t_Mensaje)

Case of 
	: ($t_evento="ListaComponentes")
		QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Modulo:1=$t_moduloSeleccionado;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Tipo:6=2)
		ORDER BY:C49([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Componente:2;>)
		hl_Componentes:=HL_Seleccion_a_ListaJerarquica (->[xShell_MensajesAplicacion:244]Componente:2;hl_Componentes)
		SELECT LIST ITEMS BY POSITION:C381(hl_Componentes;1)
		MSG_ProcesaEventos ("ListaAcciones")
		
	: ($t_evento="ListaAcciones")
		QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Modulo:1=$t_moduloSeleccionado;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Componente:2=$t_Componente;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Tipo:6=1)
		ORDER BY:C49([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Acción:3;>)
		hl_acciones:=HL_Seleccion_a_ListaJerarquica (->[xShell_MensajesAplicacion:244]Acción:3;hl_acciones)
		SELECT LIST ITEMS BY POSITION:C381(hl_acciones;1)
		MSG_ProcesaEventos ("ListaMensajes")
		
	: ($t_evento="ListaMensajes")
		QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Modulo:1=$t_moduloSeleccionado;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & [xShell_MensajesAplicacion:244]Componente:2=$t_Componente;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Acción:3=$t_accion;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Tipo:6=0)
		ORDER BY:C49([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Referencia:7;>)
		hl_Mensajes:=HL_Seleccion_a_ListaJerarquica (->[xShell_MensajesAplicacion:244]Referencia:7;hl_Mensajes)
		If (Count list items:C380(hl_mensajes)>0)
			SELECT LIST ITEMS BY POSITION:C381(hl_mensajes;1)
			MSG_ProcesaEventos ("cargaMensaje")
		Else 
			REDUCE SELECTION:C351([xShell_MensajesAplicacion:244];0)
		End if 
		
	: ($t_evento="NuevoComponente")
		$l_IdNuevoMensaje:=MSGws_SolicitaID 
		
		If ($l_IdNuevoMensaje<0)
			ALERT:C41("Error: No fue posible obtener un ID válido desde la Intranet.\r\rNo es posible agregar un componente en este momento")
			
		Else 
			$l_index:=0
			$t_nombreItem:="Componente"+String:C10($l_index)
			$b_itemExiste:=False:C215
			Repeat 
				$l_index:=$l_index+1
				$t_nombreItem:="Componente"+String:C10($l_index)
				$b_itemExiste:=(Find in list:C952(hl_componentes;$t_nombreItem;0)>0)
			Until ($b_itemExiste=False:C215)
			
			CREATE RECORD:C68([xShell_MensajesAplicacion:244])
			[xShell_MensajesAplicacion:244]ID:5:=$l_IdNuevoMensaje
			[xShell_MensajesAplicacion:244]Modulo:1:=$t_moduloSeleccionado
			[xShell_MensajesAplicacion:244]Tipo:6:=2
			[xShell_MensajesAplicacion:244]Componente:2:=$t_nombreItem
			MSG_GuardaRegistro 
			vlMSG_ultimoId:=$l_IdNuevoMensaje
			
			$l_refComponente:=Record number:C243([xShell_MensajesAplicacion:244])
			APPEND TO LIST:C376(hl_componentes;$t_nombreItem;$l_refComponente)
			
			SORT LIST:C391(hl_componentes)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_componentes;$l_refComponente)
			$l_filaSeleccionada:=Selected list items:C379(hl_componentes)
			OBJECT SET SCROLL POSITION:C906(hl_acciones;$l_filaSeleccionada)
			EDIT ITEM:C870(hl_componentes;$l_filaSeleccionada)
		End if 
		
	: ($t_evento="EliminaComponente")
		If ($l_refComponente>=0)
			$l_filaSeleccionada:=Selected list items:C379(hl_componentes)
			QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Modulo:1=$t_moduloSeleccionado;*)
			QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Componente:2=$t_Componente)
			SELECTION TO ARRAY:C260([xShell_MensajesAplicacion:244]ID:5;$al_IdMensajes)
			For ($i_registros;1;Size of array:C274($al_IdMensajes))
				$b_mensajeEliminado:=MSG_EliminaEnIntranet ($al_IdMensajes{$i_registros})
				If (Not:C34($b_mensajeEliminado))
					$i_registros:=Size of array:C274($al_IdMensajes)
				End if 
			End for 
			If ($b_mensajeEliminado)
				KRL_DeleteSelection (->[xShell_MensajesAplicacion:244])
				DELETE FROM LIST:C624(hl_componentes;*)
				Case of 
					: ($l_filaSeleccionada<=Count list items:C380(hl_componentes))
						SELECT LIST ITEMS BY POSITION:C381(hl_componentes;$l_filaSeleccionada)
					: (Count list items:C380(hl_componentes)>0)
						SELECT LIST ITEMS BY POSITION:C381(hl_componentes;$l_filaSeleccionada-1)
					Else 
						SELECT LIST ITEMS BY POSITION:C381(hl_componentes;0)
				End case 
				MSG_ProcesaEventos ("ListaAcciones")
			Else 
				ALERT:C41("Error: Problema de comunicación con la Intranet.\r\rEl componente no puede ser eliminado en este momento.")
			End if 
		End if 
		
	: ($t_evento="NuevaAccion")
		$l_IdNuevoMensaje:=MSGws_SolicitaID 
		
		If ($l_IdNuevoMensaje<0)
			ALERT:C41("Error: No fue posible obtener un ID válido desde la Intranet.\r\rNo es posible agregar una acción en este momento")
			
		Else 
			$l_index:=0
			$t_nombreItem:="Accion"+String:C10($l_index)
			$b_itemExiste:=False:C215
			Repeat 
				$l_index:=$l_index+1
				$t_nombreItem:="Accion"+String:C10($l_index)
				$b_itemExiste:=(Find in list:C952(hl_Acciones;$t_nombreItem;0)>0)
			Until ($b_itemExiste=False:C215)
			
			CREATE RECORD:C68([xShell_MensajesAplicacion:244])
			[xShell_MensajesAplicacion:244]ID:5:=$l_IdNuevoMensaje
			[xShell_MensajesAplicacion:244]Modulo:1:=$t_moduloSeleccionado
			[xShell_MensajesAplicacion:244]Componente:2:=$t_Componente
			[xShell_MensajesAplicacion:244]Tipo:6:=1
			[xShell_MensajesAplicacion:244]Acción:3:=$t_nombreItem
			MSG_GuardaRegistro 
			vlMSG_ultimoId:=$l_IdNuevoMensaje
			
			$l_refAccion:=Record number:C243([xShell_MensajesAplicacion:244])
			APPEND TO LIST:C376(hl_Acciones;$t_nombreItem;$l_refAccion)
			
			SORT LIST:C391(hl_Acciones)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_Acciones;$l_refAccion)
			$l_filaSeleccionada:=Selected list items:C379(hl_Acciones)
			OBJECT SET SCROLL POSITION:C906(hl_acciones;$l_filaSeleccionada)
			EDIT ITEM:C870(hl_acciones;$l_filaSeleccionada)
		End if 
		
	: ($t_evento="EliminaAccion")
		If ($l_refAccion>=0)
			$l_filaSeleccionada:=Selected list items:C379(hl_Acciones)
			QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Modulo:1=$t_moduloSeleccionado;*)
			QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Componente:2=$t_Componente;*)
			QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Acción:3=$t_accion)
			SELECTION TO ARRAY:C260([xShell_MensajesAplicacion:244]ID:5;$al_IdMensajes)
			For ($i_registros;1;Size of array:C274($al_IdMensajes))
				$b_mensajeEliminado:=MSG_EliminaEnIntranet ($al_IdMensajes{$i_registros})
				If (Not:C34($b_mensajeEliminado))
					$i_registros:=Size of array:C274($al_IdMensajes)
				End if 
			End for 
			If ($b_mensajeEliminado)
				KRL_DeleteSelection (->[xShell_MensajesAplicacion:244])
				DELETE FROM LIST:C624(hl_Acciones;*)
				Case of 
					: ($l_filaSeleccionada<=Count list items:C380(hl_Acciones))
						SELECT LIST ITEMS BY POSITION:C381(hl_Acciones;$l_filaSeleccionada)
					: (Count list items:C380(hl_Acciones)>0)
						SELECT LIST ITEMS BY POSITION:C381(hl_Acciones;$l_filaSeleccionada-1)
					Else 
						SELECT LIST ITEMS BY POSITION:C381(hl_Acciones;0)
				End case 
				MSG_ProcesaEventos ("ListaAcciones")
			Else 
				ALERT:C41("Error: Problema de comunicación con la Intranet.\r\rLa acción no puede ser eliminada en este momento.")
			End if 
		End if 
		
	: ($t_evento="NuevoMensaje")
		$l_IdNuevoMensaje:=MSGws_SolicitaID 
		If ($l_IdNuevoMensaje<0)
			ALERT:C41("Error: No fue posible obtener un ID válido desde la Intranet.\r\rNo es posible agregar un mensaje en este momento")
		Else 
			$l_index:=0
			$t_nombreItem:="Mensaje"+String:C10($l_index)
			$b_itemExiste:=False:C215
			Repeat 
				$l_index:=$l_index+1
				$t_nombreItem:="Mensaje"+String:C10($l_index)
				$b_itemExiste:=(Find in list:C952(hl_Mensajes;$t_nombreItem;0)>0)
			Until ($b_itemExiste=False:C215)
			CREATE RECORD:C68([xShell_MensajesAplicacion:244])
			[xShell_MensajesAplicacion:244]ID:5:=$l_IdNuevoMensaje
			[xShell_MensajesAplicacion:244]Modulo:1:=$t_moduloSeleccionado
			[xShell_MensajesAplicacion:244]Componente:2:=$t_Componente
			[xShell_MensajesAplicacion:244]Acción:3:=$t_Accion
			[xShell_MensajesAplicacion:244]Tipo:6:=0
			[xShell_MensajesAplicacion:244]Referencia:7:=$t_nombreItem
			MSG_GuardaRegistro 
			vlMSG_ultimoId:=$l_IdNuevoMensaje
			
			$l_refMensaje:=Record number:C243([xShell_MensajesAplicacion:244])
			APPEND TO LIST:C376(hl_Mensajes;$t_nombreItem;$l_refMensaje)
			
			SORT LIST:C391(hl_Mensajes)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_Mensajes;$l_refMensaje)
			$l_filaSeleccionada:=Selected list items:C379(hl_Mensajes)
			OBJECT SET SCROLL POSITION:C906(hl_Mensajes;$l_filaSeleccionada)
			EDIT ITEM:C870(hl_Mensajes;$l_filaSeleccionada)
		End if 
		
	: ($t_evento="EliminaMensaje")
		If ($l_refMensaje>=0)
			$l_filaSeleccionada:=Selected list items:C379(hl_Mensajes)
			$b_mensajeEliminado:=MSG_EliminaEnIntranet ([xShell_MensajesAplicacion:244]ID:5)
			If ($b_mensajeEliminado)
				KRL_DeleteRecord (->[xShell_MensajesAplicacion:244])
				DELETE FROM LIST:C624(hl_Mensajes;*)
				_O_REDRAW LIST:C382(hl_Mensajes)
				Case of 
					: ($l_filaSeleccionada<=Count list items:C380(hl_Mensajes))
						SELECT LIST ITEMS BY POSITION:C381(hl_Mensajes;$l_filaSeleccionada)
					: (Count list items:C380(hl_Mensajes)>0)
						SELECT LIST ITEMS BY POSITION:C381(hl_Mensajes;$l_filaSeleccionada-1)
					Else 
						SELECT LIST ITEMS BY POSITION:C381(hl_Mensajes;0)
				End case 
			Else 
				ALERT:C41("Error: Problema de comunicación con la Intranet.\r\rEl mensaje no puede ser eliminado en este momento.")
			End if 
		End if 
		
	: ($t_evento="CargaMensaje")
		If ($l_refMensaje>=0)
			$t_Nombrefuente:=OBJECT Get font:C1069([xShell_MensajesAplicacion:244]Mensaje:4)
			$l_tamañoFuente:=OBJECT Get font size:C1070([xShell_MensajesAplicacion:244]Mensaje:4)
			$l_Indice:=Find in array:C230(at_Fonts;$t_nombreFuente)
			If ($l_indice>0)
				at_Fonts:=$l_Indice
			End if 
			$l_Indice:=Find in array:C230(al_FontSizes;$l_tamañoFuente)
			If ($l_Indice<0)
				APPEND TO ARRAY:C911(al_FontSizes;$l_tamañoFuente)
				SORT ARRAY:C229(al_FontSizes;>)
			End if 
			al_FontSizes:=Find in array:C230(al_FontSizes;$l_tamañoFuente)
			
			KRL_GotoRecord (->[xShell_MensajesAplicacion:244];$l_refMensaje;True:C214)
			vt_textoConTags:=[xShell_MensajesAplicacion:244]Mensaje:4
			<>vt_Confirmacion_Codigo:=String:C10([xShell_MensajesAplicacion:244]ID:5)+"/"+[xShell_MensajesAplicacion:244]Referencia:7
			<>vt_Confirmacion_Codigo:="$l_error:=IT_Confirmacion_AgregaElemento(MSG_TextoMensaje(\""+<>vt_Confirmacion_Codigo+"\"))"
			
		End if 
		
	: ($t_evento="EdicionComponente")
		$l_refMensaje:=Record number:C243([xShell_MensajesAplicacion:244])
		KRL_GotoRecord (->[xShell_MensajesAplicacion:244];$l_refComponente;True:C214)
		$t_nombreAnterior:=[xShell_MensajesAplicacion:244]Componente:2
		[xShell_MensajesAplicacion:244]Componente:2:=$t_Componente
		MSG_GuardaRegistro 
		QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Modulo:1=$t_moduloSeleccionado;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Componente:2=$t_nombreAnterior)
		READ WRITE:C146([xShell_MensajesAplicacion:244])
		APPLY TO SELECTION:C70([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Componente:2:=$t_Componente)
		If ($l_refMensaje>=0)
			KRL_GotoRecord (->[xShell_MensajesAplicacion:244];$l_refMensaje;True:C214)
		End if 
		
	: ($t_evento="EdicionAccion")
		vl_refMensaje:=Record number:C243([xShell_MensajesAplicacion:244])
		KRL_GotoRecord (->[xShell_MensajesAplicacion:244];$l_refAccion;True:C214)
		$t_nombreAnterior:=[xShell_MensajesAplicacion:244]Acción:3
		[xShell_MensajesAplicacion:244]Acción:3:=$t_accion
		MSG_GuardaRegistro 
		QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Modulo:1=$t_moduloSeleccionado;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Componente:2=$t_componente;*)
		QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Acción:3=$t_nombreAnterior)
		READ WRITE:C146([xShell_MensajesAplicacion:244])
		APPLY TO SELECTION:C70([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Acción:3:=$t_Accion)
		If (vl_refMensaje>=0)
			KRL_GotoRecord (->[xShell_MensajesAplicacion:244];vl_refMensaje;True:C214)
		End if 
		
	: ($t_evento="EdicionMensaje")
		[xShell_MensajesAplicacion:244]Referencia:7:=Replace string:C233($t_mensaje;" ";"")
		MSG_GuardaRegistro 
		
End case 
