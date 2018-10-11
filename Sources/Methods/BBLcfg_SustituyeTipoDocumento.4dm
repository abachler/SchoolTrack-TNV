//%attributes = {}
  // BBLcfg_SustituyeTipoDocumento()
  // Por: Alberto Bachler: 22/11/13, 12:32:46
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_BarcodeRegistroConPrefijo;$b_regenerarCodigos)
C_LONGINT:C283($l_Error;$l_IdTipoDocumento_actual;$l_IdTipoDocumento_nuevo;$l_itemsBloqueados;$l_numeroDeItems;$l_opcionUsuario;$l_registros;$l_registrosBloqueados)
C_TEXT:C284($t_prefijoActual;$t_prefijoNuevo;$t_Textolog;$t_tipoDocumentoActual;$t_tipoDocumentoNuevo)

If (False:C215)
	C_LONGINT:C283(BBLcfg_SustituyeTipoDocumento ;$1)
	C_LONGINT:C283(BBLcfg_SustituyeTipoDocumento ;$2)
End if 

$l_IdTipoDocumento_actual:=$1
$l_IdTipoDocumento_nuevo:=$2

If ($l_IdTipoDocumento_actual#$l_IdTipoDocumento_nuevo)
	
	$t_prefijoActual:=<>asBBL_AbrevMedia{Find in array:C230(<>alBBL_IDMedia;$l_IdTipoDocumento_actual)}
	$t_prefijoNuevo:=<>asBBL_AbrevMedia{Find in array:C230(<>alBBL_IDMedia;$l_IdTipoDocumento_nuevo)}
	$t_tipoDocumentoActual:=<>atBBL_Media{Find in array:C230(<>alBBL_IDMedia;$l_IdTipoDocumento_actual)}
	$t_tipoDocumentoNuevo:=<>atBBL_Media{Find in array:C230(<>alBBL_IDMedia;$l_IdTipoDocumento_nuevo)}
	$l_numeroDeItems:=al_NumeroRegistrosMediaTrack{Find in array:C230(<>alBBL_IDMedia;$l_IdTipoDocumento_actual)}
	
	$l_registros:=0
	If ($t_prefijoActual#$t_prefijoNuevo)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
		QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=False:C215;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_SinFormato:26;=;$t_prefijoActual+"@")
		SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Structure configuration:K51:2;Structure configuration:K51:2)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_registros>0)
			  // inicio la transacción antes de mostrar el mensaje para evitar el registro en el log si la transacción debe
			  // ser cancelada debido a registros bloqueados en la selección resultante de la búsqueda.
			START TRANSACTION:C239
			
			  // Inicializo el componente IT_Confirmacion
			IT_Confirmacion_Inicializa 
			
			  //Cargo los elementos que se mostrarán en el mensaje de confirmación
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("146/_Encabezado"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("147/btn1_Cambiar_y_regenerarConNuevoPrefijo"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("149/btn2_Cambia_y_regenerarSinPrefijo"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("150/btn3_Cambiar_y_mantenerCodigo"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("148/btn4_Cancelar"))
			
			  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_numeroDeItems";String:C10($l_numeroDeItems))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registros";String:C10($l_registros))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_prefijoActual";$t_prefijoActual)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_prefijoNuevo";$t_prefijoNuevo)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_tipoDocumentoActual";$t_tipoDocumentoActual)
			
			  // Muestro el cuadro de diálogo de confirmación
			  // pasa en $t_textoLog el encabezado para el registro de actividades
			$t_Textolog:=__ ("Cambio de tipo de documento")
			$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
		Else 
			$t_titulo:=__ ("Usted solicitó sustituir el tipo de documento para un conjunto de registros")
			$t_mensaje:=__ ("¿Está seguro de querer sustituir el tipo de documento ^0 por ^1 en ^2 registros?")
			$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_tipoDocumentoActual;True:C214))
			$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_tipoDocumentoNuevo;True:C214))
			$t_numeroRegistros:=String:C10($l_numeroDeItems)
			$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_numeroRegistros))
			$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Aceptar");__ ("Cancelar"))
			If ($l_opcionUsuario=1)
				START TRANSACTION:C239
			Else 
				$l_opcionUsuario:=0
			End if 
		End if 
	Else 
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
		QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=False:C215;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_SinFormato:26;=;$t_prefijoActual+"@")
		SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Structure configuration:K51:2;Structure configuration:K51:2)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_registros>0)
			$t_titulo:="Usted solicitó sustituir el tipo de documento"
			$t_mensaje:=__ ("¿Está seguro de querer sustituir el tipo de documento ^0 por ^1 en ^2 registros?")
			$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_tipoDocumentoActual;True:C214))
			$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_tipoDocumentoNuevo;True:C214))
			$t_numeroRegistros:=String:C10($l_numeroDeItems)
			$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_numeroRegistros))
			$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Aceptar");__ ("Cancelar"))
			If ($l_opcionUsuario=1)
				START TRANSACTION:C239
			End if 
		End if 
	End if 
	
	
	
	
	If ($l_opcionUsuario=0)
		  //nada, operacion cancelada
		CANCEL TRANSACTION:C241
	Else 
		REDUCE SELECTION:C351([BBL_Registros:66];0)
		SET QUERY AND LOCK:C661(True:C214)
		QUERY:C277([BBL_Items:61];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual)
		$l_itemsBloqueados:=Records in set:C195("LockedSet")
		SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
		QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=False:C215;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_SinFormato:26;=;$t_prefijoActual+"@")
		$l_registrosBloqueados:=Records in set:C195("LockedSet")
		CREATE SET:C116([BBL_Registros:66];"$cambioBarcode")
		SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Structure configuration:K51:2;Structure configuration:K51:2)
		
		If (($l_registrosBloqueados+$l_itemsBloqueados)=0)
			BBLcfg_CambioMediaEnItems ($l_IdTipoDocumento_nuevo;$t_tipoDocumentoNuevo)
			If ($l_registros=0)
				VALIDATE TRANSACTION:C240
			Else 
				Case of 
					: ($l_opcionUsuario=1)
						$b_BarcodeRegistroConPrefijo:=<>bBBL_BarcodeRegistroConPrefijo
						<>bBBL_BarcodeRegistroConPrefijo:=True:C214
						USE SET:C118("$cambioBarcode")
						CLEAR SET:C117("$cambioBarcode")
						BBLreg_RegenerarCodigosDeBarra 
						<>bBBL_BarcodeRegistroConPrefijo:=$b_BarcodeRegistroConPrefijo
					: ($l_opcionUsuario=2)
						$b_BarcodeRegistroConPrefijo:=<>bBBL_BarcodeRegistroConPrefijo
						<>bBBL_BarcodeRegistroConPrefijo:=False:C215
						USE SET:C118("$cambioBarcode")
						CLEAR SET:C117("$cambioBarcode")
						BBLreg_RegenerarCodigosDeBarra 
						<>bBBL_BarcodeRegistroConPrefijo:=$b_BarcodeRegistroConPrefijo
				End case 
				VALIDATE TRANSACTION:C240
			End if 
		Else 
			CANCEL TRANSACTION:C241
			CD_Dlog (0;__ ("No es posible ejecutar esta operación en este momento.\rPor favor intente nuevamente más tarde."))
		End if 
		SET QUERY AND LOCK:C661(False:C215)
	End if 
	
	BBLcfg_Listbox_CodigosBarra 
End if 
