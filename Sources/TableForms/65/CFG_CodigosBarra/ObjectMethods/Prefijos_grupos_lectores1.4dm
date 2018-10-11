  // [xxBBL_Preferencias].CFG_CodigosBarra.Prefijos_grupos_lectores()
  // Por: Alberto Bachler: 14/09/13, 18:09:03
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305($b_regenerarCodigos;$b_protegerCodigos)
C_LONGINT:C283($el;$l_Error;$l_IdGrupo_actual;$l_opcionUsuario;$l_LectoresNoProtegidos;$l_LectoresProtegidos;$l_textoLog;$l_totalLectores)
C_TEXT:C284($t_mensaje;$t_prefijoActual;$t_prefijoNuevo;$t_LectoresNoProtegidos;$t_LectoresProtegidos;$t_Textolog;$t_nombreGrupoActual;$t_totalLectores)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		EDIT ITEM:C870(<>asBBL_AbrevGruposLectores;<>asBBL_AbrevGruposLectores)
		
	: (Form event:C388=On Data Change:K2:15)
		$t_prefijoActual:=<>asBBL_AbrevGruposLectores{0}
		$t_prefijoNuevo:=Replace string:C233(<>asBBL_AbrevGruposLectores{<>asBBL_AbrevGruposLectores};"_";"")
		
		If (Length:C16($t_prefijoNuevo)=3)
			If (al_NumeroLectoresMediaTrack{<>atBBL_GruposLectores}>0)
				$l_IdGrupo_actual:=<>alBBL_GruposLectores{<>atBBL_GruposLectores}
				$t_nombreGrupoActual:=<>atBBL_GruposLectores{<>atBBL_GruposLectores}
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_LectoresNoProtegidos)
				QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_IdGrupo_actual;*)
				QUERY:C277([BBL_Lectores:72]; & [BBL_Lectores:72]BarCode_SinFormato:38=$t_prefijoActual+"@";*)
				QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
				
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_LectoresProtegidos)
				QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_IdGrupo_actual;*)
				QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				$l_totalLectores:=$l_LectoresNoProtegidos+$l_LectoresProtegidos
				
				If ($l_totalLectores>0)
					  // inicio la transacción antes de mostrar el mensaje para evitar el registro en el log si la transacción debe
					  // ser cancelada debido a Lectores bloqueados en la selección resultante de la búsqueda.
					START TRANSACTION:C239
					
					  // Inicializo el componente IT_Confirmacion
					IT_Confirmacion_Inicializa 
					
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					  //Cargo los elementos que se mostrarán en el mensaje de confirmación
					If (($l_LectoresProtegidos>0) & ($l_LectoresNoProtegidos>0))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("193/_EncabezadoConBarcodesProtegidos"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("197/btn3_CambiarPrefijo_y_mantenerBarcodes"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("196/btn2_CambiarPrefijo_y_RegenerarTodo"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("195/btn1_CambiarPrefijo_y_regenerar_noProtegidos"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("198/btn4_Cancelar"))
					Else 
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("194/_EncabezadoSinBarcodeProtegidos"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("197/btn3_CambiarPrefijo_y_mantenerBarcodes"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("196/btn2_CambiarPrefijo_y_RegenerarTodo"))
						IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("198/btn4_Cancelar"))
					End if 
					
					
					  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_LectoresNoProtegidos";String:C10($l_LectoresNoProtegidos))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_LectoresProtegidos";String:C10($l_LectoresProtegidos))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_totalLectores";String:C10($l_totalLectores))
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_nombreGrupoActual";$t_nombreGrupoActual)
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_prefijoActual";$t_prefijoActual)
					$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_prefijoNuevo";$t_prefijoNuevo)
					
					  // Muestro el cuadro de diálogo de confirmación
					  // pasa en $t_textoLog el encabezado para el registro de actividades
					$t_Textolog:=__ ("Modificación del prefijo del grupo de lectores ")+$t_nombreGrupoActual
					$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
					
					
					If ($l_opcionUsuario=0)
						  // cancelar. se mantiene prefijo actual y no se genera ningún código de barra
						$b_regenerarCodigos:=False:C215
						<>asBBL_AbrevGruposLectores{<>asBBL_AbrevGruposLectores}:=$t_prefijoActual
						CANCEL TRANSACTION:C241
						
					Else 
						REDUCE SELECTION:C351([BBL_Lectores:72];0)
						SET QUERY AND LOCK:C661(True:C214)
						Case of 
							: ($l_opcionUsuario=1)
								$b_protegerCodigos:=True:C214
								QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_IdGrupo_actual;*)
								QUERY:C277([BBL_Lectores:72]; & [BBL_Lectores:72]BarCode_SinFormato:38=$t_prefijoActual+"@";*)
								QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
								
							: ($l_opcionUsuario=3)
								  // se regeneran los códigos de barra solo para los Lectores con codigos de barra no protegidos
								$b_regenerarCodigos:=True:C214
								QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_IdGrupo_actual;*)
								QUERY:C277([BBL_Lectores:72]; & [BBL_Lectores:72]BarCode_SinFormato:38=$t_prefijoActual+"@";*)
								QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
								
							: (($l_opcionUsuario=2))
								  // regenerar todos los códigos de barra del tipo de documento, sin importar si estan protegidos o no
								$b_regenerarCodigos:=True:C214
								QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_IdGrupo_actual)
								
						End case 
					End if 
					
					If (Records in set:C195("LockedSet")=0)
						Case of 
							: (($b_protegerCodigos) & (Records in selection:C76([BBL_Lectores:72])>0))
								ARRAY BOOLEAN:C223($ab_protegerCodigos;Records in selection:C76([BBL_Lectores:72]))
								AT_Populate (->$ab_protegerCodigos;->$b_protegerCodigos)
								KRL_Array2Selection (->$ab_protegerCodigos;->[BBL_Lectores:72]Barcode_Protegido:39)
								
							: (($b_regenerarCodigos) & (Records in selection:C76([BBL_Lectores:72])>0))
								BBLpat_RegenerarCodigosDeBarra 
						End case 
						VALIDATE TRANSACTION:C240
					Else 
						<>asBBL_AbrevGruposLectores{<>asBBL_AbrevGruposLectores}:=$t_prefijoActual
						CD_Dlog (0;__ ("No es posible ejecutar esta operación en este momento.\rPor favor intente nuevamente más tarde."))
						CANCEL TRANSACTION:C241
					End if 
					SET QUERY AND LOCK:C661(False:C215)
				End if 
			End if 
			BBLcfg_GuardaCambiosGruposLect 
			BBLcfg_Listbox_CodigosBarra 
			POST KEY:C465(Tab key:K12:28)
			GOTO OBJECT:C206(lb_GruposLectores)
			LISTBOX SELECT ROW:C912(lb_GruposLectores;<>atBBL_GruposLectores;lk replace selection:K53:1)
		Else 
			<>asBBL_AbrevGruposLectores{<>asBBL_AbrevGruposLectores}:=$t_prefijoActual
		End if 
	Else 
		POST KEY:C465(Tab key:K12:28)
		GOTO OBJECT:C206(lb_GruposLectores)
		LISTBOX SELECT ROW:C912(lb_GruposLectores;<>atBBL_GruposLectores;lk replace selection:K53:1)
End case 



