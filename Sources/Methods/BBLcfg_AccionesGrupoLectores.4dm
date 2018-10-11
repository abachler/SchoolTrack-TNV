//%attributes = {}
  // BBLcfg_AccionesGrupoLectores()
  // Por: Alberto Bachler: 20/11/13, 18:29:01
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305($b_regenerarCodigos)
_O_C_INTEGER:C282($i_TiposDocumento;$i_registros)
C_LONGINT:C283($l_Error;$l_filaSeleccionada;$l_IDProgreso;$l_idGrupoActual;$l_IdGrupoLectores_nuevo;$l_lectores;$l_lectoresBloqueados;$l_opcionUsuario;$l_OK;$l_opcionUsuario)
C_LONGINT:C283($l_posicion;$l_proximoID;$l_registros;$l_registrosBloqueados;$l_registrosNoProtegidos;$l_registrosProtegidos;$l_totalRegistros;$l_ultimoIDGrupoEnConfig;$l_ultimoIDGrupoEnLectores)
C_TEXT:C284($t_item;$t_mensaje;$t_mensajeAviso;$t_mensajeProgreso;$t_numeroDeItems;$t_numeroDeRegistros;$t_prefijoActual;$t_Textolog;$t_nombreGrupoActual;$t_grupoLectoresNuevo)

ARRAY LONGINT:C221($al_IdGrupoEnConfig;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_itemsPopup;0)

APPEND TO ARRAY:C911($at_itemsPopup;"Añadir Grupo de lectores")
APPEND TO ARRAY:C911($at_itemsPopup;"(-")


$l_filaSeleccionada:=LB_GetSelectedRows (->lb_GruposLectores)
If ($l_filaSeleccionada>0)
	$l_lectores:=al_NumeroLectoresMediaTrack{$l_filaSeleccionada}
End if 
If ($l_filaSeleccionada<0)
	APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Eliminar"))
	APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Establecer como grupo de lectores por defecto"))
	APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	If (AT_GetSumArray (->al_NumeroLectoresMediaTrack)>0)
		APPEND TO ARRAY:C911($at_itemsPopup;__ ("Generar códigos de barra para todos los grupos..."))
	Else 
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Generar códigos de barra para todos los grupos..."))
	End if 
	APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Generar códigos de barra para grupo..."))
	APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Cambiar grupo de lectores por ..."))
	For ($i_TiposDocumento;1;Size of array:C274(<>atBBL_GruposLectores))
		APPEND TO ARRAY:C911($at_itemsPopup;"(  "+<>atBBL_GruposLectores{$i_TiposDocumento})
	End for 
Else 
	
	If ((<>alBBL_GruposLectores{$l_filaSeleccionada}=-5) | (<>alBBL_GruposLectores{$l_filaSeleccionada}>0))
		APPEND TO ARRAY:C911($at_itemsPopup;__ ("Establecer como grupo de lectores por defecto"))
		APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	Else 
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Establecer como grupo de lectores por defecto"))
		APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	End if 
	
	Case of 
		: (<>alBBL_GruposLectores{$l_filaSeleccionada}=<>vlBBL_GrupoLectorPorDefecto)
			APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Eliminar"))
			
		: (<>alBBL_GruposLectores{$l_filaSeleccionada}<=0)
			APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Eliminar"))
			
		: ($l_lectores>0)
			APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Eliminar"))
		Else 
			APPEND TO ARRAY:C911($at_itemsPopup;__ ("Eliminar"))
	End case 
	
	APPEND TO ARRAY:C911($at_itemsPopup;"(-")
	If (AT_GetSumArray (->al_NumeroLectoresMediaTrack)>0)
		APPEND TO ARRAY:C911($at_itemsPopup;__ ("Generar códigos de barra para todos los grupos..."))
	Else 
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Generar códigos de barra para todos los grupos..."))
	End if 
	If ($l_lectores>0)
		$t_item:=__ ("Generar códigos de barra para \"^0\"...")
		$t_item:=Replace string:C233($t_item;"^0";<>atBBL_GruposLectores{<>atBBL_GruposLectores})
		APPEND TO ARRAY:C911($at_itemsPopup;$t_item)
		APPEND TO ARRAY:C911($at_itemsPopup;"(-")
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Cambiar grupo de lectores por ..."))
		For ($i_TiposDocumento;1;Size of array:C274(<>atBBL_GruposLectores))
			APPEND TO ARRAY:C911($at_itemsPopup;"  "+<>atBBL_GruposLectores{$i_TiposDocumento})
		End for 
	Else 
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Generar códigos de barra para grupo..."))
		APPEND TO ARRAY:C911($at_itemsPopup;"(-")
		APPEND TO ARRAY:C911($at_itemsPopup;"("+__ ("Cambiar grupo de lectores por..."))
		For ($i_TiposDocumento;1;Size of array:C274(<>atBBL_GruposLectores))
			APPEND TO ARRAY:C911($at_itemsPopup;"(  "+<>atBBL_GruposLectores{$i_TiposDocumento})
		End for 
	End if 
