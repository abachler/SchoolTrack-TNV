//%attributes = {}
  // BBLcfg_SustituyeGrupoLectores()
  // Por: Alberto Bachler: 22/11/13, 12:32:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_BarcodeLectorConPrefijo;$b_regenerarCodigos)
C_LONGINT:C283($l_Error;$l_IdGrupoActual;$l_IdGrupoLectores_nuevo;$l_IdGrupoNuevo;$l_lectores;$l_lectoresBloqueados;$l_numeroLectores;$l_opcionUsuario)
C_TEXT:C284($t_grupoLectoresNuevo;$t_nombreGrupoActual;$t_prefijoActual;$t_prefijoNuevo;$t_Textolog)

If (False:C215)
	C_LONGINT:C283(BBLcfg_SustituyeGrupoLectores ;$1)
	C_LONGINT:C283(BBLcfg_SustituyeGrupoLectores ;$2)
End if 
C_LONGINT:C283($1;$2)



$l_IdGrupoActual:=$1
$l_IdGrupoNuevo:=$2

If ((($l_IdGrupoActual<0) | ($l_IdGrupoNuevo<0)) & (($l_IdGrupoActual>-5) & ($l_IdGrupoNuevo>-5)))
	ModernUI_Notificacion (__ ("Sustitución del grupo de lectores");__ ("No es posible sustituir los grupos de lectores reservados."))
	  // la restriccin de sustitucin solo aplica entre los grupos de lectores asignados por SchoolTrack
Else 
	$t_prefijoActual:=<>asBBL_AbrevGruposLectores{Find in array:C230(<>alBBL_GruposLectores;$l_IdGrupoActual)}
	$t_prefijoNuevo:=<>asBBL_AbrevGruposLectores{Find in array:C230(<>alBBL_GruposLectores;$l_IdGrupoNuevo)}
	$t_nombreGrupoActual:=<>atBBL_GruposLectores{Find in array:C230(<>alBBL_GruposLectores;$l_IdGrupoActual)}
	$t_grupoLectoresNuevo:=<>atBBL_GruposLectores{Find in array:C230(<>alBBL_GruposLectores;$l_IdGrupoNuevo)}
	$l_numeroLectores:=al_NumeroLectoresMediaTrack{Find in array:C230(<>alBBL_GruposLectores;$l_IdGrupoActual)}
	
	If ($t_prefijoActual#$t_prefijoNuevo)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectores)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_idGrupoActual;*)
		QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=False:C215;*)
		QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]BarCode_SinFormato:38;=;$t_prefijoActual+"@")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_lectores>0)
			  // inicio la transacción antes de mostrar el mensaje para evitar el registro en el log si la transacción debe
			  // ser cancelada debido a registros bloqueados en la selección resultante de la búsqueda.
			START TRANSACTION:C239
			
			  // Inicializo el componente IT_Confirmacion
			IT_Confirmacion_Inicializa 
			
			  //Cargo los elementos que se mostrarán en el mensaje de confirmación
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("183/_Encabezado"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("184/btn1_Cambiar_y_regenerarConNuevoPrefijo"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("185/btn2_Cambia_y_regenerarSinPrefijo"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("186/btn3_Cambiar_y_mantenerCodigo"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("187/btn4_Cancelar"))
			
			  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_numeroLectores";String:C10($l_numeroLectores))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_lectores";String:C10($l_lectores))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_nombreGrupoActual";$t_nombreGrupoActual)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_prefijoActual";$t_prefijoActual)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_prefijoNuevo";$t_prefijoNuevo)
			
			  // Muestro el cuadro de diálogo de confirmación
			  // pasa en $t_textoLog el encabezado para el registro de actividades
			$t_Textolog:=__ (" Cambio de grupo de lectores")
			$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
			
		Else 
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectores)
			QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_idGrupoActual;*)
			QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$t_titulo:=__ ("Usted solicitó sustituir un grupo de lectores por otro para un conjunto de lectores")
			$t_mensaje:=__ ("¿Está seguro de querer sustituir el grupo ^0 por ^1 en ^2 lectores?")
			$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_nombreGrupoActual;True:C214))
			$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_grupoLectoresNuevo;True:C214))
			$t_numeroRegistros:=String:C10($l_numerolectores)
			$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_numeroRegistros))
			$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Aceptar");__ ("Cancelar"))
			If ($l_opcionUsuario=1)
				$l_lectores:=0  // inicializo a 0 para que no se lleve a cabo la regeneracin de codigos de barra
				$l_opcionUsuario:=0
				START TRANSACTION:C239
			End if 
		End if 
	Else 
		$t_titulo:=__ ("Usted solicitó sustituir un grupo de lectores por otro para un conjunto de lectores")
		$t_mensaje:=__ ("¿Está seguro de querer sustituir el grupo ^0 por ^1 en ^2 lectores?")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_nombreGrupoActual;True:C214))
		$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_grupoLectoresNuevo;True:C214))
		$t_numeroRegistros:=String:C10($l_numerolectores)
		$t_mensaje:=Replace string:C233($t_mensaje;"^2";IT_SetTextStyle_Bold (->$t_numeroRegistros))
		$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Aceptar");__ ("Cancelar"))
		If ($l_opcionUsuario=1)
			START TRANSACTION:C239
		End if 
	End if 
	
	If ($l_opcionUsuario=0)
		  //nada, operacion cancelada
		CANCEL TRANSACTION:C241
	Else 
		REDUCE SELECTION:C351([BBL_Lectores:72];0)
		SET QUERY AND LOCK:C661(True:C214)
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_IdGrupoActual;*)
		QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Barcode_Protegido:39=False:C215)
		$l_lectoresBloqueados:=Records in set:C195("LockedSet")
		CREATE SET:C116([BBL_Lectores:72];"$cambioBarcode")
		
		If ($l_lectoresBloqueados=0)
			BBLcfg_CambioGrupoLectores ($l_IdGrupoNuevo;$t_grupoLectoresNuevo)
			If ($l_lectores=0)
				VALIDATE TRANSACTION:C240
			Else 
				Case of 
					: ($l_opcionUsuario=1)
						$b_BarcodeLectorConPrefijo:=<>bBBL_BarcodeLectorConPrefijo
						<>bBBL_BarcodeLectorConPrefijo:=True:C214
						BBLpat_RegenerarCodigosDeBarra 
						<>bBBL_BarcodeLectorConPrefijo:=$b_BarcodeLectorConPrefijo
					: ($l_opcionUsuario=2)
						$b_BarcodeLectorConPrefijo:=<>bBBL_BarcodeLectorConPrefijo
						<>bBBL_BarcodeLectorConPrefijo:=False:C215
						BBLpat_RegenerarCodigosDeBarra 
						<>bBBL_BarcodeLectorConPrefijo:=$b_BarcodeLectorConPrefijo
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


