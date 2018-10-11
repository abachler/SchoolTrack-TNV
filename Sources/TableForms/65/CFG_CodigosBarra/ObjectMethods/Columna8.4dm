  // [xxBBL_Preferencias].CFG_CodigosBarra.Columna2()
  // Por: Alberto Bachler: 06/09/13, 18:29:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_regenerarCodigos;$b_protegerCodigos)
C_LONGINT:C283($el;$l_Error;$l_IdTipoDocumento_actual;$l_opcionUsuario;$l_registrosNoProtegidos;$l_registrosProtegidos;$l_textoLog;$l_totalRegistros)
C_TEXT:C284($t_mensaje;$t_prefijoActual;$t_prefijoNuevo;$t_RegistrosNoProtegidos;$t_RegistrosProtegidos;$t_Textolog;$t_tipoDocumentoActual;$t_totalRegistros)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		EDIT ITEM:C870(<>asBBL_AbrevMedia;<>atBBL_Media)
		
	: (Form event:C388=On Data Change:K2:15)
		$t_prefijoActual:=<>asBBL_AbrevMedia{0}
		$t_prefijoNuevo:=Replace string:C233(<>asBBL_AbrevMedia{<>asBBL_AbrevMedia};"_";"")
		
		If (Length:C16($t_prefijoNuevo)=3)
			$l_fila:=<>atBBL_Media
			If (al_NumeroRegistrosMediaTrack{<>atBBL_Media}>0)
				$l_IdTipoDocumento_actual:=<>alBBL_IDMedia{<>atBBL_Media}
				$t_tipoDocumentoActual:=<>atBBL_Media{<>atBBL_Media}
				$l_IdTipoDocumento_actual:=<>alBBL_IDMedia{<>atBBL_Media}
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosNoProtegidos)
				SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
				QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
				QUERY:C277([BBL_Registros:66]; & [BBL_Registros:66]Barcode_SinFormato:26=$t_prefijoActual+"@";*)
				QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=False:C215)
				
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosProtegidos)
				QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
				QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=True:C214)
				SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Structure configuration:K51:2;Structure configuration:K51:2)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				$l_totalRegistros:=$l_registrosNoProtegidos+$l_registrosProtegidos
				
				If ($l_totalRegistros>0)
					  // Inicializo el componente IT_Confirmacion
					IT_Confirmacion_Inicializa 
					
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					If (($l_registrosProtegidos>0) & ($l_registrosNoProtegidos>0))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("133/_EncabezadoConBarcodesProtegidos"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("136/btn3_CambiarPrefijo_y_mantenerBarcodes"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("134/btn2_CambiarPrefijo_y_RegenerarTodo"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("135/btn1_CambiarPrefijo_y_regenerar_noProtegidos"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("137/btn4_Cancelar"))
					Else 
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("162/_EncabezadoSinBarcodesProtegidos"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("136/btn3_CambiarPrefijo_y_mantenerBarcodes"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("134/btn2_CambiarPrefijo_y_RegenerarTodo"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("137/btn4_Cancelar"))
					End if 
					
					  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosProtegidos";String:C10($l_registrosProtegidos))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosNoProtegidos";String:C10($l_registrosNoProtegidos))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_totalRegistros";String:C10($l_totalRegistros))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_prefijoActual";$t_prefijoActual)
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_prefijoNuevo";$t_prefijoNuevo)
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_tipoDocumentoActual";$t_tipoDocumentoActual)
					
					
					  // inicio la transacción antes de mostrar el mensaje para evitar el registro en el log si la transacción debe
					  // ser cancelada debido a registros bloqueados en la selección resultante de la búsqueda.
					START TRANSACTION:C239
					
					  // Muestro el cuadro de diálogo de confirmación
					  // paso en $t_textoLog el encabezado para el registro de actividades
					$t_Textolog:=__ ("Modificación del prefijo para el tipo de documento ")+$t_tipoDocumentoActual
					$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
					
					If ($l_opcionUsuario=0)
						  // cancelar. se mantiene prefijo actual y no se genera ningún código de barra
						$b_regenerarCodigos:=False:C215
						<>asBBL_AbrevMedia{<>asBBL_AbrevMedia}:=$t_prefijoActual
						CANCEL TRANSACTION:C241
						
					Else 
						REDUCE SELECTION:C351([BBL_Registros:66];0)
						SET QUERY AND LOCK:C661(True:C214)
						Case of 
							: ($l_opcionUsuario=1)
								$b_protegerCodigos:=True:C214
								SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
								QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
								QUERY:C277([BBL_Registros:66]; & [BBL_Registros:66]Barcode_SinFormato:26=$t_prefijoActual+"@";*)
								QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=False:C215)
								SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
								
							: ($l_opcionUsuario=3)
								  // se regeneran los códigos de barra solo para los registros con codigos de barra no protegidos
								$b_regenerarCodigos:=True:C214
								SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
								QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual;*)
								QUERY:C277([BBL_Registros:66]; & [BBL_Registros:66]Barcode_SinFormato:26=$t_prefijoActual+"@";*)
								QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Barcode_Protegido:28=False:C215)
								SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
							: (($l_opcionUsuario=2))
								  // regenerar todos los códigos de barra del tipo de documento, sin importar si estan protegidos o no
								$b_regenerarCodigos:=True:C214
								SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
								QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48;=;$l_IdTipoDocumento_actual)
								SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
								
						End case 
					End if 
					
					If ((Records in set:C195("LockedSet")=0) & (Records in selection:C76([BBL_Registros:66])>0))
						Case of 
							: ($b_protegerCodigos)
								ARRAY BOOLEAN:C223($ab_protegerCodigos;Records in selection:C76([BBL_Registros:66]))
								AT_Populate (->$ab_protegerCodigos;->$b_protegerCodigos)
								KRL_Array2Selection (->$ab_protegerCodigos;->[BBL_Registros:66]Barcode_Protegido:28)
								
							: ($b_regenerarCodigos)
								BBLreg_RegenerarCodigosDeBarra 
								
						End case 
						VALIDATE TRANSACTION:C240
					Else 
						<>asBBL_AbrevMedia{<>asBBL_AbrevMedia}:=$t_prefijoActual
						CD_Dlog (0;__ ("No es posible ejecutar esta operación en este momento.\rPor favor intente nuevamente más tarde."))
						CANCEL TRANSACTION:C241
					End if 
					SET QUERY AND LOCK:C661(False:C215)
				End if 
			End if 
			BBLcfg_GuardaCambiosMedia 
			BBLcfg_Listbox_CodigosBarra 
			POST KEY:C465(Tab key:K12:28)
			GOTO OBJECT:C206(lb_TiposDocumentos)
			  //LISTBOX SELECT ROW(lb_TiposDocumentos;$l_fila;Replace listbox selection)
		Else 
			<>asBBL_AbrevMedia{<>asBBL_AbrevMedia}:=$t_prefijoActual
		End if 
	Else 
		POST KEY:C465(Tab key:K12:28)
		GOTO OBJECT:C206(lb_TiposDocumentos)
		LISTBOX SELECT ROW:C912(lb_TiposDocumentos;<>atBBL_Media;lk replace selection:K53:1)
		
End case 