End if 

$l_opcionUsuario:=IT_DynamicPopupMenu_Array (->$at_itemsPopup)
Case of 
	: ($l_opcionUsuario=1)  //nuevo
		BBLcfg_NuevoGrupoLectores 
		BBLcfg_Listbox_CodigosBarra 
		LISTBOX SORT COLUMNS:C916(lb_GruposLectores;1;>)
		$l_posicion:=Find in array:C230(<>alBBL_GruposLectores;$l_proximoID)
		LISTBOX SELECT ROW:C912(lb_GruposLectores;$l_posicion)
		OBJECT SET SCROLL POSITION:C906(lb_GruposLectores;$l_posicion)
		EDIT ITEM:C870(<>atBBL_GruposLectores;$l_posicion)
		
		
	: ($l_opcionUsuario=3)  // establecer  grupo de lectores por defecto 
		<>vlBBL_GrupoLectorPorDefecto:=<>alBBL_GruposLectores{<>atBBL_GruposLectores}
		BBLcfg_GuardaCambiosGruposLect 
		BBLcfg_Listbox_CodigosBarra 
		
	: ($l_opcionUsuario=5)  // eliminar
		AT_Delete ($l_filaSeleccionada;1;-><>atBBL_GruposLectores;-><>asBBL_AbrevGruposLectores;->al_NumeroLectoresMediaTrack;-><>alBBL_GruposLectores)
		BBLcfg_GuardaCambiosGruposLect 
		BBLcfg_Listbox_CodigosBarra 
		
	: ($l_opcionUsuario=7)  // generar todos los códigos de barra
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosNoProtegidos)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosProtegidos)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Barcode_Protegido:39=True:C214)
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
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("169/_Encabezado_con_codigosProtegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("172/btn1_TodosLosCodigos_estandar_y_protegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("174/btn2_SoloCodigos_NO_Protegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("175/btn3_SoloCodigos_Protegidos"))
				
			: ($l_registrosProtegidos>0)
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("169/_Encabezado_con_codigosProtegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("173/btn1_TodosLosCodigos_protegidos"))
				
			: ($l_registrosProtegidos=0)
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("170/_Encabezado_sincodigosProtegidos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("171/btn1_TodosLosCodigos_estandar"))
				
		End case 
		IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("176/btn4_Cancelar"))
		
		  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosNoProtegidos";String:C10($l_registrosNoProtegidos))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosProtegidos";String:C10($l_registrosProtegidos))
		$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_totalRegistros";String:C10($l_totalRegistros))
		
		  // Muestro el cuadro de diálogo de confirmación
		  // pasa en $t_textoLog el encabezado para el registro de actividades
		$t_Textolog:=""
		$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
		
		If ($l_opcionUsuario=0)
			  //nada, operacion cancelada
			CANCEL TRANSACTION:C241
		Else 
			
			SET QUERY AND LOCK:C661(True:C214)
			Case of 
				: ($l_opcionUsuario=1)  // regenerar códigos para todos los registros
					QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID:1;>;0)
					
				: ($l_opcionUsuario=2)  // regenerar codigos solo para códigos de barra estándar
					QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
					
				: ($l_opcionUsuario=3)  // regenerar códigos solo para códigos de barra personalizados
					QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Barcode_Protegido:39=True:C214)
					
			End case 
			
			If ((Records in set:C195("LockedSet")=0) & (Records in selection:C76([BBL_Lectores:72])>0))
				BBLpat_RegenerarCodigosDeBarra 
				VALIDATE TRANSACTION:C240
			Else 
				CD_Dlog (0;__ ("No es posible ejecutar esta operación en este momento.\rPor favor intente nuevamente más tarde."))
				CANCEL TRANSACTION:C241
			End if 
			SET QUERY AND LOCK:C661(False:C215)
			
		End if 
		
		
		
	: ($l_opcionUsuario=8)  // generar códigos de barra para el grupo de lectores seleccionado
		If (al_NumeroLectoresMediaTrack{<>atBBL_GruposLectores}>0)
			$t_nombreGrupoActual:=<>atBBL_GruposLectores{<>atBBL_GruposLectores}
			$l_idGrupoActual:=<>alBBL_GruposLectores{<>atBBL_GruposLectores}
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosNoProtegidos)
			QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37=$l_idGrupoActual;*)
			QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosProtegidos)
			QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37=$l_idGrupoActual;*)
			QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=True:C214)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$l_totalRegistros:=$l_registrosNoProtegidos+$l_registrosProtegidos
			
			  // inicio la transacción antes de mostrar el mensaje para evitar el registro en el log si la transacción debe
			  // ser cancelada debido a registros bloqueados en la selección resultante de la búsqueda.
			START TRANSACTION:C239
			
			  // Inicializo el componente IT_Confirmacion
			IT_Confirmacion_Inicializa 
			
			  //Cargo los elementos que se mostrarán en el mensaje de confirmación
			If (($l_registrosProtegidos>0) & ($l_registrosNoProtegidos>0))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("177/_encabezadoConCdigoPersonalizado"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("180/btn1_Regenerar_Todos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("181/btn2_Regenerar_Solo_NO_personalizados"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("179/btn0_Cancelar"))
			Else 
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("178/_encabezadoSinCodigoPersonalizado"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("180/btn1_Regenerar_Todos"))
				IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("179/btn0_Cancelar"))
			End if 
			
			
			  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosNoProtegidos";String:C10($l_registrosNoProtegidos))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_registrosProtegidos";String:C10($l_registrosProtegidos))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_totalRegistros";String:C10($l_totalRegistros))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_nombreGrupoActual";$t_nombreGrupoActual)
			
			  // Muestro el cuadro de diálogo de confirmación
			  // pasa en $t_textoLog el encabezado para el registro de actividades
			$t_Textolog:=""
			$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
			
			If ($l_opcionUsuario=0)
				  //nada, operacion cancelada
				CANCEL TRANSACTION:C241
			Else 
				
				SET QUERY AND LOCK:C661(True:C214)
				Case of 
					: ($l_opcionUsuario=1)
						QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_idGrupoActual)
						
					: ($l_opcionUsuario=2)
						QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_idGrupoActual;*)
						QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
				End case 
				If ((Records in set:C195("LockedSet")=0) & (Records in selection:C76([BBL_Lectores:72])>0))
					BBLpat_RegenerarCodigosDeBarra 
					VALIDATE TRANSACTION:C240
				Else 
					CD_Dlog (0;__ ("No es posible ejecutar esta operación en este momento.\rPor favor intente nuevamente más tarde."))
					CANCEL TRANSACTION:C241
				End if 
				SET QUERY AND LOCK:C661(False:C215)
				
			End if 
		End if 
		
	: ($l_opcionUsuario>10)
		$l_idGrupoActual:=<>alBBL_GruposLectores{<>atBBL_GruposLectores}
		$l_idGrupoReemplazo:=<>alBBL_GruposLectores{$l_opcionUsuario-10}
		BBLcfg_SustituyeGrupoLectores ($l_idGrupoActual;$l_idGrupoReemplazo)
End case 




