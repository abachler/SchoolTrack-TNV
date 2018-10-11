//%attributes = {}
  // BBLcfg_AccionesTipoDocumentos()
  // Por: Alberto Bachler: 20/11/13, 18:14:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305($b_regenerarCodigos)
_O_C_INTEGER:C282($i_TiposDocumento;$i_registros)
C_LONGINT:C283($l_Error;$l_filaSeleccionada;$l_IDProgreso;$l_IdTipoDocumento_actual;$l_IdTipoDocumento_nuevo;$l_items;$l_itemsBloqueados;$l_itemSeleccionado;$l_OK;$l_opcionUsuario)
C_LONGINT:C283($l_posicion;$l_proximoID;$l_registros;$l_registrosBloqueados;$l_registrosNoProtegidos;$l_registrosProtegidos;$l_totalRegistros;$l_ultimoIDMediaEnConfig;$l_ultimoIDMediaEnRegistros)
C_TEXT:C284($t_item;$t_mensaje;$t_mensajeAviso;$t_mensajeProgreso;$t_numeroDeItems;$t_numeroDeRegistros;$t_prefijoActual;$t_Textolog;$t_tipoDocumentoActual;$t_tipoDocumentoNuevo)

ARRAY LONGINT:C221($al_IdMediaEnConfig;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_itemsPopup;0)

APPEND TO ARRAY:C911($at_itemsPopup;__ ("Añadir Tipo de documento"))
APPEND TO ARRAY:C911($at_itemsPopup;"(-")
APPEND TO ARRAY:C911($at_itemsPopup;__ ("Establecer como tipo de documento por defecto"))
APPEND TO ARRAY:C911($at_itemsPopup;"(-")

$l_filaSeleccionada:=LB_GetSelectedRows (->lb_TiposDocumentos)
If ($l_filaSeleccionada>0)
	$l_items:=al_NumeroRegistrosMediaTrack{$l_filaSeleccionada}
End if 
If ($l_filaSeleccionada<0)
	APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Eliminar"))
	APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	If (AT_GetSumArray (->al_NumeroRegistrosMediaTrack)>0)
		APPEND TO ARRAY:C911($at_itemsPopup;__ ("Generar códigos de barra para todos los documentos..."))
	Else 
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Generar códigos de barra para todos los documentos..."))
	End if 
	APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Generar códigos de barra para documentos..."))
	APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Cambiar tipo de documento a..."))
	For ($i_TiposDocumento;1;Size of array:C274(<>atBBL_Media))
		APPEND TO ARRAY:C911($at_itemsPopup;"(  "+<>atBBL_Media{$i_TiposDocumento})
	End for 
Else 
	Case of 
		: (<>alBBL_IDMedia{$l_filaSeleccionada}=<>vlBBL_MediaPorDefecto)
			APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Eliminar"))
			
			  //: (<>alBBL_IDMedia{$l_filaSeleccionada}<0)
			  //APPEND TO ARRAY($at_itemsPopup;"("+__ ("Eliminar"))
		: ($l_items>0)
			APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Eliminar"))
		Else 
			APPEND TO ARRAY:C911($at_itemsPopup;__ ("Eliminar"))
	End case 
	APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	If (AT_GetSumArray (->al_NumeroRegistrosMediaTrack)>0)
		APPEND TO ARRAY:C911($at_itemsPopup;__ ("Generar códigos de barra para todos los documentos..."))
	Else 
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Generar códigos de barra para todos los documentos..."))
	End if 
	If ($l_items>0)
		$t_item:=__ ("Generar códigos de barra para documentos \"^0\"...")
		$t_item:=Replace string:C233($t_item;"^0";<>atBBL_Media{<>atBBL_Media})
		APPEND TO ARRAY:C911($at_itemsPopup;$t_item)
		APPEND TO ARRAY:C911($at_itemsPopup;"(-")
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Cambiar tipo de documento a..."))
		For ($i_TiposDocumento;1;Size of array:C274(<>atBBL_Media))
			APPEND TO ARRAY:C911($at_itemsPopup;"  "+<>atBBL_Media{$i_TiposDocumento})
		End for 
	Else 
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Generar códigos de barra para documentos..."))
		APPEND TO ARRAY:C911($at_itemsPopup;"(-")
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Cambiar tipo de documento a..."))
		For ($i_TiposDocumento;1;Size of array:C274(<>atBBL_Media))
			APPEND TO ARRAY:C911($at_itemsPopup;"(  "+<>atBBL_Media{$i_TiposDocumento})
		End for 
	End if 
End if 

$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_itemsPopup)
Case of 
	: ($l_itemSeleccionado=1)  //nuevo
		BBLcfg_NuevoTipoDocumento 
		BBLcfg_Listbox_CodigosBarra 
		LISTBOX SORT COLUMNS:C916(lb_TiposDocumentos;1;>)
		$l_posicion:=Find in array:C230(<>alBBL_IDMedia;$l_proximoID)
		LISTBOX SELECT ROW:C912(lb_TiposDocumentos;$l_posicion)
		OBJECT SET SCROLL POSITION:C906(lb_TiposDocumentos;$l_posicion)
		EDIT ITEM:C870(<>atBBL_Media;$l_posicion)
		
	: ($l_itemSeleccionado=3)
		<>vlBBL_MediaPorDefecto:=<>alBBL_IDMedia{<>atBBL_Media}
		BBLcfg_GuardaCambiosMedia 
		BBLcfg_Listbox_CodigosBarra 
		
	: ($l_itemSeleccionado=5)  // eliminar
		AT_Delete ($l_filaSeleccionada;1;-><>atBBL_Media;-><>asBBL_AbrevMedia;->al_NumeroRegistrosMediaTrack;-><>alBBL_IDMedia)
		BBLcfg_GuardaCambiosMedia 
		BBLcfg_Listbox_CodigosBarra 
		
	: ($l_itemSeleccionado=7)  // Generar códigos de barra para todos los documentos
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosNoProtegidos)
		SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_Protegido:28=False:C215)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosProtegidos)
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_Protegido:28=True:C214)
		SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Structure configuration:K51:2;Structure configuration:K51:2)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$l_totalRegistros:=$l_registrosNoProtegidos+$l_registrosProtegidos
		
		
		  // inicio la transacción antes de mostrar el mensaje para evitar el registro en el log si la transacción debe
		  // ser cancelada debido a registros bloqueados en la selección resultante de la búsqueda.
		START TRANSACTION:C239
		  // Inicializo el componente IT_Confirmacion
		IT_Confirmacion_Inicializa 
		
		  //Cargo los elementos que se mostrarán en el mensaje de confirmación
		Case of 
			: (($l_registrosNoProtegidos>0) & ($l_registrosProtegidos>0))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("156/_Encabezado_con_codigosProtegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("160/btn1_TodosLosCodigos_estandar_y_protegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("158/btn2_SoloCodigos_NO_Protegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("159/btn3_SoloCodigos_Protegidos"))
				
			: ($l_registrosProtegidos>0)
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("156/_Encabezado_con_codigosProtegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("166/btn1_TodosLosCodigos_protegidos"))
				
			: ($l_registrosProtegidos=0)
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("164/_Encabezado_sincodigosProtegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("165/btn1_TodosLosCodigos_estandar"))
				
		End case 
		IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("161/btn4_Cancelar"))
		
		  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosNoProtegidos";String:C10($l_registrosNoProtegidos))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosProtegidos";String:C10($l_registrosProtegidos))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_totalRegistros";String:C10($l_totalRegistros))
		
		  // Muestro el cuadro de diálogo de confirmación
		  // pasa en $t_textoLog el encabezado para el registro de actividades
		$t_Textolog:=__ ("Regeneración de todos los códigos de barra.")
		$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
		
		If ($l_opcionUsuario=0)
			  //nada, operacion cancelada
			CANCEL TRANSACTION:C241
		Else 
			
			SET QUERY AND LOCK:C661(True:C214)
			Case of 
				: ($l_opcionUsuario=1)  // regenerar códigos para todos los registros
					QUERY:C277([BBL_Registros:66];[BBL_Registros:66]ID:3;>;0)
					
				: ($l_opcionUsuario=2)  // regenerar codigos solo para códigos de barra estándar
					QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_Protegido:28=False:C215)
					
				: ($l_opcionUsuario=3)  // regenerar códigos solo para códigos de barra personalizados
					QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_Protegido:28=True:C214)
					
			End case 
			
			If ((Records in set:C195("LockedSet")=0) & (Records in selection:C76([BBL_Registros:66])>0))
				BBLreg_RegenerarCodigosDeBarra 
				VALIDATE TRANSACTION:C240
			Else 
				CD_Dlog (0;__ ("No es posible ejecutar esta operación en este momento.\rPor favor intente nuevamente más tarde."))
				CANCEL TRANSACTION:C241
			End if 
			SET QUERY AND LOCK:C661(False:C215)
			
		End if 
		
		
		
	: ($l_itemSeleccionado=8)  // generar códigos de barra para el tipo de documento seleccionado
		If (al_NumeroRegistrosMediaTrack{<>atBBL_Media}>0)
			$t_tipoDocumentoActual:=<>atBBL_Media{<>atBBL_Media}
			$l_IdTipoDocumento_actual:=<>alBBL_IDMedia{<>atBBL_Media}
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosNoProtegidos)
			SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
			QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
			QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=False:C215)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosProtegidos)
			QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
			QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=True:C214)
			SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Structure configuration:K51:2;Structure configuration:K51:2)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$l_totalRegistros:=$l_registrosNoProtegidos+$l_registrosProtegidos
			
			  // Inicializo el componente IT_Confirmacion
			IT_Confirmacion_Inicializa 
			
			  //Cargo los elementos que se mostrarán en el mensaje de confirmación
			If (($l_registrosProtegidos>0) & ($l_registrosNoProtegidos>0))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("141/_encabezadoConCódigoPersonalizado"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("144/btn1_Regenerar_Todos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("143/btn2_Regenerar_Solo_NO_personalizados"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("142/btn0_Cancelar"))
			Else 
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("140/_encabezadoSinCodigoPersonalizado"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("144/btn1_Regenerar_Todos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("142/btn0_Cancelar"))
			End if 
			
			  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosProtegidos";String:C10($l_registrosProtegidos))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosNoProtegidos";String:C10($l_registrosNoProtegidos))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_totalRegistros";String:C10($l_totalRegistros))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_tipoDocumentoActual";$t_tipoDocumentoActual)
			
			  // pasa en $t_textoLog el encabezado para el registro de actividades
			
			  // inicio la transacción antes de mostrar el mensaje para evitar el registro en el log si la transacción debe
			  // ser cancelada debido a registros bloqueados en la selección resultante de la búsqueda.
			START TRANSACTION:C239
			  // Muestro el cuadro de diálogo de confirmación y paso en $t_textoLog el encabezado para el registro de actividades
			$t_Textolog:=__ ("Regeneración de códigos de barra para documentos de tipo ")+$t_tipoDocumentoActual
			$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
			
			If ($l_opcionUsuario=0)
				  //nada, operacion cancelada
				CANCEL TRANSACTION:C241
			Else 
				
				SET QUERY AND LOCK:C661(True:C214)
				SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
				Case of 
					: ($l_opcionUsuario=1)
						QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual)
						
					: ($l_opcionUsuario=2)
						QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
						QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=False:C215)
				End case 
				SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Structure configuration:K51:2;Structure configuration:K51:2)
				If ((Records in set:C195("LockedSet")=0) & (Records in selection:C76([BBL_Registros:66])>0))
					BBLreg_RegenerarCodigosDeBarra 
					VALIDATE TRANSACTION:C240
				Else 
					CD_Dlog (0;__ ("No es posible ejecutar esta operación en este momento.\rPor favor intente nuevamente más tarde."))
					CANCEL TRANSACTION:C241
				End if 
				SET QUERY AND LOCK:C661(False:C215)
				
			End if 
		End if 
		
		
		
	: ($l_itemSeleccionado>10)
		$l_filaOrigen:=<>atBBL_Media
		$l_filaDestino:=$l_itemSeleccionado-10
		$l_tipoDocumentoActual:=<>alBBL_IDMedia{$l_filaOrigen}
		$l_tipoDocumentoReemplazo:=<>alBBL_IDMedia{$l_filaDestino}
		BBLcfg_SustituyeTipoDocumento ($l_tipoDocumentoActual;$l_tipoDocumentoReemplazo)
End case 



